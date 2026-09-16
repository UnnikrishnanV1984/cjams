/*
   Issue Description: CDM-30092
   Category/ Module  : user notification 
   Root cause: user got the notification with different user approved by
   Pull request# for code fix: 8555
   Reason why no related code fix: 
    requested a data fix and code fix to resolve
*/
update cjams.usernotification 
set insertedby ='74542e14-b26d-4824-ac24-dae0b75fc8e0', updatedby ='CDM-30092'
where usernotificationid ='aee276f8-e09d-465d-a04d-0b823a594aa0';

update cjams.usernotificationmap 
set insertedby ='74542e14-b26d-4824-ac24-dae0b75fc8e0', 
	fromsecurityusersid ='2744efa4-8129-48fb-b292-7c4351f66f89',
	updatedby ='CDM-30092',
	updatedon =now()
where usernotificationid ='aee276f8-e09d-465d-a04d-0b823a594aa0';

UPDATE cjams.usernotification
SET subject='Case Final Disbursement transaction Payment Approval Request for Client Name - "JAYDEN MCNALLY" (Client Account "0004795728") has been approved by Sarah Grove' 
WHERE usernotificationid='aee276f8-e09d-465d-a04d-0b823a594aa0'::uuid;