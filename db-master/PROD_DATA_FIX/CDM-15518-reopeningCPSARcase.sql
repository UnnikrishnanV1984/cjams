/*
   Issue Description: CDM-15518
   Category/ Module  :  
   Root cause: Reopen CPS case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--2021-07-28 11:34:45 7995cecb-062d-406c-8ea9-b1da4b1877d8
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-15515'
where intakeserviceid = '0e7ecd0b-7a47-432a-939c-587e027a3309';


update  Intakeservicerequestdispositioncode set activeflag = 0,updatedon = now(), updatedby = 'CDM-15518' where intakeservicerequestdispositioncodeid = '4ffefdef-7840-4840-8a37-94f8b59b945b'
