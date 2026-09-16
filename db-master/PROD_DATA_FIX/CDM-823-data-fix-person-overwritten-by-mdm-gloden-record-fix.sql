--- updating person details overwritten by MDM log.

update cjams.person set 
firstname = 'MARIAH',
middlename = 'LARAINE',
lastname = 'SHOEMAKER',
dob = '2005-08-28T00:00:00',
ssnno = '236518228'
where personid = '043756f6-1b2b-4a51-9eab-083521772719';

update cjams.personidentifier set activeflag = 0 where personidentifierid = 'b884e6b3-dd28-4a59-b057-bdb7dfe99a56';

update cjams.personidentifier set activeflag = 1 where personidentifierid = '9acf2b8d-d52c-4260-9e0f-b8bd616210f0';