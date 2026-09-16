-- CDM-29177 - adoption agreement/provider
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case

   3194783:Worker extended the adoption subsidy agreement for Ethan after his birthday. 
   I then completed a new rate. Worker did not notice that the provider did not populate 
   
   The Provider ID is missing in the Adoption Agreement and the Subsidy Rate Screen:
   
-- Case ID: 3194783
-- Client ID: 3178564 (ETHAN LEE WORDEN) - 1f7a433e-4ce7-4c12-b67e-7596f2f54f82
-- Provider ID: 5031967	(Tracy Worden)
-- Adoption ID: 28869 - 2011-01-19 To 2026-02-24 - 834ec39d-e112-4563-98cc-b2d75c3cc766

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no info on Home Approval.  
-- Fix Provided: Datafix has been promoted to generate the missing payment.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Trigger Under_over
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '1a64b40c-cf02-4db6-8f0c-39e8fdbeff53'
	and adoptionagreementrateid = '90acb300-5dcd-43e5-902b-fd09beed528d';

update adoptioncaserevision
set provider_id = 5031967,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29177'
where adoptionagreementid = '1a64b40c-cf02-4db6-8f0c-39e8fdbeff53'
	and adoptionagreementrateid = '90acb300-5dcd-43e5-902b-fd09beed528d';

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id = 3364514
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-29177'
where payment_id = 3364514
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3364514
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-29177'
where payment_id = 3364514
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3364514
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-29177'
where payment_id = 3364514
	and delete_sw = 'N' ;