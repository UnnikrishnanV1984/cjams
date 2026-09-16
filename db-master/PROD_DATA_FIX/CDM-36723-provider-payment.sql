-- CDM-36723 - Provider Payment
/*	
-- Case ID: 211030010530

-- Category/ Module: GAP (Case Management) 
-- Root cause: Child is receiving a TCA under the GAP agreement so there is no payment generated. 
-- Fix provided: Data fix provided to remove the TCA flag as Yes and changed to No, then nullified the TCA amount
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- Backup
-- UPDATE cjams.gapagreement
-- SET ischildreceivetca=true, tcaamount=700.00, isfianotified=1, fianotifieddate='2023-12-20 05:00:00.000', iscsnotifiedtocustody=1, isrcnotifiedcontact=1, startdate='2023-12-20 10:00:00.000', enddate='2024-07-20 04:00:00.000', updatedby='eca6f2d2-e3c6-474c-8c4a-d4ee53381883', updatedon='2023-12-21 15:55:22.166' where gapid = '9ba35879-6c8b-42b4-939b-be4b67f8df47';

select ischildreceivetca, tcaamount, isfianotified, fianotifieddate, iscsnotifiedtocustody, 
	isrcnotifiedcontact, startdate, enddate, updatedby, updatedon
from gapagreement  
where gapid = '9ba35879-6c8b-42b4-939b-be4b67f8df47';

update gapagreement
set ischildreceivetca = false, -- true
	tcaamount = null, -- 700
	isfianotified = 0,
	fianotifieddate = null,
	iscsnotifiedtocustody = 0,
	isrcnotifiedcontact = 0,
	updatedby = 'CDM-36723',
	updatedon = now()
where gapid = '9ba35879-6c8b-42b4-939b-be4b67f8df47';

-- Backup
-- UPDATE cjams.gapagreementrevision
-- SET ischildreceivetca=true, tcaamount=700, isfianotified=1, fianotifieddate='2023-12-20 05:00:00.000', iscsnotifiedtocustody=1, isrcnotifiedcontact=1, startdate=NULL, enddate='2024-07-20 04:00:00.000', updatedby=NULL, updatedon='2023-12-15 09:52:57.941' where gapagreementrevisionid = '1bdf10d5-b849-4d1b-8629-5759aae16da3';
-- UPDATE cjams.gapagreementrevision
-- SET ischildreceivetca=true, tcaamount=700, isfianotified=1, fianotifieddate='2023-12-20 05:00:00.000', iscsnotifiedtocustody=1, isrcnotifiedcontact=1, startdate=NULL, enddate='2024-07-20 04:00:00.000', updatedby=NULL, updatedon='2023-12-13 18:01:49.000' where gapagreementrevisionid = '17094abd-01c1-41da-bf40-24c68c1a6e9d';
-- UPDATE cjams.gapagreementrevision
-- SET ischildreceivetca=true, tcaamount=700, isfianotified=1, fianotifieddate='2023-12-20 05:00:00.000', iscsnotifiedtocustody=1, isrcnotifiedcontact=1, startdate=NULL, enddate='2024-07-20 04:00:00.000', updatedby=NULL, updatedon='2023-12-15 09:52:57.941' where gapagreementrevisionid = 'd638eb8b-640a-4e25-8879-0e90db42ec22';


select ischildreceivetca, tcaamount, isfianotified, fianotifieddate, iscsnotifiedtocustody, 
	isrcnotifiedcontact, startdate, enddate, updatedby, updatedon
from gapagreementrevision  
where gapid = '9ba35879-6c8b-42b4-939b-be4b67f8df47'; 

update gapagreementrevision
set ischildreceivetca = false,
	tcaamount = null,
	isfianotified = 0,
	fianotifieddate = null,
	iscsnotifiedtocustody = 0,
	isrcnotifiedcontact = 0,
	updatedby = 'CDM-36723',
	updatedon = now(),
	approvaldate = now()
where gapid = '9ba35879-6c8b-42b4-939b-be4b67f8df47';
