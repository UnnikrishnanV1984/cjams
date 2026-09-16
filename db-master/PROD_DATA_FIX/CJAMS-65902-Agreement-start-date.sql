/*
-- Issue Description:  START DATE
-- Case ID:    
-- Category/ Module: 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update gapagreement  
set startdate = '2019-10-10 00:00:00',
	updatedon = now(), 
	updatedby = 'CJAMS-65902'
where gapid = '5563f441-eff6-4fda-be8f-287f89501379'
	and activeflag = 1 ;





INSERT INTO cjams.gapagreementrevision
(gapagreementrevisionid, gapagreementid, gapid, iscomprehensivehomestudy, iscgawardedcustody, 
isplacementenddate, ischildreceivetca, startdate, enddate, signaturedate, guardianonedate, guardiantwodate, 
ldssdate, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, tcaamount, isfianotified, 
fianotifieddate, isrcnotifiedcontact, iscsnotifiedtocustody, approvalstatustypekey, approvaldate, 
guardian1signature, guardian2signature, ldssdirectorsignature, signaturecheck)
SELECT 
cjams.gen_random_uuid(), gapagreementid, gapid, iscomprehensivehomestudy, iscgawardedcustody, 
isplacementenddate, ischildreceivetca, startdate, enddate, signaturedate, guardianonedate, guardiantwodate, 
ldssdate, activeflag, effectivedate, 'CJAMS-65902', now(), 'CJAMS-65902', now(), old_id, tcaamount, isfianotified, 
fianotifieddate, isrcnotifiedcontact, iscsnotifiedtocustody, '3047', now(),                          
guardian1signature, guardian2signature, ldssdirectorsignature, signaturecheck
FROM cjams.gapagreement
where gapagreementid = 'd513b300-962b-45e0-8a09-d08aabe93332'
and activeflag = 1 ;

