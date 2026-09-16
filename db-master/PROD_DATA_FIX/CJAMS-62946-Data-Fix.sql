/*
   Issue Description: CJAMS-62946
   Category/ Module  : 
   Root cause: User Request, user want to remove intake from pending dashboard.
   Also, these referral are old data migrated from the lagecy system so some status was missing (which needed for current system),
   leading to be those intake on user pending dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/ 
--CW2507797
update routing
set activeflag = 0,
	updatedby = 'CJAMS-62946',
	updatedon = now()
where routingid = '0e2adb09-aa01-4443-94df-02b77ff49430'
	and activeflag =1;

--'CW9319310','CW2507797' are in pending status
update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-58207', 
	updatedon = now() 
where intakenumber in ('CW9319310','CW2507797') and activeflag = 1;