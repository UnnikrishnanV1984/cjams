-- CDM-27812 - CJAMS - EFT box
/*
-- Issue Description: 
	The system does not allow a flag for the Electronic Funds Transfer (EFT) box 
	for the Provider 110768736 Rachel Walker.

-- Provider ID: 6004507	(Rachel Scibek Walker) - Local Department Home
-- Electronic Funds Transfer (EFT)
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: This error was introduced as part of B-150256 - Provider Withhold Payment functionality modifications user story development.
-- Fix Provided: Code fix was promoted for the same.  
-- 		  	     Datafix has been promoted to update EFT for Provider ID: 6004507	(Rachel Scibek Walker)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select provider_id, tax_id_no,  eft_sw, update_ts, update_user_id
from prov.tb_provider tp
where provider_id = 6004507
	and delete_sw = 'N' ;

update prov.tb_provider 
set eft_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27812'
where provider_id = 6004507
	and delete_sw = 'N'
	and COALESCE(eft_sw, 'N') = 'N';		

select provider_id, eft_sw, withhold_payment_sw, updatedby, updatedon 
	from withhold_eft_config 
where provider_id  = 6004507 ;

delete from withhold_eft_config 
where provider_id = 6004507 
	and updatedby = 'CDM-27812' ;

insert into cjams.withhold_eft_config
	(	withholdeftconfigid, withhold_payment_sw, eft_sw, 
		activeflag, insertedby, insertedon, updatedby, updatedon, 
		provider_id, withhold_reason, withhold_question
	)
values
	(	cjams.gen_random_uuid(), NULL, 'Y', 
		1, '819ae051-a1fc-4c69-b8ff-13314fff0e16', now(), 'CDM-27812', now(), 
		6004507, NULL, null
	);

select provider_id, eft_sw, withhold_payment_sw, updatedby, updatedon 
	from withhold_eft_config 
where provider_id  = 6004507 ;
