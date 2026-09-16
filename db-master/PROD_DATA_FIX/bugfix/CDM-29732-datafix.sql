/*
   Issue Description: CDM-29732
      Category/ Module  : Removal error
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: Draft status removal

  */

update intakeservreqchildremoval 
set
activeflag = 0,
updatedby = 'CDM-29732',
updatedon = now()
where 
intakeservreqchildremovalid='5782ef8d-c85d-4b57-b57f-9b72e5e83fa1'