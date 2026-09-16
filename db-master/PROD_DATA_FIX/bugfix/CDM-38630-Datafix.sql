/*
   Issue Description: CDM-38630
   Category/ Module  : Case assignment
   Root cause: data fix to change the response timer dropdown value  TO "Initial contact with family would place child's safety at risk"
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VISR', updatedby ='CDM-38630',updatedon =now()
where intakeserviceid ='2a859c8c-7954-4856-ac09-848cd0d5fa4e'
and cpsresponsetimeractionsid= 'def0fd9e-42d9-47a9-bd3d-5831432f16db';
