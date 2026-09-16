/*
   Issue Description: CDM-28051
   Category/ Module  : Unable to Close Investigation
   Root cause:We have been able to assign family responsibility to me but I am not able to click the "complete investigation" hyperlink to send it to my supervisor to approve/close.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-28051'
where intakeserviceid = '67f426de-3605-4c33-91ea-b2261b2f747b';

--Case number: 202101230106109 --


    UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =1, 
servicerequesttypeconfigiddispostionid = 'e1005c79-c6d1-40c2-9a78-5b6845763bef',
updatedby = 'CDM-28051',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '6cb18053-56ae-4dfa-9958-c5e0e2400ddb';
