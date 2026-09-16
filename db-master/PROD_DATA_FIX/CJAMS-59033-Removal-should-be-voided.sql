/*
 * CJAMS-59033
 * Customer Email ID:tara.feldman@maryland.gov
 * Focus Area:OOH, child removal
 * Description - 241030335718:Removal for Jour'nee needs to be voided as this was recorded in error.
 * data fix to remove the Child Removal & OOH Program Assignment end date.
 * Client Name : JAVONTAY AUSTIN
*/
/*
select activeflag, returntransts, removalid, * from cjams.intakeservreqchildremoval 
where removalid = '344387'
*/

update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-59033',
	updatedon = now()
where removalid = 344387
	and activeflag = 1 ;
	
--select activeflag ,* from cjams.personprogramarea where personprogramid = '405a1ed8-5783-4c8f-a751-21df45e7de9b';

update cjams.personprogramarea 
set activeflag = 0, 
	updatedby = 'CDM-59033',
	updatedon = now()
where personprogramid = '405a1ed8-5783-4c8f-a751-21df45e7de9b'
	and activeflag = 1 ;

update cjams.tb_client_eligibility
set delete_sw  = 'Y',
	update_user_id = 'CDM-59033',
	update_ts = now()
where removal_id =  344387
	and delete_sw = 'N' ;

/*
select * from cjams.intakeservreqchildremoval_history ih
where intakeservreqchildremovalid = '9d9ebd5d-8177-4846-a42d-98755eea20e9'
and activeflag = 1 ;
*/

update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CDM-59033',
	updatedon = now()
where intakeservreqchildremovalid = '9d9ebd5d-8177-4846-a42d-98755eea20e9'
and activeflag = 1 ;

/*
select * from cjams.routing
where objectid = '9d9ebd5d-8177-4846-a42d-98755eea20e9'
and activeflag = 1 ;
*/

update cjams.routing
set activeflag = 0,
	updatedby = 'CDM-59033',
	updatedon = now()
where objectid = '9d9ebd5d-8177-4846-a42d-98755eea20e9'
and activeflag = 1 ;