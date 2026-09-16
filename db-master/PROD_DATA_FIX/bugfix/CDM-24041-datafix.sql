
/*
   Issue Description: CDM-24041
   Category/ Module  : Duplicate child Removal
   Root cause: Duplicate Child Removal

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/
/*
 * RemovalId: 253511
 */
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-24041',
	rm.updatedon = now() 		
where rm.removalid = 253511
	and rm.personid = 'bc670423-19e6-49c5-ae19-092e06717137' 
	and rm.activeflag = 1 ;

		
update routing ro
set activeflag = 0,
	updatedby = 'CDM-24041',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = '54d5fa1b-3085-4d69-84d4-7424221fa6cf'
	and ro.activeflag = 1 ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-24041',
	update_ts = now()
where removal_id = 253511
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;	
	
/*
 * RemovalId: 253454
 */
	
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-24041',
	rm.updatedon = now() 		
where rm.removalid = 253454
	and rm.personid = '1246977d-5376-4e21-bca8-c7fb9f284bec' 
	and rm.activeflag = 1 ;

		
update routing ro
set activeflag = 0,
	updatedby = 'CDM-24041',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = 'cca012cf-9596-4691-b536-0bf138e403eb'
	and ro.activeflag = 1 ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-24041',
	update_ts = now()
where removal_id = 253454
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;	
	
/*
 * RemovalId: 253455
 */
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-24041',
	rm.updatedon = now() 		
where rm.removalid = 253455
	and rm.personid = '4f35bf63-fba2-451c-89e5-539626dfb00a' 
	and rm.activeflag = 1 ;

		
update routing ro
set activeflag = 0,
	updatedby = 'CDM-24041',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = 'd6729313-3a36-49e1-afe3-c9ec6f7037db'
	and ro.activeflag = 1 ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-24041',
	update_ts = now()
where removal_id = 253455
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;	
	
/*
 * RemovalId: 253456
 */

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-24041',
	rm.updatedon = now() 		
where rm.removalid = 253456
	and rm.personid = 'ca9ac087-f7ea-4912-8fcd-e985919b178c' 
	and rm.activeflag = 1 ;

		
update routing ro
set activeflag = 0,
	updatedby = 'CDM-24041',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = '2c59b1fe-2fc1-40a3-8af3-7c330821709a'
	and ro.activeflag = 1 ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-24041',
	update_ts = now()
where removal_id = 253456
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;	
	
/*
 * RemovalId: 253662
 */
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-24041',
	rm.updatedon = now() 		
where rm.removalid = 253662
	and rm.personid = '304845fa-892f-42db-bc7d-7848ce4d3f2c' 
	and rm.activeflag = 1 ;

		
update routing ro
set activeflag = 0,
	updatedby = 'CDM-24041',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = '185b3e8f-21f5-4dff-8912-a46bc0caaa07'
	and ro.activeflag = 1 ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-24041',
	update_ts = now()
where removal_id = 253662
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;	
	
/*
 * RemovalId: 253626
 */
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-24041',
	rm.updatedon = now() 		
where rm.removalid = 253626
	and rm.personid = 'a3ee84a8-f85c-429a-b1af-545954affbe9' 
	and rm.activeflag = 1 ;
		
update routing ro
set activeflag = 0,
	updatedby = 'CDM-24041',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = 'f6a6ba2b-0904-449d-8ff4-7e39e848ccd5'
	and ro.activeflag = 1 ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-24041',
	update_ts = now()
where removal_id = 253626
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;	
	
