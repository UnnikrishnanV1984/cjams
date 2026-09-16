/*
-- Issue Description: 
1) remove the current subsidy rate slab 06/01/2025 to 05/31/2026
2) remove the four Hold Adoption Payments from May to August 2025

Once data fix completed and new provider has been created, the user can completed the switch adopted parent from the application and entered the effective date as 04/31/2025   
  Case ID: 3215581
    Client ID: 3404257 (JOHN WESLEY EADES)
    Provider ID: 5015186 (Geraldine Eades)
    Agreement End Date: 2/25/2028
    Latest Subsidy Rate Slab: 06/01/2025 - 05/31/2026
    Payment ID: 4752211, 4779426, 4798255 & 4819335
-- Category/ Module: Adoption Subsidy Planning(Case Management) 
-- Root cause: User error/User Request, There is no co-applicant registered for the respective provider in the provider application so the worker can not complete the switch adopted parent from the CW application.
 There are five payment have been hold for service period May 2025 to September 2025.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select * from adoptioncase a where adoptioncaseid = '8597f022-4679-4ec1-930c-5bb66a92075d';
select * from adoptioncaseagreement a where adoptioncaseid = '8597f022-4679-4ec1-930c-5bb66a92075d';--3fd44cc1-13fe-43a2-b094-63552edc730a
*/

update adoptioncaserevision
set activeflag = 0,
	updatedby = 'CJAMS-61987',
	updatedon = now()
where adoptionagreementrateid = '5476f6c2-e34a-415c-9d97-f408391b5835' 
	and adoptionrevisionid = 'd06c3830-d806-49f4-a15b-bb697e2b5524'
	and activeflag = 1 ;
	

update adoptioncaseagreementrate
set activeflag = 0,
	updatedby = 'CJAMS-61987',
	updatedon = now()
where adoptionagreementrateid = '5476f6c2-e34a-415c-9d97-f408391b5835'
	and activeflag = 1;
	
/*
select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon
	from routing
where objectid = '5476f6c2-e34a-415c-9d97-f408391b5835'
	and eventcode = 'AARR' -- Adoption Agreement Rate Review
	and activeflag = 1 ;
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-61987',
	updatedon = now()
where objectid = '5476f6c2-e34a-415c-9d97-f408391b5835'
	and eventcode = 'AARR' -- Adoption Agreement Rate Review
	and activeflag = 1 ;
	

-- Delete On HOLD Payment with NULL provider ID
/*
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (4752211, 4779426, 4798255,4819335,4841980)
	and delete_sw = 'N' ;
*/

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-61987'
where payment_id in (4752211, 4779426, 4798255,4819335,4841980)
	and delete_sw = 'N' ;

/*
select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (4752211, 4779426, 4798255,4819335,4841980)
	and delete_sw = 'N' ;
*/

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-61987'
where payment_id in (4752211, 4779426, 4798255,4819335,4841980)
	and delete_sw = 'N' ;
	
/*
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (4752211, 4779426, 4798255,4819335,4841980)
	and delete_sw = 'N' ;
*/

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-61987'
where payment_id in (4752211, 4779426, 4798255,4819335,4841980)
	and delete_sw = 'N' ; 