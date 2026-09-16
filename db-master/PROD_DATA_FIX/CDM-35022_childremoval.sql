/*
   Issue Description: CDM-35022-end-date
   Category/ Module  : end date
   Root cause: Case shows pending in approval box
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set exitdate = '2023-09-27 10:00:00.000', 
updatedby = 'CDM-35022', updatedon = now() , removalexitreason = 'REUNIF'
where intakeservreqchildremovalid='df058f9f-676e-4f19-99a4-092eac19361c' and personid='d40fc2e7-149a-428f-87db-e399d90b11e7'
and activeflag = 1 ;
	
-- Update OOH

update cjams.personprogramarea 
set enddate =  '2023-09-27 10:00:00.000', 
	updatedby = 'CDM-35022',
	updatedon = now()
where personprogramid in ('630f4c5a-7cd8-4cb3-aa58-fe8d28aceb7e') and personid='d40fc2e7-149a-428f-87db-e399d90b11e7'
and activeflag = 1 ;
	
-- Update Eligibility

update cjams.tb_client_eligibility
set end_dt =  '2023-09-27',
	update_user_id = 'CDM-35022',
	update_ts = now()
where removal_id = 252729
	and delete_sw = 'N' ;

--update Placement 

UPDATE cjams.placement
SET exittypekey='PLCC', exitreasontypekey='REUNIF', enddatetime='2023-09-27 00:00:00.000', updatedby='CDM-35022', updatedon=now()
WHERE placementid='065ad69c-24b5-4ff6-a2ac-dfdfe6a20a89';
