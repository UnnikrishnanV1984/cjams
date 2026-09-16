/*
   Issue Description: CDM-23839
   Category/ Module  :  Assignment 
   Root cause: user requested to end date
   Pull request# for code fix: No change in code
   Reason why no related code fix: 
*/



update cjams.personprogramarea set enddate ='2022-05-11 00:00:00.000', updatedby ='CDM-23839', updatedon =now()

where personprogramid ='c53a9634-dd44-4408-bc9d-9bb65c987200';


update cjams.personprogramarea set enddate =null, updatedby ='CDM-23839', updatedon =now()

where personprogramid ='a0fecf2d-0f90-4fc4-8cbb-2eeea83191f0';
