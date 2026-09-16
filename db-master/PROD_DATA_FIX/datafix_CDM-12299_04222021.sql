-- CDM-12299 - placement validations
/*
-- Issue Description: 
   User request to remove 3 pending placement validations 
   
   Exception scenario due ot Covid-19 pandemic; FC Client turned 21
   and system is not allowing the user to complete the validations
   "Independent Living Residential program is only applicable for clients between 16 years and 21 years of age."
   Also the placement was already paid with a Purchase Authorizations. 
   
   Case ID: 3217298 - valerie.gainey@maryland.gov 
   Client ID : 1678457 (CAMRON J BELL ) - fb465a1b-89a6-4261-b337-d4f514726376
   Placement ID: 329655 - 2018-08-25 to  2021-01-02
   Placement validation ID # 1946198, 1946197, 1946196 
	
-- Category/ Module: Placement Validations (Case Management) 
-- Root cause: User request for Exception scenario.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw, comment_tx 
from cjams.tb_placement_validation 
where placement_validation_id in ( 1946198, 1946197, 1946196 )
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set validation_status_cd = '1750',
	comment_tx = 'Validated as per the user requet, this client turned 21 and the service was paid using Purchase Authorization.',
	update_ts = now(),
	update_user_id = 'CDM-12299'
where placement_validation_id in ( 1946198, 1946197, 1946196 )
	and delete_sw = 'N';
	