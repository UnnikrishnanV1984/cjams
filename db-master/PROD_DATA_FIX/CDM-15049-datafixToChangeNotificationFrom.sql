
/*
   Issue Description: CDM-15049
   Category/ Module  : Change user's notification from name  
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.usernotification 
set insertedby ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5', updatedby ='CDM-15049',updatedon = now(),
subject='Case Final Disbursement transaction Financial Approval Request for Client Name - "SAMANTHA SNELL" (Client Account "0004795728") has been assigned by "Barbara Kutchman"',
body='Case Final Disbursement transaction Financial Approval Request for Client Name - "SAMANTHA SNELL" (Client Account "0004795728") has been assigned by "Barbara Kutchman"'
where usernotificationid in ('521591de-be1d-4ec4-a062-ec6f1cbe9072');

update cjams.usernotificationmap 
set 	
	insertedby ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5', 
	fromsecurityusersid ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5',
	updatedby ='CDM-15049',
	updatedon =now()
where 
	usernotificationid in ('521591de-be1d-4ec4-a062-ec6f1cbe9072'); 