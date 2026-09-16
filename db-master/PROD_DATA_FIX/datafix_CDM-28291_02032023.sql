-- CDM-28291 - Notifications
/*
-- Issue Description:

Date/Time# 01/24/2023 , 3:39 PM	
Priority# Normal	
From# Shaina Boyd	
To# Sarah Grove	

Subject# Case Special Needs Trust Disbursement transaction Financial Approval Request for 
Client Name - "DREZDEN MOORE" (Client Account "0004795728") has been assigned by "Heather Heather"

---------------
/api/Usernotifications/getUserNotification

*/

select * from usernotification where 
securityusersid = '2744efa4-8129-48fb-b292-7c4351f66f89' and 
usernotificationid = 'fb232568-7d9e-4582-9328-04aec0daaf6e' and 
activeflag = 1;

update usernotification
set activeflag = 0,
	updatedby = 'CDM-28291',
	updatedon = now()
where securityusersid = '2744efa4-8129-48fb-b292-7c4351f66f89' and 
	  usernotificationid = 'fb232568-7d9e-4582-9328-04aec0daaf6e' and 
      activeflag = 1;

select * from usernotificationmap where 
tosecurityusersid = '2744efa4-8129-48fb-b292-7c4351f66f89' and 
usernotificationid = 'fb232568-7d9e-4582-9328-04aec0daaf6e' and 
activeflag = 1;

update usernotificationmap
set activeflag = 0,
	updatedby = 'CDM-28291',
	updatedon = now()
where tosecurityusersid = '2744efa4-8129-48fb-b292-7c4351f66f89' and 
	  usernotificationid = 'fb232568-7d9e-4582-9328-04aec0daaf6e' and 
	  activeflag = 1;