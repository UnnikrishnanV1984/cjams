/*
   Issue Description: CDM-33587
   Category/ Module  : parent will not add to CPS case
   Root cause: Role update removed the person from cps case code will be handled as part of defect CIDM-7650
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/ 

update cjams.intakeservicerequestactor
set isprimary = false, updatedby = 'CDM-33587' , updatedon = now()
where intakeservicerequestactorid = '7705294c-6e4c-4587-87f7-a75afa51383e' and personid = 'add7f4c9-6026-4b95-9a2a-2afcd449e9cd';

update cjams.intakeservicerequestactor
set isprimary = true, updatedby = 'CDM-33587' , updatedon = now()
where intakeservicerequestactorid = 'c575d439-cfc9-415a-a3c9-8f1f4d96e76f' and personid = 'add7f4c9-6026-4b95-9a2a-2afcd449e9cd';