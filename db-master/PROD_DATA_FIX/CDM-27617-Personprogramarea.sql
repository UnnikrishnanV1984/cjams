/*
   Issue Description: CDM-27617
   Category/ Module  :  personprogramarea
   Root cause: user closed case before closing perperson program area 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--updatedby --> cce01557-161b-4f7e-b727-2a17a069b684

update cjams.personprogramarea set enddate ='2022-11-16 10:46:19', updatedby ='CDM-27617', updatedon = now ()

where personprogramid ='056d3c4e-a7cf-4213-8e48-adca32aa965c';

-- One more record need to update as per the defect 

update cjams.personprogramarea set enddate ='2022-11-16 10:46:19', updatedby ='CDM-27617', updatedon = now ()

where personprogramid ='d4427f05-4bda-4325-b038-97d8d2b7b2af';