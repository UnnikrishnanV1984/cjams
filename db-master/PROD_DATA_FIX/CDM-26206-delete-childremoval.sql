/* 
    Issue Description : CDM-26206
    Category/ Module : Child Removal
    Root cause : User wants to delete child removal
*/
UPDATE intakeservreqchildremoval 
SET activeflag = 0
	, updatedby ='CDM-26206'
	, updatedon = now()
WHERE intakeservreqchildremovalid = '54f72431-0c42-404b-a4ab-7eed75b21307';

UPDATE tb_client_eligibility 
SET delete_sw = 'Y'
	, update_user_id = 'CDM-26206'
	, update_ts = now()
WHERE removal_id ='254779';

UPDATE personprogramarea 
SET activeflag = 0
	, updatedby ='CDM-26206'
	, updatedon = now() 
WHERE personprogramid  ='e1f4a35c-11bc-450a-ba45-54202c8ad2cf';