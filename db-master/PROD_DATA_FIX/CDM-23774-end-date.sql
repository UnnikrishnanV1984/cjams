/*
   Issue Description: CDM-23774
   Category/ Module  :  Assignment 
   Root cause: user requested to end date
   Pull request# for code fix: No change in code
   Reason why no related code fix: 
*/
update cjams.personprogramarea set enddate ='2022-05-12 00:00:00.000', updatedby ='CDM-23774', updatedon =now()

where personprogramid ='cd2c4c45-ba14-4afb-8501-e527f94ae684';