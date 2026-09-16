/*
   Issue Description: CDM-24311
   Category/ Module  :  Person
   Root cause: user requeseted to remove unknow persons and unable to add person
   Pull request# for code fix: 
   Reason why no related code fix: user error
*/



update person
set 
activeflag = 0,
updatedby = 'CDM-24311',
updatedon = now()
where
personid in ('d09e12fe-33c7-44c2-8f07-81bfc14ee406', 'a168369d-954d-4fe1-811e-58a257d20fd9');

update intakeservicerequestactor
set 
activeflag = 0,
updatedby = 'CDM-24311',
updatedon = now()
where
personid in ('d09e12fe-33c7-44c2-8f07-81bfc14ee406', 'a168369d-954d-4fe1-811e-58a257d20fd9');


update actor
set 
activeflag = 0,
updatedby = 'CDM-24311',
updatedon = now()
where
personid in ('d09e12fe-33c7-44c2-8f07-81bfc14ee406', 'a168369d-954d-4fe1-811e-58a257d20fd9');

update cjams.personrole set drugexposednewbornflag =0, updatedby ='CDM-24311', updatedon =now()where personroleid ='2c91790b-8aa8-448a-8285-7b77d4d4cdf0';



update cjams.personprogramarea set enddate ='2022-08-09 00:00:00.000', activeflag =0, updatedon =now(), updatedby ='CDM-24311'

where personprogramid ='2bce6861-1342-418c-beda-a7a48a9fade1';

update cjams.personprogramarea set enddate ='2022-08-09 00:00:00.000', activeflag =0, updatedon =now(), updatedby ='CDM-24311'

where personprogramid ='ef563d2f-da1f-441f-8f16-e80393bc23bc';