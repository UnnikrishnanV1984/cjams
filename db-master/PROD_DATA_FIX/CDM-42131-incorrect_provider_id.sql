/*
-- Issue Description: 
	User request to change the GAP Annual Review and GAP Rates
    
-- Case ID: 3265843
1. On the GAP Application, update the Provider ID & Name from # 6163499 (Mark Tietje) to # 6001703 (Cynthia Yee-Tietje)
2. Remove the current subsidy rate slab as highlighted below.

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to fix the GAP Annual Review and GAP Rates as requested by the user.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- changing the gardianship name
-- permenancyplanid: c1c74ce0-e869-46f1-a6c0-740c743fd5ac
/*
select guardianonename, guardianoneid, guardianoneproviderid,guardiantwoname,guardiantwoproviderid ,secondaryrelationshipkey,* from guardianship g where permanencyplanid = 'c1c74ce0-e869-46f1-a6c0-740c743fd5ac';
select provider_first_nm,provider_last_nm,* from tb_provider vp where provider_id = 6001703;
select * from tb_prov_approval_person where first_nm = 'Cynthia' and last_nm = 'Yee-Tietje' 
approval_person_id , provider_approval_id 
676777	242138
660746	226853
*/

update guardianship 
set guardianonename = 'Cynthia Yee-Tietje', -- 'Mark Tietje'
	guardianoneid = 676777, -- 676830 (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6001703, -- 6163499
	updatedby = 'CDM-42131', -- 65184bef-4775-4122-9bf0-45e2761b9292
	updatedon = now() -- 2024-10-02 11:06:11.000
where gapid = '678ffc10-8291-4ff8-a31a-8784a7f23ab7'
	and activeflag = 1 ;


/*
select co_applicant_sw,* from tb_provider_approval where provider_approval_id = 242138
*/

-- Delete the most recent rate slab 
-- a220cba9-b3b6-42a1-a2d8-a24f3f490d1f -- 676777
update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-42131', 
	updatedon = now() 
where gapagreementrateid = 'a220cba9-b3b6-42a1-a2d8-a24f3f490d1f'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-42131', 
	updatedon = now() 
where gaprateid = 'a220cba9-b3b6-42a1-a2d8-a24f3f490d1f'
	and activeflag = 1 ;


update routing
set activeflag = 0,
	updatedby = 'CDM-42131', 
	updatedon = now() 
where objectid = 'a220cba9-b3b6-42a1-a2d8-a24f3f490d1f'
	and eventcode = 'GARR'
	and activeflag = 1 ;


