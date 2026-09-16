-- CDM-21626 GAP subsidy issue
/*
-- Issue Description: 
   Guardian's provider info/Start dates are missing for 2 GAPs.
   
-- Case ID: 3301157 - jessica.cheeks@montgomerycountymd.gov
-- Provider ID: 5093703 (Rebecca Wasyk) - Local Department Home

-- Client ID: 4399125 (JEREMY L	WILSON) - 4228ae10-2aca-47db-a531-9bfd7c389a36
-- GAP ID: 1006014 - 2022-03-22 To 2034-04-18 - 20113704-45ef-47ce-8de1-e263aaea3b10
-- gapagreementid: f0701f67-2c61-40f4-9abb-48e12ea33b99
-- gapagreementrateid: 43340247-6ccd-42c2-9636-580bd032023c

-- Client ID: 4399126 (MACIE WILSON) - 1820acb2-de33-4326-a7e9-50c8aa04de82
-- GAP ID: 1006013 - Null To 2036-02-09 - 9de3db1e-f4e1-4271-9a7f-87440204cea3
-- gapagreementid: 558640c7-f6a7-4c68-aac8-a965eff4f221
-- gapagreementrateid: 6f5c8f6e-b924-4335-ab5d-779f1f0c8ecd
-- Update Start Date:  2022-03-22

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update Provider Info
-- Provider ID: 5093703 (Rebecca Wasyk) - Local Department Home
-- Guardianship Home Approval ID: 108549
-- 3610	Applicant: (529281) Rebecca Wasyk
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid in (	'20113704-45ef-47ce-8de1-e263aaea3b10',
					'9de3db1e-f4e1-4271-9a7f-87440204cea3'
				)	
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Rebecca Wasyk',
	guardianoneid = 529281, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 5093703,
	primaryrelationshipkey = 'FSTRMTHR',
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-21626',
	updatedon = now()
where gapid in (	'20113704-45ef-47ce-8de1-e263aaea3b10',
					'9de3db1e-f4e1-4271-9a7f-87440204cea3'
				)	
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid 
	in (	'f0701f67-2c61-40f4-9abb-48e12ea33b99',
			'558640c7-f6a7-4c68-aac8-a965eff4f221'
		);


update gapagreementrate
set provider_id = 5093703,
	-- startdate = '2022-03-22 04:00:00',
	updatedby = 'CDM-21626',
	updatedon = now()
where gapagreementid 
	in (	'f0701f67-2c61-40f4-9abb-48e12ea33b99',
			'558640c7-f6a7-4c68-aac8-a965eff4f221'
		);

	
select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid
	in (	'20113704-45ef-47ce-8de1-e263aaea3b10',
			'9de3db1e-f4e1-4271-9a7f-87440204cea3'
		);	

update gapratesrevision
set providerid = 5093703,
	-- ratestartdate = '2022-03-22 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21626',
	updatedon = now()
where guardiansubsidyid
	in (	'20113704-45ef-47ce-8de1-e263aaea3b10',
			'9de3db1e-f4e1-4271-9a7f-87440204cea3'
		);	

-- Update GAP Start Date as 2022-03-22 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '9de3db1e-f4e1-4271-9a7f-87440204cea3'
	and activeflag = 1 ;


update gapagreement 
set startdate = '2022-03-22 04:00:00',
	updatedby = 'CDM-21626',
	updatedon = now()
where gapid = '9de3db1e-f4e1-4271-9a7f-87440204cea3'
	and activeflag = 1 ;


select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '9de3db1e-f4e1-4271-9a7f-87440204cea3';	

update gapagreementrevision
set startdate = '2022-03-22 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21626',
	updatedon = now()
where gapid = '9de3db1e-f4e1-4271-9a7f-87440204cea3';		
