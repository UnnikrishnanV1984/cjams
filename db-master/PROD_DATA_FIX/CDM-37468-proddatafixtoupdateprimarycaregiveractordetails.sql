/*
   Issue Description: CDM-37468
   Category/ Module  : Prod data fix to Update primary care giver actor details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update intakeservreqchildremoval set primarycaregiveractorid  = '56c69b83-0c30-4c8d-b57d-c073ebbaa31a', updatedby = 'CDM-37468', updatedon = now()
where intakeservreqchildremovalid = '0a4b3ccb-5a6a-43bb-ace8-7ab7cf976d7f';