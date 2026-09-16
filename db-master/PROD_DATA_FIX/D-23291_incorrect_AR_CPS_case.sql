--D-23291 Dashboard This case should be deleted, the Intake was a screen out and it looks like an AR was opened, case says closed. 

--update  related intakeservicerequest table 
UPDATE intakeservicerequest  
SET   actiontype = null
, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000'
, activeflag = 0
,updatedby = 'admin-D-23291'
,updatedon = now() 
WHERE  servicerequestnumber = '20190319013778'
and intakeserviceid = 'cc6d21be-9a38-4f98-bfb0-bb9cf6f568b1'
and intakenumber = 'I201900555618'
and activeflag =1;