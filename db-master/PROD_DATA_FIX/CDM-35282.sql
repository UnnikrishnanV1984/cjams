/*
   Issue Description: CDM-35282
   Category/ Module  :  Child removal
   Root cause: user requested
   Fix provided : did data fix to update the child exit date
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need to do data fix.
*/

--select removalid, * from cjams.Intakeservreqchildremoval where intakeservreqchildremovalid='1dd1d40e-810f-4187-a18d-e924e6c71d51' and activeflag=1;
update cjams.Intakeservreqchildremoval set exitdate='2023-10-23 00:01:00' ,updatedon = now(), updatedby = 'CDM-35282' where intakeservreqchildremovalid='1dd1d40e-810f-4187-a18d-e924e6c71d51' and activeflag=1; 

--select end_dt, * from cjams.tb_client_eligibility where removal_id =  286228 and delete_sw = 'N' ;
update cjams.tb_client_eligibility
set end_dt = '2023-10-23 00:01:00',
	update_user_id = 'CDM-35282',
	update_ts = now()
where removal_id =  286228
	and delete_sw = 'N' ; 
   