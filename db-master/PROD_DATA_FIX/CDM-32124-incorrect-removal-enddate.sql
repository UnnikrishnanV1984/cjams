/*
   Issue Description: CDM-32124
   Category/ Module  :Child removal
   Root cause: user requested to change the  incorrect child removal enddate added by mistake
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

UPDATE intakeservreqchildremoval 
SET exitdate = '2023-06-04 14:00:00',	
	updatedby ='CDM-32124',
    updatedon = now()
WHERE intakeservreqchildremovalid = 'e9bd8386-f519-4b2e-b832-b0b3b75decbb';


UPDATE personprogramarea 
SET   enddate = '2023-06-04 00:00:00'
	, updatedby ='CDM-32124'
	, updatedon = now() 
WHERE personprogramid  ='a85c233d-3c81-4993-89cc-f71c2e13558d' and activeflag =1;

UPDATE tb_client_eligibility 
SET 
     end_dt = '2023-06-04'
	, update_user_id = 'CDM-32124'
	, update_ts = now()
WHERE removal_id ='123839' and delete_sw = 'N';