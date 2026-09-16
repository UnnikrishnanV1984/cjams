/*
   Issue Description: CDM-23875
   Category/ Module  : Person
   Root cause: user requeseted to change last name 
   Pull request# for code fix: 
   Reason why no related code fix: this is a closed case that's why user requested data fix 
*/


update cjams.person set lastname='Abdullahi', updatedby='CDM-23875', updatedon=now() where personid='2f251d81-388a-4b3b-a88b-b37322fbc100';