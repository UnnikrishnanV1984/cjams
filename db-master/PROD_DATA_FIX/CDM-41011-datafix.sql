/*
  Issue Description:  CDM-41011
   Category/ Module  :  Child Removal
   Root cause: User request to Data fix to update  child removal & OOH program assignment end date.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

--GENESIS SMITH

UPDATE cjams.personprogramarea
SET enddate='2024-02-07 00:00:00.000', updatedon=now() 
WHERE personprogramid='3f311cf4-aaa3-41c1-82d8-6321bb292fb4'
and personid='f66677f6-20a7-4b0e-98b3-45ccaaa01f08'
and objectid='dda9beca-9730-4300-a1f4-101e7b86897f' and activeflag= 1;

update 	cjams.intakeservreqchildremoval
set 	exitdate = '2024-02-07 00:00:00',
		updatedby = 'CDM-41011',
		updatedon = now()
where 	removalid = '253169'
        and intakeservreqchildremovalid = 'a49c1165-d71f-4497-b1ea-a9f29ea263f8'
		and activeflag = 1 ;

	update cjams.tb_client_eligibility
set end_dt = '2024-02-07 00:00:00',
    update_user_id = 'CDM-41011',
    update_ts = now()
where removal_id = '253169';		
	
--Gracelyn Caldwell	
	
UPDATE cjams.personprogramarea
SET enddate='2024-02-07 00:00:00.000', updatedon=now() 
WHERE personprogramid='279d9319-71c9-4aa8-a6af-3b2573622bd2'
and personid='33672016-840b-42c5-b74e-a2b9e891f158'
 and activeflag= 1;

update 	cjams.intakeservreqchildremoval
set 	exitdate = '2024-02-07 00:00:00',
		updatedby = 'CDM-41011',
		updatedon = now()
where 	removalid = '253170'
        and intakeservreqchildremovalid = '9d8cf5e6-86ae-4f8a-bcf5-ca6fe915dd3c'
		and activeflag = 1 ;

	update cjams.tb_client_eligibility
set end_dt = '2024-02-07 00:00:00',
    update_user_id = 'CDM-41011',
    update_ts = now()
where removal_id = '253170';		
