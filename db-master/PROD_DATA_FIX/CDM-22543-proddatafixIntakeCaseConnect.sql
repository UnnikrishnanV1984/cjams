/*
   Issue Description: CDM-22543
   Category/ Module  : Intake Case Connect fix
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from cjams.createservicecase('ad9c4c56-12fe-4b41-bd1d-4485d5761979' ,'fecea2d0-09c2-4ec3-8a71-e1bfd035c8d8', 0,'bacaf254-49bb-4df0-9ea1-c23cfd696d2a');


update intakedastaging set activeflag = 0, updatedby = 'CDM-22543', updatedon = now()
where intakenumber = 'I221010273972' and activeflag = 1;

update intakedastatus set activeflag = 0, updatedby = 'CDM-22543', updatedon = now()
where intakenumber = 'I221010273972';