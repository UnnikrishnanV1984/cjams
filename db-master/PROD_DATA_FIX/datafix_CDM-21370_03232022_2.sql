-- CDM-21370 - Start Date/Agreement Entered GAP
/*
-- Issue Description: 
	The GAP subisdy payments are not being generated for Joel Client ID-4360978. 
	The provider is missing the subsidy payments since the case closed on 12/13/21. 
	
-- Case ID: 3297266
-- Client ID: 1968895 (COLTON D	FISHER) - d33c9f62-3595-4ba4-be40-ffab8688da90
-- GAP ID: 1005952 - Null To 2024-06-26 - ecba6360-d756-45d0-ae93-5786fc6775e2
-- Provider ID: 6004229 (EDWARD E FISHER) - Local Department Home
-- Start Date: 2022-01-13 05:00:00

-- Category/ Module: GAP (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To nullify the  TCA Info
-- Update TCA amount to null
select ischildreceivetca, tcaamount, isfianotified, fianotifieddate, iscsnotifiedtocustody, 
	isrcnotifiedcontact, startdate, enddate, updatedby, updatedon
from gapagreement  
where gapid = 'ecba6360-d756-45d0-ae93-5786fc6775e2';

update gapagreement
set ischildreceivetca = false, -- true
	tcaamount = null, -- 408
	isfianotified = 0,
	fianotifieddate = null,
	iscsnotifiedtocustody = 0, -- 2
	isrcnotifiedcontact = 0,
	updatedby = 'CDM-21370',
	updatedon = now()
where gapid = 'ecba6360-d756-45d0-ae93-5786fc6775e2';

select ischildreceivetca, tcaamount, isfianotified, fianotifieddate, iscsnotifiedtocustody, 
	isrcnotifiedcontact, startdate, enddate, updatedby, updatedon
from gapagreementrevision  
where gapid = 'ecba6360-d756-45d0-ae93-5786fc6775e2'; 

update gapagreementrevision
set ischildreceivetca = false,
	tcaamount = null,
	isfianotified = 0,
	fianotifieddate = null,
	iscsnotifiedtocustody = 0,
	isrcnotifiedcontact = 0,
	updatedby = 'CDM-21370',
	updatedon = now(),
	approvaldate = now() -- To trigger Under/Over
where gapid = 'ecba6360-d756-45d0-ae93-5786fc6775e2';
