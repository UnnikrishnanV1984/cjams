/* 
    Issue Description: CJAMS-58388
   Category/ Module  : Child removal / Person Program / Service Log 
   Root cause: User requested to update Service log and remove child removal
   Pull request# for code fix: 
   Reason why no related code fix: User Error 
*/

UPDATE intakeservreqchildremoval 
SET 
	updatedby = 'CJAMS-58388', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid = '7be3bdc9-96ef-4aad-adaa-73bc881a349c' AND activeflag=1;

UPDATE personprogramarea 
SET activeflag =0,
	updatedby = 'CJAMS-58388', 
	updatedon = now() 
WHERE personprogramid = '49b087bb-845c-466a-bf68-4a6ede109871';


update tb_service_log 
set agency_program_area_id ='AXYS', 
    update_ts = now(), 
    update_user_id = 'CJAMS-58388'
where case_id = 231030215992 and client_id = 3595894 and delete_sw = 'N';

update intakeservreqchildremoval_history 
set activeflag =0, 
    updatedby ='CJAMS-58388', 
    updatedon = now()
WHERE intakeservreqchildremovalid = '7be3bdc9-96ef-4aad-adaa-73bc881a349c' AND activeflag=1;

update routing 
set activeflag =0, 
    updatedby ='CJAMS-58388', 
    updatedon = now()
WHERE objectid = '7be3bdc9-96ef-4aad-adaa-73bc881a349c' AND activeflag=1;
