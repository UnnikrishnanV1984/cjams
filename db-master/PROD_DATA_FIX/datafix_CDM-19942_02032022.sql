-- CDM-19942 - Payment ISSUE
/*
-- Issue Description: 
   To update the TCA info and GAP the Start date 

-- Case ID: 3293217 
-- Client ID: 4106238 (LORI	L NAYLOR) - e7e3e43e-a383-41f7-8691-bd9f6ef39408
-- GAP ID: 1005942 - ?? TO 2035-02-03 - 3404d334-a118-4b67-a6f4-154407345b91
-- Provider ID: 6001973	(PAULA ANNETTE WILLEY) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Start Date as 12/02/2021 (old value is NULL) & TCA Info
select ischildreceivetca, tcaamount, isfianotified, fianotifieddate, iscsnotifiedtocustody, isrcnotifiedcontact, 
	startdate, enddate, updatedby, updatedon
from gapagreement  
where gapid = '3404d334-a118-4b67-a6f4-154407345b91';
--	and activeflag = 1 

update gapagreement 
set startdate = '2021-12-02 00:00:00',
	ischildreceivetca = true,
	tcaamount = 217.50,
	isfianotified = 1,
	fianotifieddate = '2021-12-02 00:00:00',
	iscsnotifiedtocustody = 0,
	isrcnotifiedcontact = 0,
	updatedby = 'CDM-19942',
	updatedon = now()
where gapid = '3404d334-a118-4b67-a6f4-154407345b91';
--	and activeflag = 1 

select ischildreceivetca, tcaamount, isfianotified, fianotifieddate, iscsnotifiedtocustody, isrcnotifiedcontact, 
	startdate, enddate, updatedby, updatedon
from gapagreementrevision  
where gapid = '3404d334-a118-4b67-a6f4-154407345b91'; 

update gapagreementrevision
set startdate = '2021-12-02 00:00:00',
	ischildreceivetca = true,
	tcaamount = 217.50,
	isfianotified = 1,
	fianotifieddate = '2021-12-02 00:00:00',
	iscsnotifiedtocustody = 0,
	isrcnotifiedcontact = 0,
	approvaldate = now(),
	updatedby = 'CDM-19942',
	updatedon = now()
where gapid = '3404d334-a118-4b67-a6f4-154407345b91'; 

select programkey, startdate, enddate, updatedby, updatedon 
	from personprogramarea
where personprogramid = '4021c2d9-b32b-48a6-871b-246633725275'
	and activeflag  = 1 ;

update personprogramarea
set startdate = '2021-12-02 00:00:00',
	updatedby = 'CDM-19942',
	updatedon = now()
where personprogramid = '4021c2d9-b32b-48a6-871b-246633725275'
	and activeflag  = 1 ;
