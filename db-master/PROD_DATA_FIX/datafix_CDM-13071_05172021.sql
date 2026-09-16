-- CDM-13071 - Validation
/*
-- Issue Description: 
   User request to remove the placement validation for client #1668893 - Feb & March 2021 Service periods. 
   Reason: The Department is aware, and the youth placement has been paid, since aging out manually. 
   
-- Case ID: 3116206 - novlette.pollock@maryland.gov
-- Client ID: 1668893 (ROSETTA	NICOLE	DAWSON) - 141d8a52-fdd4-480f-b01f-351ca63b33c0
-- Placement ID: 339207 - 2019-12-31  to 2021-03-31 
-- Private Organization: 5001321 (Challengers Independent Living, Inc.)
-- CPA Office: 5074848 - Challengers ILP (East)	
-- Contarct Program: 2164 (Challengers Independent Living) - 01/17/2007 to 06/30/2021
-- Placement Structure: Independent Living Residential Program
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: Exception scenario; The Placement Structure of this placement is "Independent Living Residential Program" 
	which is allowed for client between 16 to 21 years old. This client has turned 21 on 01/20/2021, and so CJAMS is currently not allowing the user to complete the validations for Feb & March 2021 services.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from cjams.tb_placement_validation 
where placement_validation_id in ( 1956538, 1956539)
	and delete_sw  = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request; The Department is aware, and the youth placement has been paid.',
	update_ts = now(),
	update_user_id = 'CDM-13071'
where placement_validation_id in ( 1956538, 1956539)
	and delete_sw = 'N' ;

