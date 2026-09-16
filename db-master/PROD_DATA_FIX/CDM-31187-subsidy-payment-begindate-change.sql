/*
   Issue Description: CDM-31187
   Category/ Module  :Agreement
   Root cause: user wnats to change the agreement startdate
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update adoptioncaseagreementrate set startdate ='2023-01-13 05:00:00',updatedby = 'CDM-31187',updatedon =now(),approvaldate =now() where adoptionagreementrateid ='e7e98da2-a6af-4700-bd71-dbeb7f5b87d5';

update adoptioncaserevision set startdate ='2023-01-13 05:00:00',updatedby = 'CDM-31187',updatedon =now() ,approvaldate = now()
where adoptionagreementrateid = 'e7e98da2-a6af-4700-bd71-dbeb7f5b87d5';
