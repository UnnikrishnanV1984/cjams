/*
   Issue Description: CDM-23453
   Category/ Module  : duplicate removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/

UPDATE Intakeservreqchildremoval
	SET activeflag = 0, 
		updatedby = 'CDM-23453',
		updatedon = now() 
	WHERE intakeservreqchildremovalid = 'f235338c-2d54-47ec-b4af-a2846b14b31d';


   UPDATE personprogramarea
	SET activeflag = 0, 
		updatedby = 'CDM-23453',
		updatedon = now() 
	WHERE personprogramid = '9deaaa5b-f083-466c-affc-1d3c3543beaf';

   UPDATE routing 
	SET activeflag = 0, 
		updatedby = 'CDM-23453',
		updatedon = now() 
	WHERE objectid = 'f235338c-2d54-47ec-b4af-a2846b14b31d';

update tb_client_eligibility set delete_sw = 'Y',update_ts = now(), update_user_id = 'CDM-23453' where removal_id= 253945;


