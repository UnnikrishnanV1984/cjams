/*
   Issue Description: CDM-28052
   Category/ Module  : Unable to Close Investigation
   Root cause:We have been able to assign family responsibility to me but I am not able to click the "complete investigation" hyperlink to send it to my supervisor to approve/close.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/



update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-28052'
where intakeserviceid = '557a43c7-a0cc-4047-89db-cc20e5d22120';

 UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =1, 
servicerequesttypeconfigiddispostionid = 'e1005c79-c6d1-40c2-9a78-5b6845763bef',
updatedby = 'CDM-28052',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '5a814f7a-e3e7-47fc-91c0-e980ac7f7349';

--Case number: 202101170104864 --

