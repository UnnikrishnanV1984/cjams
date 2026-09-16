/*
   Issue Description: CDM-20480
   Category/ Module  :  Referral not generated 
   Root cause: user wants to delete intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
   intakeservicerequest
set
   activeflag = 0,
   updatedby = 'CDM-20480',
   updatedon = now()
where
   intakenumber = 'I221010240135'
   and activeflag = 1;


update
   routing
set
   activeflag = 0,
   updatedon = now(),
   updatedby = 'CDM-20480'
where
   objectid = 'I221010240135';


update
   intakedastaging
set
   activeflag = 0,
   updatedby = 'CDM-20480',
   updatedon = now()
where
   intakenumber = 'I221010240135'
   and activeflag = 1;


update
   intakedastatus
set
   activeflag = 0,
   updatedby = 'CDM-20480',
   updatedon = now()
where
   intakenumber = 'I221010240135'
   and activeflag = 1;


update
   intakesnapshot
set
   activeflag = 0,
   updatedon = now(),
   updatedby = 'CDM-20480'
where
   intakenumber = 'I221010240135';