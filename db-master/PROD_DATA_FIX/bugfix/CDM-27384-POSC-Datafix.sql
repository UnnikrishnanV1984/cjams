-- CDM-27384 -  Plan Of Safe Care
/*
-- Issue Description: 
  User unable to complete the assessment or have the clients sign electronically
   
CASE # 3250054

-- Category/ Module: Assessment  (POSC) 
-- Root cause: User Request
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

--CASE # 3250054	

select signatures, updatedby, updatedon, activeflag from safecareplan
where safecareplanid = '79da00d7-58ec-479e-aa39-878d06e5ea77';

update 	safecareplan
set 	signatures = jsonb_set(signatures::jsonb, '{signatureitemsFormArray}', 'null')
		--, updatedby = 'CDM-27384', updatedby not accepting character varying
		, updatedon = now()
where 	safecareplanid = '79da00d7-58ec-479e-aa39-878d06e5ea77' and activeflag = 1;

