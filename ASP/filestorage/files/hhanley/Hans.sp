%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Template for a SPARC file
%% Author: 
%% Description:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Re-identification MoC:\Users\Hans\ASPIDE-Workspace3\Example\paper.spdel 					 %
% Author: Hans Hanley                        %
% Date: 7/14/15                              %
%                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sorts
%Medical Database
#patient = {person1, person2,person3,person4,person5,
			person6,person7,person8,person9,person10,
			person11,person12,person13}.
%Medical Information

#count =[0..260].
#birthD = [0..365].
#insurance = {hMO, pPO, pOS}.
#gender = {male, female,naG}.
#race = {asian, black, white, hispanic}.
#symptoms = {cough,pain,lethargy, sniffle, fever,none}.
#diagnosis = {cold,hiv,cancer, diabetes,none}.
#medication = {pregnizone, combivir,radiation,chemo,insulin,none}.
#vitals = {good,bad,naV}.


%Company Database.
#employee = {paulSimon,jimReily,johnSmith, alexAnderson, allisonHarris,melissaMacDonald,halburtJohnson,
			samWilliams,ashleyBrown,jasonWilson,justinJackson,joseRew}.
#role = {salesman, janitor, hr, programmer, security, ceo, cfo, lawyer,coo}.
#salary =  {s100,s125,s150,s175,s200,s225,s250,s275,s300,s325,s350,s375,s400}.
#married = {married, single}.
#phone = {n5554193,n5553212,n5554871,n5556784,n5553567,n5559864,n5557648,n5558743,n5550912,n5559834,n5556784,n5550943}.
#password = {p12345,p23456,p34567,p45678,p56789,p67890,p78901,p89012,p90123,p01234,p09876,p98765}.
#zipcode = {z02108,z80123,z02203,z32818,z02111,z80211,z79401,z79415,z79407,z79421,z79432,z79441,na}.
#username = {johnS,melissaM, halburtJ, samW,ashleyB, jasonW,justinJ,alexA,allisonH,jimR,paulS,joseR}.
#shift ={s1,s2,s3}.
#address = {st1,st2,st3}.
#hireD= {h15,h55,h324,h347,h88,h37,h75,h145}.
#email = {johnSmith_aol_com,alexAnderson_aol_com,allisonHarris_aol_com,melissaMacDonald_aol_com,
		halburtJohnson_aol_com,samWilliams_aol_com,ashleyBrown_aol_com,jasonWilson_aol_com,justinJackson_aol_com,jimReily_aol_com,
		paulSimon_aol_com,joseRew_aol_com}.
#state = {massachusetts,texas,colorado,florida}.
#city = {boston,lubbock,denver,orlando}.

#knowledgetype = {defininte, safe_options, unsafe_options}.

%Definition of a person
#person= #employee+#patient.

%Collective information
#info =#birthD+#gender+#insurance+#race+#symptoms+#diagnosis
		+#medication+#vitals+#married+#phone+#zipcode+#state+#city+#hireD+
	#role+#salary+#username+#password+#insurance+#shift+#address+#email.%+#person.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
predicates
%Value assigns a sensitivity value to a category of information
value(#info,#count).

%Assigns a specific attribute to employee
attribute(#person,#info).

%Determines if two employees are acutally the same person
same(#employee,#employee,#patient).

%Determines if two employees are different people based on the given ksinglewledge
distinct(#employee,#employee,#patient).

%Determiness if two employees have the potential to be the same person
thrSame(#employee,#person,#person,#count).

%Determiness if two employees have the potential to be the same person
twoSame(#employee,#person,#person,#count).

%Determiness if two employees have the potential to be the same person
oneSame(#employee,#person,#person,#count).

%Stipulates whether a certain attribute is necessary for another piece of information
necessary(#info,#info).

%Gives first employee to see the specific information about another employee
query(#employee,#employee,#info).

total(#employee,#employee,#patient,#count).

% Ranks everything
ranking(#employee,#employee,#patient,#count).


%
count_attributes(#employee,#employee,#patient,#count).



%Maria's predicates
dbknow(#person, #info).
empknow(#employee, #info, #info).
testknow(#employee, #info, #info).
roleassignment(#role, #employee).
mquery(#role, #info, #info).
empquery(#employee,#info,#info).
know(#role, #info, #info).
expandInfo(#info, #info, #info).
modusPonens(#info, #info, #info).
sameType(#info, #info).
madeInference(#employee, #info, #info).
shouldntknow(#employee, #info, #info).
shouldntknowdetailed(#employee, #info, #info, #knowledgetype).
oneToManyRelationship(#info, #info).
safe(#employee,#info,#info).






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rules 
%generate
value(X,100):-#birthD(X).
value(X,50):-#gender(X).
value(X,66):-#insurance(X).
value(X,75):-#race(X).
value(X,50):- #married(X).
value(X,91):- #zipcode(X).
-value(X,Y):- not value(X,Y).


%It is necessary that patient have X in order to have Z.
necessary(cancer,chemo).
necessary(cold,cough).
necessary(bad,cancer).
necessary(sniffle,married).
necessary(fever,pregnizone).
necessary(diabetes,insulin).


attribute(X,massachusetts):-attribute(X,z02108).
attribute(X,massachusetts):-attribute(X,z02203).
attribute(X,massachusetts):-attribute(X,z02111).

attribute(X,texas):- attribute(X,z79415).
attribute(X,texas):- attribute(X,z79401).
attribute(X,texas):- attribute(X,z79407).
attribute(X,texas):- attribute(X,z79421).
attribute(X,texas):- attribute(X,z79432).
attribute(X,texas):- attribute(X,z79441).


attribute(X,colorado):- attribute(X,z80123).
attribute(X,colorado):- attribute(X,z80211).

attribute(X,florida):- attribute(X,z32818).

dbknow(X,Y):- attribute(X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%People in the medical database%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% person1 
attribute(person1,59).
attribute(person1,pOS).
attribute(person1,male).
attribute(person1,white).
attribute(person1,cough).
attribute(person1,pregnizone).
attribute(person1,bad).

attribute(person1,married).


%person2
attribute(person2, 178).
attribute(person2,z79415).
attribute(person2,pPO).
attribute(person2,black).
attribute(person2,pain).
attribute(person2,cancer).
attribute(person2,bad).
attribute(person2, single).


%person3
attribute(person3,93).
attribute(person3,z79415).
attribute(person3,male).
attribute(person3,white).
attribute(person3,fever).
attribute(person3,diabetes).
attribute(person3,insulin).
attribute(person3,bad).
attribute(person3,married).

%person4
attribute(person4,55).
attribute(person4,z79401).
attribute(person4,hMO).
attribute(person4,female).
attribute(person4,black).
attribute(person4,pain).
attribute(person4,cancer).
attribute(person4,chemo).
attribute(person4,bad).

%person5 
attribute(person5,40).
attribute(person5,z02108).
attribute(person5,hMO).
attribute(person5,asian).
attribute(person5, fever).
attribute(person5,cancer).
attribute(person5,radiation).
attribute(person2, bad).
attribute(person2, married).

%person6
attribute(person6,325).
attribute(person6,pPO).
attribute(person6,z79415).
attribute(person6,black).
attribute(person6,sniffle).
attribute(person6,hiv).
attribute(person6,combivir).
attribute(person6,bad).
attribute(person6,single).

%person7
attribute(person7,175).
attribute(person7,z02203).
attribute(person7,pOS).
attribute(person7,male).
attribute(person7,white).
attribute(person7,pain).
attribute(person7,hiv).
attribute(person7,combivir).
attribute(person7,bad).
attribute(person7,married).


%person8
attribute(person8,47).
attribute(person8,pPO).
attribute(person8,z32818).
attribute(person8,male).
attribute(person8,asian).
attribute(person8,lethargy).
attribute(person8,cold).
attribute(person8,pregnizone).
attribute(person8,good).
attribute(person8,married).

%person9
attribute(person9,259).
attribute(person9,z79401).
attribute(person9,female).
attribute(person9,hispanic).
attribute(person9,cough).
attribute(person9,diabetes).
attribute(person9,insulin).
attribute(person9,bad).
attribute(person9,single).

%person10
attribute(person10,132).
attribute(person10,z79401).
attribute(person10,pOS).
attribute(person10,male).
attribute(person10,hispanic).
attribute(person10,lethargy).
attribute(person10,cancer).
attribute(person10,radiation).
attribute(person10,good).
attribute(person10,single).

%person11
attribute(person11,356).
attribute(person11,z02111).
attribute(person11,hMO).
attribute(person11,male).
attribute(person11,pain).
attribute(person11,cold).
attribute(person11,none).
attribute(person11,good).
attribute(person11,single).

%person12
attribute(person12,267).
attribute(person12,z79401).
attribute(person12,male).
attribute(person12,hispanic).
attribute(person12,cough).
attribute(person12,cancer).
attribute(person12,chemo).
attribute(person12,good).
attribute(person12,married).

%person13
attribute(person13,178).
attribute(person13,z79407).
attribute(person13,hMO).
attribute(person13,female).
attribute(person13,asian).
attribute(person13,none).
attribute(person13,good).
attribute(person13,single).
%%%%%%%%%%%%%%%%%%%%%%%%%%People in the the the Business Database%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% john Smith 
attribute(johnSmith,salesman).
attribute(johnSmith,s200).
attribute(johnSmith,johnS).
attribute(johnSmith,s1).
attribute(johnSmith,hMO).
attribute(johnSmith,asian).
attribute(johnSmith,40).
attribute(johnSmith,male).
attribute(johnSmith,h15).
attribute(johnSmith,st1).
attribute(johnSmith,johnSmith_aol_com).
attribute(johnSmith,n5554193).
attribute(johnSmith,p12345).
attribute(johnSmith,z02108).
attribute(johnSmith,married).

%allison Harris 
attribute(allisonHarris,coo).
attribute(allisonHarris,s375).
attribute(allisonHarris,allisonH).
attribute(allisonHarris,pPO).
attribute(allisonHarris,black).
attribute(allisonHarris,s3).
attribute(allisonHarris,178).
attribute(allisonHarris, female).
attribute(allisonHarris, h75).
attribute(allisonHarris,st3).
attribute(allisonHarris, allisonHarris_aol_com).
attribute(allisonHarris, n5553212).
attribute(allisonHarris,p89012).
attribute(allisonHarris,z79415).
attribute(allisonHarris,single).


%alex Anderson 
attribute(alexAnderson,lawyer).
attribute(alexAnderson,s275).
attribute(alexAnderson,alexA).
attribute(alexAnderson, pOS).
attribute(alexAnderson,white).
attribute(alexAnderson, s2).
attribute(alexAnderson,93).
attribute(alexAnderson, female).
attribute(alexAnderson, h37).
attribute(alexAnderson, st2).
attribute(alexAnderson, alexAnderson_aol_com).
attribute(alexAnderson,n5554871).
attribute(alexAnderson,p90123).
attribute(alexAnderson, z80123).
attribute(alexAnderson,married).


%melissa MacDonald
attribute(melissaMacDonald,janitor).
attribute(melissaMacDonald,s150).
attribute(melissaMacDonald,melissaM).
attribute(melissaMacDonald,pPO).
attribute(melissaMacDonald,black).
attribute(melissaMacDonald,s2).
attribute(melissaMacDonald,325).
attribute(melissaMacDonald,p23456).
attribute(melissaMacDonald,female).
attribute(melissaMacDonald,z79415).
attribute(melissaMacDonald,h15).
attribute(melissaMacDonald,melissaMacDonald_aol_com).
attribute(melissaMacDonald,n5556784).
attribute(melissaMacDonald,st2).
attribute(melissaMacDonald,single).

%halburt Johnson
attribute(halburtJohnson,hr).
attribute(halburtJohnson,z02203).
attribute(halburtJohnson,s225).
attribute(halburtJohnson,halburtJ).
attribute(halburtJohnson,p34567).
attribute(halburtJohnson,pOS).
attribute(halburtJohnson,white).
attribute(halburtJohnson,s3).
attribute(halburtJohnson,175).
attribute(halburtJohnson,male).
attribute(halburtJohnson,h55).
attribute(halburtJohnson,halburtJohnson_aol_com).
attribute(halburtJohnson,n5553567).
attribute(halburtJohnson,st3).
attribute(halburtJohnson,single).

%sam Williams
attribute(samWilliams,programmer).
attribute(samWilliams,z32818).
attribute(samWilliams,s300).
attribute(samWilliams,samW).
attribute(samWilliams,p45678).
attribute(samWilliams,pPO).
attribute(samWilliams,asian).
attribute(samWilliams,47).
attribute(samWilliams, male).
attribute(samWilliams,s1).
attribute(samWilliams,h55).
attribute(samWilliams,samWilliams_aol_com).
attribute(samWilliams,n5559864).
attribute(samWilliams,st1).
attribute(samWilliams,married).

%ashley brown
attribute(ashleyBrown,security).
attribute(ashleyBrown,z79401).
attribute(ashleyBrown,s175).
attribute(ashleyBrown,ashleyB).
attribute(ashleyBrown,p56789).
attribute(ashleyBrown,hMO).
attribute(ashleyBrown,hispanic).
attribute(ashleyBrown,s2).
attribute(ashleyBrown,259).
attribute(ashleyBrown,female).
attribute(ashleyBrown,h324).
attribute(ashleyBrown,ashleyBrown_aol_com).
attribute(ashleyBrown,n5557648).
attribute(ashleyBrown,st2).
attribute(ashleyBrown,married).

%Jason Wilson
attribute(jasonWilson,ceo).
attribute(jasonWilson,z79407).
attribute(jasonWilson,s400).
attribute(jasonWilson,jasonW).
attribute(jasonWilson,p67890).
attribute(jasonWilson,pOS).
attribute(jasonWilson,hispanic).
attribute(jasonWilson,s3).
attribute(jasonWilson,347).
attribute(jasonWilson,male).
attribute(jasonWilson,h347).
attribute(jasonWilson,jasonWilson_aol_com).
attribute(jasonWilson,n5558743).
attribute(jasonWilson,st3).
attribute(jasonWilson,single).

%Justin Jackson
attribute(justinJackson, cfo).
attribute(justinJackson,z02111).
attribute(justinJackson,s325).
attribute(justinJackson,justinJ).
attribute(justinJackson,p78901).
attribute(justinJackson,hMO).
attribute(justinJackson,white).
attribute(justinJackson,s1).
attribute(justinJackson,356).
attribute(justinJackson,male).
attribute(justinJackson,h88).
attribute(justinJackson,justinJackson_aol_com).
attribute(justinJackson,n5550912).
attribute(justinJackson,st1).
attribute(justinJackson,married).

%Jim Reily
attribute(jimReily,salesman).
attribute(jimReily,z79407).
attribute(jimReily,s275).
attribute(jimReily,jimR).
attribute(jimReily,p01234).
attribute(jimReily,pOS).
attribute(jimReily,white).
attribute(jimReily,s2).
attribute(jimReily,male).
attribute(jimReily,34).
attribute(jimReily,h15).
attribute(jimReily,jimReily_aol_com).
attribute(jimReily,n5559834).
attribute(jimReily,st2).
attribute(jimReily,single).

%paul Simon
attribute(paulSimon,hr).
attribute(paulSimon,z80211).
attribute(paulSimon,s250).
attribute(paulSimon,paulS).
attribute(paulSimon,p09876).
attribute(paulSimon,pPO).
attribute(paulSimon, black).
attribute(paulSimon,s1).
attribute(paulSimon,54).
attribute(paulSimon,male).
attribute(paulSimon,h145).
attribute(paulSimon,n5556784).
attribute(paulSimon,paulSimon_aol_com).
attribute(paulSimon, st3).
attribute(paulSimon, single).

% JoseRew
attribute(joseRew,programmer).
attribute(joseRew,z79407).
attribute(joseRew,s275).
attribute(joseRew,joseR).
attribute(joseRew,p98765).
attribute(joseRew,hMO).
attribute(joseRew,209).
attribute(joseRew,male).
attribute(joseRew,hispanic).
attribute(joseRew,s3).
attribute(joseRew,h15).
attribute(joseRew,n5550943).
attribute(joseRew,joseRew_aol_com).
attribute(joseRew,st2).
attribute(joseRew,married).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%query Permissions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

query(X,X,I):- #employee(X),attribute(X,I).
%salesman Permissions
query(X,Y,I):- #employee(X),attribute(X,salesman),#shift(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,salesman),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,salesman),#phone(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,salesman),#gender(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,salesman),#birthD(I),attribute(Y,I).

%Janitor Permission
query(X,Y,I):- #employee(X),attribute(X,janitor),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,janitor),#gender(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,janitor),#birthD(I),attribute(Y,I).


%HR Permission
query(X,Y,I):- #employee(X),attribute(X,hr),#role(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#zipcode(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#race(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#shift(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#birthD(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#phone(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#address(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#hireD(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#gender(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,hr),#married(I),attribute(Y,I).

%Programmer Permissions
query(X,Y,I):- #employee(X),attribute(X,programmer),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,programmer),#username(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,programmer),#password(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,programmer),#gender(I),attribute(Y,I).


%Security Permissions
query(X,Y,I):- #employee(Y),attribute(X,security),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(Y),attribute(X,security),#shift(I),attribute(Y,I).
query(X,Y,I):- #employee(Y),attribute(X,security),#zipcode(I),attribute(Y,I).
query(X,Y,I):- #employee(Y),attribute(X,security),#phone(I),attribute(Y,I).
query(X,Y,I):- #employee(Y),attribute(X,security),#gender(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,security),#birthD(I),attribute(Y,I).

%CEO Permissions
query(X,Y,I):- #employee(X),attribute(X,ceo),#role(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#zipcode(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#race(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#shift(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#birthD(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#phone(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#address(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#hireD(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#gender(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#salary(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#username(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,ceo),#insurance(I),attribute(Y,I).


%CFO permisions
query(X,Y,I):- #employee(X),attribute(X,cfo),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,cfo),#phone(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,cfo),#salary(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,cfo),#zipcode(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,cfo),#gender(I),attribute(Y,I).


%COO Permissions
query(X,Y,I):- #employee(X),attribute(X,cfo),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,cfo),#shift(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,cfo),#zipcode(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,cfo),#phone(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,cfo),#gender(I),attribute(Y,I).


%Lawyer Permissions
query(X,Y,I):- #employee(X),attribute(X,lawyer),#email(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#insurance(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#role(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#race(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#gender(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#phone(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#hireD(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#gender(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#birthD(I),attribute(Y,I).
query(X,Y,I):- #employee(X),attribute(X,lawyer),#married(I),attribute(Y,I).


%same(P,X,X2):-query(P,X,W),query(P,X,Y),query(P,X,Z),query(P,X,G), #employee(X), attribute(X, W), 
	%attribute(X,Y), attribute(X,Z),attribute(X,G),not distinct(P,X,X2),
  % #patient(X2), attribute(X2,W), attribute(X2,Y), attribute(X2,Z), attribute(X2,G),
	%W!=Y,Y!=Z,W!=Z,G!=W,G!=Y,G!=Z.


%total(Q,E1,P1,T+D):-#count{A:query(Q,E1,A),attribute(E1,A),attribute(P1,A),value(A,V)}=T,#employee(E1),#patient(P1), not distinct(Q,E1,P1),oneSame(Q,E1,P1,D).
count_attributes(Q,E1,P1,T):-#count{V:oneSame(Q,E1,P1,V)}=T,not distinct(Q,E1,P1),T>0.
%add(P,X,X2,V+V1):-query(P,X,W), #employee(X), attribute(X, W), 
	%not distinct(P,X,X2),X!=X2,#patient(X2), attribute(X2,W), 
	%value(W,V1),add(P,X,X2,V).

%%%%%%%%%%%%%%%%%%%%%%%%%%Generate List of the Possibiliies%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% states wehther there is a possibility of two people being the same
%Three Same
thrSame(P,X,X2,D):-query(P,X,W),query(P,X,Y),query(P,X,Z),#employee(X), attribute(X, W), attribute(X,Y), attribute(X,Z),not distinct(P,X,X2),
    #patient(X2),attribute(X2,W), attribute(X2,Y), attribute(X2, Z),
	W!=Y,Y!=Z,W!=Z,value(W,V1),value(Y,V2),value(Z,V3),V1+V2+V3=D, not thrSame(P,X,X2,D2),D2<D.

%Two Same
twoSame(P,X,X2,D):-query(P,X,W),query(P,X,Y), #employee(X), attribute(X, W), 
	attribute(X,Y),not distinct(P,X,X2),X!=X2,#patient(X2), attribute(X2,W), 
	attribute(X2,Y),W!=Y,value(W,V1),value(Y,V2),V1+V2=D,not thrSame(P,X,X2,V).

%One Same
oneSame(P,X,X2,D):-query(P,X,W), #employee(X), attribute(X, W), 
	not distinct(P,X,X2),X!=X2,#patient(X2), attribute(X2,W), 
	value(W,V1),V1=D,not thrSame(P,X,X2,V1),not twoSame(P,X,X2,V2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%test-Prunes Away Possibilites%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-same(P,X,Y):- distinct(P,X,Y).
distinct(P,X,Y):-query(P,X,W), #employee(X), attribute(X,W),#patient(Y),
	attribute(Y,Z),#birthD(W),#birthD(Z),Z!=W.
distinct(P,X,Y):-query(P,X,W), #employee(X), attribute(X,W),#patient(Y),
	 attribute(Y,Z),#gender(W),#gender(Z),Z!=W.
distinct(P,X,Y):-query(P,X,W), #employee(X), attribute(X,W),#patient(Y),
	 attribute(Y,Z),#race(W),#race(Z),Z!=W.
distinct(P,X,Y):-query(P,X,W), #employee(X), attribute(X,W),#patient(Y),
	 attribute(Y,Z),#insurance(W),#insurance(Z),Z!=W.
distinct(P,X,Y):-query(P,X,W), #employee(X), attribute(X,W),#patient(Y),
	 attribute(Y,Z),#zipcode(W),#zipcode(Z),Z!=W.
distinct(P,X,Y):-query(P,X,W), #employee(X), attribute(X,W),#patient(Y),
	 attribute(Y,Z),#married(W),#married(Z),Z!=W.

%determines if there is esingleugh information from person P to come to the conclusion that two people are the same
%Determines to what degree a person found the correct person identification
% Anything beyond four gives the a large number of persons. 

ranking(Q,E,P,C):-thrSame(Q,E,P,C).
ranking(Q,E,P,C):-twoSame(Q,E,P,C).
ranking(Q,E,P,C):-oneSame(Q,E,P,C).

%Logical Rules
%Logical Rule 
% If X is necessary for Y and Y is true then, X must be true. 
%attribute(P,X):- necessary(X,Y), attribute(P,Y).

%Logical Rule 
%If Y is necessary for Z and X does not have Y, the X does not have Z. 
%-attribute(X,Z):- necessary(Y,Z),-attribute(X,Y).

%Logical Rule 
% If X and X2 are the same, then X has all the attributes of X2 that were previously unksinglewn
%attribute(X,A):- same(P,X,Y), attribute(Y,A).
%attribute(Y,A):- same(P,X,Y), attribute(X,A).



%Maria's Part

dbknow(Y,X):- dbknow(X,Y).
dbknow(J,S) :- dbknow(E,S), dbknow(E,J), #employee(E), #role(J), #salary(S).
dbknow(Z,S) :- dbknow(E,S), dbknow(E,Z), #employee(E), #zipcode(Z), #salary(S).
dbknow(EM,S) :- dbknow(E,EM), dbknow(E,S), #employee(E), #email(EM), #salary(S).
dbknow(G,S) :- dbknow(E,G), dbknow(E,S), #employee(E), #gender(G), #salary(S).
dbknow(R,S) :- dbknow(E,R), dbknow(E,S), #employee(E), #race(R), #salary(S).

%EVERYONE can mquery/knows about THEMSELF
empknow(E,E,X) :- dbknow(E,X).

%EVERYONE can know about the anonymous database
empknow(E,X,Y) :- dbknow(X,Y), #patient(X).

%CEO (not password)
mquery(ceo, E, J) :- #employee(E), #role(J).
mquery(ceo, E, Z) :- #employee(E), #zipcode(Z).
mquery(ceo, E, S) :- #employee(E), #salary(S).
mquery(ceo, E, U) :- #employee(E), #username(U).
mquery(ceo, E, H) :- #employee(E), #insurance(H).
mquery(ceo, E, R) :- #employee(E), #race(R).
mquery(ceo, E, SH) :- #employee(E), #shift(SH).
mquery(ceo, E, B) :- #employee(E), #birthD(B).
mquery(ceo, E, G) :- #employee(E), #gender(G).
mquery(ceo, E, HD) :- #employee(E), #hireD(HD).
mquery(ceo, E, EM) :- #employee(E), #email(EM).
mquery(ceo, E, PN) :- #employee(E), #phone(PN).
mquery(ceo, E, A) :- #employee(E), #address(A).

%COO (self, shift, email, zipcode)
mquery(coo, E, Z) :- #employee(E), #zipcode(Z).
mquery(coo, E, SH) :- #employee(E), #shift(SH).
mquery(coo, E, EM) :- #employee(E), #email(EM).

%CFO (self, phone, salary, zipcode)
mquery(cfo, E, Z) :- #employee(E), #zipcode(Z).
mquery(cfo, E, S) :- #employee(E), #salary(S).
mquery(cfo, E, PN) :- #employee(E), #phone(PN).

%LAWYER (self, insurance, race, gender, email, phone)
mquery(lawyer, E, H) :- #employee(E), #insurance(H).
mquery(lawyer, E, R) :- #employee(E), #race(R).
mquery(lawyer, E, G) :- #employee(E), #gender(G).
mquery(lawyer, E, EM) :- #employee(E), #email(EM).
mquery(lawyer, E, PN) :- #employee(E), #phone(PN).

mquery(lawyer, R, S) :- #race(R), #salary(S).

%SECURITY (self, shift, email, zipcode)
mquery(security, E, Z) :- #employee(E), #zipcode(Z).
mquery(security, E, SH) :- #employee(E), #shift(SH).
mquery(security, E, EM) :- #employee(E), #email(EM).

mquery(security, EM, S) :- #email(EM), #salary(S).

%PROGRAMMER (self, email, username, password)
mquery(programmer, E, U) :- #employee(E), #username(U).
mquery(programmer, E, PW) :- #employee(E), #password(PW).
mquery(programmer, E, EM) :- #employee(E), #email(EM).

%HR (not helathcare, salary, or password)
mquery(hr, E, J) :- #employee(E), #role(J).
mquery(hr, E, Z) :- #employee(E), #zipcode(Z).
mquery(hr, E, U) :- #employee(E), #username(U).
mquery(hr, E, R) :- #employee(E), #race(R).
mquery(hr, E, SH) :- #employee(E), #shift(SH).
mquery(hr, E, B) :- #employee(E), #birthD(B).
mquery(hr, E, G) :- #employee(E), #gender(G).
mquery(hr, E, HD) :- #employee(E), #hireD(HD).
mquery(hr, E, E) :- #employee(E), #email(EM).
mquery(hr, E, PN) :- #employee(E), #phone(PN).
mquery(hr, E, A) :- #employee(E), #address(A).

%mquery(hr, R, S) :- #race(R), #salary(S).
%mquery(hr, G, S) :- #gender(G), #salary(S).

%JANITOR (self, email)
mquery(janitor, E, EM) :- #employee(E), #email(EM).

%SALESMAN (self, shift, email, phone)
mquery(salesman, E,SH) :- #employee(E), #shift(SH).
mquery(salesman, E,EM) :- #employee(E), #email(EM).
mquery(salesman, E,PN) :- #employee(E), #phone(PN).

%JOB ASSIGNMENTS
roleassignment(J,E) :- dbknow(E,J), #employee(E), #role(J).

%employee can make the queries its role can
empquery(E,X,Y) :- mquery(J,X,Y), roleassignment(J,E).

%employee knows as much as all queries allow
know(J,X,Y) :- mquery(J,X,Y), dbknow(X,Y).

%an employee knows what their role knows
empknow(E,X,Z) :- know(J,X,Z), roleassignment(J,E).
-empknow(E,X,Z) :- -know(J,X,Z), roleassignment(J,E).

%----KNOWLEDGE BASE----
%SAME TYPE
sameType(X,Y) :- #employee(X), #employee(Y).
sameType(X,Y) :- #role(X), #role(Y).
sameType(X,Y) :- #zipcode(X), #zipcode(Y).
sameType(X,Y) :- #salary(X), #salary(Y).
sameType(X,Y) :- #insurance(X), #insurance(Y).
sameType(X,Y) :- #race(X), #race(Y).
sameType(X,Y) :- #shift(X), #shift(Y).
sameType(X,Y) :- #birthD(X), #birthD(Y).
sameType(X,Y) :- #gender(X), #gender(Y).
sameType(X,Y) :- #hireD(X), #hireD(Y).
sameType(X,Y) :- #email(X), #email(Y).
sameType(X,Y) :- #phone(X), #phone(Y).
sameType(X,Y) :- #address(X), #address(Y).
sameType(X,Y) :- #username(X), #username(Y).
sameType(X,Y) :- #password(X), #password(Y).
sameType(X,Y) :- #patient(X), #patient(Y).

%ONE TO MANY RELATIONSHIPS - EMP DATABASE
oneToManyRelationship(X,Y) :- #role(X), #employee(Y). 
	%many people can have the same role
oneToManyRelationship(X,Y) :- #role(X), #zipcode(Y).
	%the same role can be at multiple locations
oneToManyRelationship(X,Y) :- #role(X), #insurance(Y).
	%the same role can have multiple insurance
oneToManyRelationship(X,Y) :- #role(X), #race(Y). 
	%the same role can have multiple race
oneToManyRelationship(X,Y) :- #role(X), #shift(Y). 
	%the same role can have multiple shifts
oneToManyRelationship(X,Y) :- #role(X), #birthD(Y). 
	%the same role can have multiple birthDs
oneToManyRelationship(X,Y) :- #role(X), #gender(Y). 
	%the same role can have multiple gender
oneToManyRelationship(X,Y) :- #role(X), #hireD(Y).
	%the same role can have multiple hireD
oneToManyRelationship(X,Y) :- #role(X), #email(Y).
	%the same role can have multiple email
oneToManyRelationship(X,Y) :- #role(X), #phone(Y).
	%the same role can have multiple phone numbers
oneToManyRelationship(X,Y) :- #role(X), #address(Y).
	%the same role can have multiple address
oneToManyRelationship(X,Y) :- #role(X), #username(Y). 
	%the same role can have multiple usernames
oneToManyRelationship(X,Y) :- #role(X), #password(Y).
	%the same role can have multiple passwords

oneToManyRelationship(X,Y) :- #zipcode(X), #employee(Y). 
	%many people can live in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #role(Y). 
	%many roles can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #salary(Y). 
	%many salaries can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #insurance(Y). 
	%many insurance plans can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #race(Y). 
	%many races can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #shift(Y). 
	%many shifts can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #birthD(Y). 
	%many birthdays can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #gender(Y). 
	%many genders can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #hireD(Y). 
	%many hirdates can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #email(Y). 
	%many emails can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #phone(Y). 
	%many phone numbers can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #address(Y). 
	%many addresses can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #username(Y). 
	%many usernames can be in the same zipcode code
oneToManyRelationship(X,Y) :- #zipcode(X), #password(Y). 
	%many passwords can be in the same zipcode code

oneToManyRelationship(X,Y) :- #salary(X), #employee(Y). 
	%many people can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #role(Y). 
	%many roles can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #zipcode(Y). 
	%many zipcodecodes can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #insurance(Y). 
	%many helathcare plans can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #race(Y). 
	%many race can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #shift(Y). 
	%many shifts can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #birthD(Y). 
	%many birthD plans can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #gender(Y). 
	%many gender can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #hireD(Y). 
	%many hireD can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #email(Y). 
	%many emails plans can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #phone(Y). 
	%many phones can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #address(Y). 
	%many addresses can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #username(Y). 
	%many username can have the salary
oneToManyRelationship(X,Y) :- #salary(X), #password(Y). 
	%many passwords can have the salary

oneToManyRelationship(X,Y) :- #insurance(X), #employee(Y). 
	%many people can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #role(Y). 
	%many roles can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #zipcode(Y). 
	%many zipcodecodes can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #salary(Y). 
	%many salaries can have the same insurance
oneToManyRelationship(X,Y) :- #insurance(X), #race(Y). 
	%many race can have the helathcare
oneToManyRelationship(X,Y) :- #insurance(X), #shift(Y). 
	%many shifts can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #birthD(Y). 
	%many birthDs can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #gender(Y). 
	%many gender can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #hireD(Y). 
	%many hireD can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #email(Y). 
	%many emails plans can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #phone(Y). 
	%many phones can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #address(Y). 
	%many addresses can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #username(Y). 
	%many username can have the insurance
oneToManyRelationship(X,Y) :- #insurance(X), #password(Y). 
	%many passwords can have the insurance

oneToManyRelationship(X,Y) :- #race(X), #employee(Y). 
	%many people can have the race
oneToManyRelationship(X,Y) :- #race(X), #role(Y). 
	%many roles can have the race
oneToManyRelationship(X,Y) :- #race(X), #zipcode(Y). 
	%many zipcodecodes can have the race
oneToManyRelationship(X,Y) :- #race(X), #salary(Y). 
	%many salaries can have the race
oneToManyRelationship(X,Y) :- #race(X), #insurance(Y). 
	%many insurance plans can have the same race
oneToManyRelationship(X,Y) :- #race(X), #shift(Y). 
	%many shifts can have the race
oneToManyRelationship(X,Y) :- #race(X), #birthD(Y). 
	%many birthDs can have the race
oneToManyRelationship(X,Y) :- #race(X), #gender(Y). 
	%many gender can have the race
oneToManyRelationship(X,Y) :- #race(X), #hireD(Y). 
	%many hireD can have the race
oneToManyRelationship(X,Y) :- #race(X), #email(Y). 
	%many emails plans can have the race
oneToManyRelationship(X,Y) :- #race(X), #phone(Y). 
	%many phones can have the race
oneToManyRelationship(X,Y) :- #race(X), #address(Y).
	%many addresses can have the race
oneToManyRelationship(X,Y) :- #race(X), #username(Y). 
	%many username can have the race
oneToManyRelationship(X,Y) :- #race(X), #password(Y). 
	%many passwords can have the race

oneToManyRelationship(X,Y) :- #shift(X), #employee(Y). 
	%many people can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #role(Y). 
	%many roles can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #zipcode(Y). 
	%many zipcodecodes can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #salary(Y). 
	%many salaries can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #insurance(Y). 
	%many insurance plans can have the same shift
oneToManyRelationship(X,Y) :- #shift(X), #race(Y). 
	%many races can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #birthD(Y). 
	%many birthDs can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #gender(Y). 
	%many gender can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #hireD(Y). 
	%many hireD can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #email(Y). 
	%many emails plans can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #phone(Y). 
	%many phones can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #address(Y).
	%many addresses can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #username(Y). 
	%many username can have the shift
oneToManyRelationship(X,Y) :- #shift(X), #password(Y). 
	%many passwords can have the shift

oneToManyRelationship(X,Y) :- #birthD(X), #employee(Y). 
	%many people can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #role(Y). 
	%many roles can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #zipcode(Y). 
	%many zipcodecodes can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #salary(Y). 
	%many salaries can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #insurance(Y). 
	%many insurance plans can have the same birthD
oneToManyRelationship(X,Y) :- #birthD(X), #race(Y). 
	%many races can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #shift(Y). 
	%many shifts can have the birthday
oneToManyRelationship(X,Y) :- #birthD(X), #gender(Y). 
	%many gender can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #hireD(Y). 
	%many hireD can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #email(Y). 
	%many emails plans can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #phone(Y). 
	%many phones can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #address(Y).
	%many addresses can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #username(Y). 
	%many username can have the birthD
oneToManyRelationship(X,Y) :- #birthD(X), #password(Y). 
	%many passwords can have the birthD

oneToManyRelationship(X,Y) :- #gender(X), #employee(Y). 
	%many people can have the same gender
oneToManyRelationship(X,Y) :- #gender(X), #role(Y). 
	%many roles can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #zipcode(Y). 
	%many zipcodecodes can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #salary(Y). 
	%many salaries can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #insurance(Y). 
	%many insurance plans can have the same gender
oneToManyRelationship(X,Y) :- #gender(X), #race(Y). 
	%many races can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #shift(Y). 
	%many shifts can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #birthD(Y). 
	%many birthDs can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #hireD(Y). 
	%many hireD can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #email(Y). 
	%many emails plans can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #phone(Y). 
	%many phones can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #address(Y).
	%many addresses can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #username(Y). 
	%many username can have the gender
oneToManyRelationship(X,Y) :- #gender(X), #password(Y). 
	%many passwords can have the gender

oneToManyRelationship(X,Y) :- #hireD(X), #employee(Y). 
	%many people can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #role(Y). 
	%many roles can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #zipcode(Y). 
	%many zipcodecodes can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #salary(Y). 
	%many salaries can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #insurance(Y). 
	%many insurance plans can have the same hireD
oneToManyRelationship(X,Y) :- #hireD(X), #race(Y). 
	%many races can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #shift(Y). 
	%many shifts can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #birthD(Y). 
	%many birthDs can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #gender(Y). 
	%many gender can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #email(Y). 
	%many emails plans can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #phone(Y). 
	%many phones can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #address(Y).
	%many addresses can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #username(Y). 
	%many username can have the hireD
oneToManyRelationship(X,Y) :- #hireD(X), #password(Y). 
	%many passwords can have the hireD

%ONE TO ONE RELATIONSHIPS - EMP DATABASE
%person has one role
%person has one zipcode code
%person has one username
%username has one person
%person has one password
%password only has one person
%person has one gender
%person has one hireD
%person has one email
%email has one person
%person has one phone number
%phone number has one person
%person has one address
%person has one insurance
%person has one race
%person has one shift
%person has one birthD
%address only has one person
%role has one salary

%----INFERENCE-----
%X,Y and -Y,Z --> -X,Z
-empknow(E,X,Z):- empknow(E,X,Y), -empknow(E,Y,Z), not empquery(E,X,Z).

%-X,Y and Y,Z --> -X,Z
%-empknow(E,X,Z):- expandInfo(X,Y,Z), -empknow(E,X,Y), empknow(E,Y,Z), not empquery(E,X,Z).
-empknow(E,X,Z):- -empknow(E,X,Y), empknow(E,Y,Z), not empquery(E,X,Z).

%if we know a base fact, then all other base facts of the same type are false
%(if you can have only one)
-empknow(E,X,Y2) :- empknow(E,X,Y1), not empknow(E,X,Y2), Y1 != Y2, not oneToManyRelationship(X,Y1), sameType(Y, Y1), sameType(Y1,Y2).

%note if we have knowledge (via if we know -statements)
madeInference(E,X1,Y1) :- -empknow(E,X2,Y2), sameType(X1,X2), sameType(Y1,Y2).

%----DETERMINE IF SOMEONE KNOWS SOMETHING THEY SHOULDN'T----
%shouldn't know if they can't directly make the mquery
shouldntknow(E,X,Y) :- not -empknow(E,X,Y), not empknow(E,X,Y), not empquery(E,X,Y), madeInference(E,X,Y), not oneToManyRelationship(X,Y).

%3 or more options is safe number to infer (except for categories with less than two options)
safe(E,X,Y) :- shouldntknow(E,X,Y1), shouldntknow(E,X,Y2), shouldntknow(E,X,Y3), Y1!=Y2, Y1!=Y3, Y2!=Y3, sameType(Y1,Y2), sameType(Y1,Y3), sameType(Y,Y1).

%categorize logic
shouldntknowdetailed(E,X,Y,unsafe_options) :- not safe(E,X,Y), shouldntknow(E,X,Y), shouldntknow(E,X,Z), Y!=Z, sameType(Y,Z).
shouldntknowdetailed(E,X,Y,safe_options) :- safe(E,X,Y), shouldntknow(E,X,Y), shouldntknow(E,X,Z), Y!=Z, sameType(Y,Z).
shouldntknowdetailed(E,X,Y,defininte) :- shouldntknow(E,X,Y),not shouldntknowdetailed(E,X,Y,safe_options),not shouldntknowdetailed(E,X,Y,unsafe_options).




