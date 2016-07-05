DROP TABLE IF EXISTS FolderContains;
DROP TABLE IF EXISTS HasAccess;
DROP TABLE IF EXISTS Folder;
DROP TABLE IF EXISTS File;
DROP TABLE IF EXISTS User;

CREATE TABLE IF NOT EXISTS User
(
Username VARCHAR(50) PRIMARY KEY,
Email VARCHAR(50) NOT NULL,
Password VARCHAR(50) NOT NULL
);

INSERT INTO User VALUES (".", ".", ".");
INSERT INTO User(Username, Email, Password) VALUES("christian", "christian@jhu.edu", "password");
INSERT INTO User(Username, Email, Password) VALUES("mbathio", "mbathio@min.edu", "1234567");
INSERT INTO User(Username, Email, Password) VALUES("emanuel", "emanuel@pr.edu", "ema");
INSERT INTO User(Username, Email, Password) VALUES("drzhang", null, "panguine");
INSERT INTO User(Username, Email, Password) VALUES(null, "jason@jhu.edu", "mynameisjason");

CREATE TABLE IF NOT EXISTS Folder
(
FolderUrl VARCHAR(255) PRIMARY KEY,
FolderName VARCHAR(50) NOT NULL,
DateCreated DATE NOT NULL,
Owner VARCHAR(50) NOT NULL,
ParentUrl VARCHAR(255),
FOREIGN KEY (ParentUrl) REFERENCES Folder(FolderUrl)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
FOREIGN KEY (Owner) REFERENCES User(Username)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO Folder VALUES("christian/", "christian", CURDATE(), 
    (SELECT Username FROM User WHERE Username="christian"), null);
INSERT INTO Folder VALUES("christian/proj/", "proj", CURDATE(),
    (SELECT Username FROM User WHERE Username="christian"),
    (SELECT F.FolderUrl 
        FROM (SELECT * FROM Folder) AS F 
        WHERE F.FolderUrl = "christian/"));
INSERT INTO Folder VALUES("emanuel/", "emanuel", CURDATE(), 
    (SELECT Username FROM User WHERE Username="emanuel"),
    null);
INSERT INTO Folder VALUES("mbathio/", "mbathio", CURDATE(), 
    (SELECT Username FROM User WHERE Username="mbathio"),
    null);
INSERT INTO Folder VALUES("mbathio/bro/", "bro", CURDATE(), 
    (SELECT Username FROM User WHERE Username="mbathio"),
    (SELECT F.FolderUrl
        FROM (SELECT * FROM Folder) AS F
        WHERE F.FolderUrl = "mbathio/"));
INSERT INTO Folder VALUES("mbathio/bro/b", "b", CURDATE(), 
    (SELECT Username FROM User WHERE Username="mbathio"),
    (SELECT F.FolderUrl
        FROM (SELECT * FROM Folder) AS F
        WHERE F.FolderUrl = "mbathio/bro/"));


CREATE TABLE IF NOT EXISTS File
(
FileUrl VARCHAR(255) PRIMARY KEY,
FileName VARCHAR(50) NOT NULL,
DateCreated DATE NOT NULL,
Owner VARCHAR(50) NOT NULL
); 

INSERT INTO File VALUES(".", ".", CURDATE(), 
    (SELECT Username FROM User WHERE Username="."));
INSERT INTO File VALUES("christian/shuttle.sp", "shuttle.sp", CURDATE(),
    (SELECT Username FROM User WHERE Username="christian"));
INSERT INTO File VALUES("christian/family.sp", "family.sp", CURDATE(),
    (SELECT Username FROM User WHERE Username="christian"));
INSERT INTO File VALUES("christian/proj/theory.sp", "theory.sp", 
    CURDATE(), (SELECT Username FROM User WHERE Username="christian"));
INSERT INTO File VALUES("christian/proj/goal.sp", "goal.sp", CURDATE(),
    (SELECT Username FROM User WHERE Username="christian"));
INSERT INTO File VALUES("christian/proj/planner.sp", "planner.sp", 
    CURDATE(), (SELECT Username FROM User WHERE Username="christian"));
INSERT INTO File VALUES("mbathio/bro/bro.sp", "bro.sp", CURDATE(),
    (SELECT Username FROM User WHERE Username="mbathio"));


CREATE TABLE IF NOT EXISTS FolderContains
(
FolderURL VARCHAR(50) NOT NULL,
FileURL VARCHAR(50) NOT NULL,
PRIMARY KEY (FolderURL, FileURL),
FOREIGN KEY (FolderURL) REFERENCES Folder(FolderURL)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
FOREIGN KEY (FileURL) REFERENCES File(FileURL)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


INSERT INTO FolderContains VALUES(
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/shuttle.sp")
);
INSERT INTO FolderContains VALUES(
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/family.sp")
);
INSERT INTO FolderContains VALUES(
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/proj/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/proj/theory.sp")
);
INSERT INTO FolderContains VALUES(
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/proj/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/proj/goal.sp")
);
INSERT INTO FolderContains VALUES(
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/proj/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/proj/planner.sp")
);
INSERT INTO FolderContains VALUES(
    (SELECT FolderURL FROM Folder WHERE FolderURL="mbathio/bro/"),
    (SELECT FileURL FROM File WHERE FileURL="mbathio/bro/bro.sp")
);


CREATE TABLE IF NOT EXISTS HasAccess
(
Username VARCHAR(50) NOT NULL,
FolderURL VARCHAR(50) NOT NULL,
FileURL VARCHAR(50),
Permission INTEGER NOT NULL,
PRIMARY KEY (Username, FolderURL, FileURL),
FOREIGN KEY (Username) REFERENCES User(Username)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
FOREIGN KEY (FolderURL) REFERENCES Folder(FolderURL)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
FOREIGN KEY (FileURL) REFERENCES File(FileURL)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="christian"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/"),
    (SELECT FileURL FROM File WHERE FileURL="."), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="christian"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/shuttle.sp"), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="christian"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/proj/"),
    (SELECT FileURL FROM File WHERE FileURL="."), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="christian"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/proj/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/proj/theory.sp"), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="christian"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/proj/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/proj/planner.sp"), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="christian"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="christian/proj/"),
    (SELECT FileURL FROM File WHERE FileURL="christian/proj/goal.sp"), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="mbathio"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="mbathio/"),
    (SELECT FileURL FROM File WHERE FileURL="."), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="mbathio"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="mbathio/bro/"),
    (SELECT FileURL FROM File WHERE FileURL="."), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="emanuel"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="emanuel/"),
    (SELECT FileURL FROM File WHERE FileURL="."), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="emanuel"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="mbathio/bro/"),
    (SELECT FileURL FROM File WHERE FileURL="mbathio/bro/bro.sp"), 
    1);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="christian"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="mbathio/bro/"),
    (SELECT FileURL FROM File WHERE FileURL="mbathio/bro/bro.sp"),
    2);
INSERT INTO HasAccess VALUES(
    (SELECT Username FROM User WHERE Username="mbathio"),
    (SELECT FolderURL FROM Folder WHERE FolderURL="mbathio/bro/"),
    (SELECT FileURL FROM File WHERE FileURL="mbathio/bro/bro.sp"),
    2);
