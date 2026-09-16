/*
   Issue Description: CDM-36358
   Category/ Module  : Approval Inbox 
   Root cause: Pending assessment approval records for screened out case.
   Fix: Data fix to remove the approval records as per user request
   Pull request# for code fix: 
   Reason why no related code fix: 
*/



select * from routing 
where objectid in ('3d5c3c6a-b931-4e4d-8115-f92e6db44974', '0477946e-a8d6-4d2f-b29f-5e750172b72a') 
and activeflag = 1;


UPDATE routing 
	set activeflag = 0,
		updatedby = 'CDM-36358',
		updatedon = now()
	WHERE objectid in ('3d5c3c6a-b931-4e4d-8115-f92e6db44974', '0477946e-a8d6-4d2f-b29f-5e750172b72a') 
		and activeflag = 1;
	



