-- CDM-12759 - Unable to submit the correct Provider number for approval
/*
-- Issue Description: 
   The Worker selected the wrong Provider for 2 GAPs.
   
    Case ID: 3276168
	Client ID: 4078912 (ZAYONNA TYLER) - 9ff12f2a-5963-4c0d-928a-03d829f0eef8
	GAP ID: 1005597 - 2021-03-04 to 2037-02-13 - 9120d54f-07e5-44ac-958a-421c62e0259b

	Client ID: 4099826 (KENNETH TYLER) - 0180ed32-e786-4e31-b4ae-c4e0ef4856aa
	GAP ID: 1005596 - 2021-03-04 to 2034-06-08 - e3a1f062-2f32-479b-a096-15d0b98e4de9

	Current GAP Provider ID (CPA Office): 5001625 (MENTOR Maryland - Baltimore CPA)
    Correct Provider ID: 6001431 (ALICIA CUNNINGHAM) - Local Department Home

-- Category/ Module: GAP (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Info
select gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey,
	updatedby, updatedon
from guardianship 
where gapid in ('9120d54f-07e5-44ac-958a-421c62e0259b', 'e3a1f062-2f32-479b-a096-15d0b98e4de9')
and activeflag = 1 ;

update guardianship 
set guardianonename = 'ALICIA CUNNINGHAM',
	guardianoneid = 502672,
	guardianoneproviderid = 6001431,
	primaryrelationshipkey = 'guardian',
	guardiantwoname = NULL,
	guardiantwoid = NULL,
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-12759',
	updatedon = now()
where gapid in ('9120d54f-07e5-44ac-958a-421c62e0259b', 'e3a1f062-2f32-479b-a096-15d0b98e4de9')
and activeflag = 1 ;


select provider_id, startdate, enddate, paymentamout, updatedby, updatedon 
	from cjams.gapagreementrate 
where gapagreementid in ('d95f74ea-b397-4aef-b87b-cf2040b6fab6', 'a35cf8a6-ccbf-4344-9b1d-94024c85c5e6') ;

update cjams.gapagreementrate  
set provider_id = 6001431,
	updatedon = now(), 
	updatedby = 'CDM-12759'
where gapagreementid in ('d95f74ea-b397-4aef-b87b-cf2040b6fab6', 'a35cf8a6-ccbf-4344-9b1d-94024c85c5e6') ;

select providerid, approvalstatustypekey, approvaldate, updatedby, updatedon 
    from cjams.gapratesrevision
where guardiansubsidyid in ('9120d54f-07e5-44ac-958a-421c62e0259b', 'e3a1f062-2f32-479b-a096-15d0b98e4de9') ;

update cjams.gapratesrevision  
set providerid = 6001431,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-12759'
where guardiansubsidyid in ('9120d54f-07e5-44ac-958a-421c62e0259b', 'e3a1f062-2f32-479b-a096-15d0b98e4de9') ;

select startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspension 
where gapid in ('9120d54f-07e5-44ac-958a-421c62e0259b', 'e3a1f062-2f32-479b-a096-15d0b98e4de9') ;

update cjams.gapsuspension  
set enddate = startdate,
	activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-12759'
where gapid in ('9120d54f-07e5-44ac-958a-421c62e0259b', 'e3a1f062-2f32-479b-a096-15d0b98e4de9') ;

