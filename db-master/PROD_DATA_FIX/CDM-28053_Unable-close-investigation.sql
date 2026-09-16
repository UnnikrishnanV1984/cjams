/*
   Issue Description: CDM-28053
   Category/ Module  : Unable to Close Investigation
   Root cause:We have been able to assign family responsibility to me but I am not able to click the "complete investigation" hyperlink to send it to my supervisor to approve/close.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da', updatedon= now(), updatedby='CDM-20827'
where intakeserviceid = 'cfb13857-a03d-40aa-89f5-3be5ecf87bb3';

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =1, 
servicerequesttypeconfigiddispostionid = 'e1005c79-c6d1-40c2-9a78-5b6845763bef',
updatedby = 'CDM-28053',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '2ab695d8-28c9-4ccc-8524-dd2c366df5d5';

--Case number: 211020153156 --