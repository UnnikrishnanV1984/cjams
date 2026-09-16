-- CDM-20481 - GAP payments
/*
-- Issue Description: 
   Guardian's provider info and the Start dates are missing for 2 GAPs.
   
-- Case ID: 3219864
-- Provider ID: 5096157 (Amanda  Shenberger) 

-- Client ID: 3463761 (PAUL	T BUSBY) - 0f77765f-ae4f-4078-9113-b38ed306369e
-- GAP ID: 1005937 - Null To 2029-01-11 - 2aede74e-3b90-4c5b-96c5-84457e7e78a2
-- gapagreementid: 434edde4-8ba9-4cb4-ba39-c53631b07d31
-- gapagreementrateid: 60a77d7f-43cf-4c44-8816-366517e3bac6
 
-- Client ID: 4069193 (ARYA	R BUSBYMORRIS) - ed739ec4-068d-4a4e-be23-890a417c42a1
-- GAP ID: 1005938 - Null To 2034-03-15 - d4d1b486-28c7-4cde-a13b-fb885de9ad16
-- gapagreementid: 7d42ccad-5798-4680-a400-d7f2912af98e
-- gapagreementrateid: f1d3c11c-e8f3-4d4d-ae24-aaab6ff1e3e0


-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update Provider Info and GAP Start Date as 11/15/2021 
-- Provider ID: 5096157 (Amanda  Shenberger) - Local Department Home
-- Guardianship Home Approval ID: 108549
-- 3610	Applicant: (527477) Amanda Shenberger
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid in (	'2aede74e-3b90-4c5b-96c5-84457e7e78a2',
					'd4d1b486-28c7-4cde-a13b-fb885de9ad16'
				)	
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Amanda Shenberger',
	guardianoneid = 527477, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5096157,
	primaryrelationshipkey = 'PRNTLAT',
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-20481',
	updatedon = now()
where gapid in (	'2aede74e-3b90-4c5b-96c5-84457e7e78a2',
					'd4d1b486-28c7-4cde-a13b-fb885de9ad16'
				)	
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid 
	in (	'434edde4-8ba9-4cb4-ba39-c53631b07d31',
			'7d42ccad-5798-4680-a400-d7f2912af98e'
		);


update gapagreementrate
set provider_id = 5096157,
	-- startdate = '2021-11-15 05:00:00',
	updatedby = 'CDM-20481',
	updatedon = now()
where gapagreementid 
	in (	'434edde4-8ba9-4cb4-ba39-c53631b07d31',
			'7d42ccad-5798-4680-a400-d7f2912af98e'
		);

	
select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid
	in (	'2aede74e-3b90-4c5b-96c5-84457e7e78a2',
			'd4d1b486-28c7-4cde-a13b-fb885de9ad16'
		);	

update gapratesrevision
set providerid = 5096157,
	-- ratestartdate = '2021-11-15 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20481',
	updatedon = now()
where guardiansubsidyid
	in (	'2aede74e-3b90-4c5b-96c5-84457e7e78a2',
			'd4d1b486-28c7-4cde-a13b-fb885de9ad16'
		);	

-- Update GAP Start Date as 2021-11-15 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid
 	in (	'2aede74e-3b90-4c5b-96c5-84457e7e78a2',
			'd4d1b486-28c7-4cde-a13b-fb885de9ad16'
		)
	and activeflag = 1 ;


update gapagreement 
set startdate = '2021-11-15 04:00:00',
	updatedby = 'CDM-20481',
	updatedon = now()
where gapid
 	in (	'2aede74e-3b90-4c5b-96c5-84457e7e78a2',
			'd4d1b486-28c7-4cde-a13b-fb885de9ad16'
		)
	and activeflag = 1 ;


select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid
 	in (	'2aede74e-3b90-4c5b-96c5-84457e7e78a2',
			'd4d1b486-28c7-4cde-a13b-fb885de9ad16'
		);	

update gapagreementrevision
set startdate = '2021-11-15 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20481',
	updatedon = now()
where gapid
 	in (	'2aede74e-3b90-4c5b-96c5-84457e7e78a2',
			'd4d1b486-28c7-4cde-a13b-fb885de9ad16'
		);	
