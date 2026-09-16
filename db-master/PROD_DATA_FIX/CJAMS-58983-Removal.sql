/*
 * CJAMS-58983Removal 
 * Focus Area:Child removal, OOH
 * Identified As:User Error
 * Description -  removal be re-opened. The VPA section was not filled out completely.
     We need to add the second parent signature date. 
 * CJAMS ID :3630257
 * Case ID: 3272753
 * removalid: 303425
 * personprogramid: 7a4b9907-b11c-41fc-bf55-d867a0fdae7d
 * Category/ Module: Removal (Case Management) 
 * Root cause: User Error
 * Fix Provided: Datafix has been promoted to re-open the Child Removal / OOH   
 * 
 */
-- Update Removal
/*
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag,*
	from cjams.intakeservreqchildremoval
where removalid = 303425
	and activeflag = 1;
*/

update cjams.intakeservreqchildremoval
set exitdate = Null, -- 2024-04-11 14:30:00.000
	returndate = Null,
	returntime = Null,
    returntransts = NULL,
	removalexitreason = NULL, -- REUNIF
	updatedby = 'CJAMS-58983',
	updatedon = now()
where removalid = 303425
	and activeflag = 1;

--revision history
/*
select exitdate ,* from intakeservreqchildremoval_history where intakeservreqchildremovalid ='3b342ad0-bb2d-4743-ac3c-d270ea5fe7da'
and personid ='770974f3-a63f-423b-8930-242a9602c872' and activeflag =1;--73fd83c7-d47f-4559-9edf-ec6ce1280f87
*/

update intakeservreqchildremoval_history
set exitdate = null, updatedby = 'CJAMS-58983', updatedon = now()
where intakeservreqchildremovalhistoryid = '73fd83c7-d47f-4559-9edf-ec6ce1280f87' and activeflag = 1;


-- Update OOH
/*
select programkey, startdate, enddate, updatedby, updatedon,*
	from cjams.personprogramarea 
where personprogramid = '7a4b9907-b11c-41fc-bf55-d867a0fdae7d'
	and activeflag = 1;
*/

update cjams.personprogramarea 
set enddate = Null, -- 2023-07-28 00:00:00 
	updatedby = 'CJAMS-58983',
	updatedon = now()
where personprogramid = '7a4b9907-b11c-41fc-bf55-d867a0fdae7d'
	and activeflag = 1;

-- Update Eligibility
/*
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 303425
	and delete_sw = 'N';
*/

update cjams.tb_client_eligibility
set end_dt = Null, -- 2023-07-28 
	update_user_id = 'CJAMS-58983',
	update_ts = now()
where removal_id = 303425
	and delete_sw = 'N'
	and end_dt is not null ;
