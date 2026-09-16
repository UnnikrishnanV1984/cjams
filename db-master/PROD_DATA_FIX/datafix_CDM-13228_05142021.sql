-- CDM-13228 - Wrong provider selected
/*
-- Issue Description: 
   The Worker selected the wrong Provider for GAP.
   
	Case ID: 3146683 
	Client ID: 1788396 (ALEATHIA L CONNER) - ebd9afcc-69b0-4425-a4e8-e85cd562201a

	GAP ID: 1005654 - 01/05/2021 - 03/20/2026 - 0af83a14-0496-4696-ac17-789c9fd353c3
	Correct Provider ID: 5095279 (Robin Perry) - Local Department Home
	Current Provider CPA Office: 5000553 (Associated Catholic Charities, TFC, Baltimore)

-- Category/ Module: GAP (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Info
select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey,
	updatedby, updatedon
from guardianship 
where gapid = '0af83a14-0496-4696-ac17-789c9fd353c3'
and activeflag = 1 ;


update guardianship 
set guardianonename = 'Robin Perry',
	guardianoneid = 517617,
	guardianoneproviderid = 5095279,
	primaryrelationshipkey = 'guardian',
	guardiantwoname = NULL,
	guardiantwoid = NULL,
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-13228',
	updatedon = now()
where gapid = '0af83a14-0496-4696-ac17-789c9fd353c3'
and activeflag = 1 ;


select provider_id, startdate, enddate, paymentamout, updatedby, updatedon 
	from cjams.gapagreementrate 
where gapagreementid = '60d2cc29-6bae-4dde-9065-932a666f07b6' ;

update cjams.gapagreementrate  
set provider_id = 5095279,
	updatedon = now(), 
	updatedby = 'CDM-13228'
where gapagreementid = '60d2cc29-6bae-4dde-9065-932a666f07b6' ;

select providerid, approvalstatustypekey, approvaldate, updatedby, updatedon 
    from cjams.gapratesrevision
where guardiansubsidyid = '0af83a14-0496-4696-ac17-789c9fd353c3' ;

update cjams.gapratesrevision  
set providerid = 5095279,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-13228'
where guardiansubsidyid = '0af83a14-0496-4696-ac17-789c9fd353c3' ;

select startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspension 
where gapid = '0af83a14-0496-4696-ac17-789c9fd353c3' ;

update cjams.gapsuspension  
set enddate = startdate,
	activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-13228'
where gapid = '0af83a14-0496-4696-ac17-789c9fd353c3' ;


