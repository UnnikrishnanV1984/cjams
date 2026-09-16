-- CDM-22420 - Change providers to secondary
/*
-- Issue Description: 
   Beginning 8/1/21 we need to begin the subsidy with the new provider, Robert Wallace 6005979.
   
-- Adoption Case ID: 3225386 - rochelle.smith@maryland.gov
-- Client ID: 3538219 (KOA GABRIELLE WALLACE) - 3d742790-72a5-4d12-a28d-76c3b8483cb7
-- Adoption ID: 37256 - 2013-06-27 To 2023-05-16 - bf5bffa2-74d2-4b67-b099-964c265736df
-- New Provider ID: 6005979	(Robert Wallace)
-- Old Provider ID: 5049141	(Arlene Wallace)


-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider change functionlaity is currently not working. 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- update providerid in adoptioncaseagreement
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'bf5bffa2-74d2-4b67-b099-964c265736df'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 6005979, 
	-- parent1providerid = 6005979, 
	-- parent1providername = 'Robert Wallace', 
	parent2providerid = NULL,  
	parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-22420',
	updatedon = now()
where adoptioncaseid = 'bf5bffa2-74d2-4b67-b099-964c265736df'
	and activeflag  = 1 ;
	
/*
NULL	6005979	Robert Wallace				ba2dbc8f-3213-4b1b-9905-d643e1692db1	2022-05-06 10:07:32
*/	

-- 5049141	06/01/2021	05/31/2022	$835.00
-- Update end date as 07/31/2021 in adoptioncaseagreementrate
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = '352a29f4-0c5e-42d1-ad35-159d4dde86b6' ;

update adoptioncaseagreementrate
set enddate = '2021-07-31 04:00:00',
	-- approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-22420'
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = '352a29f4-0c5e-42d1-ad35-159d4dde86b6' ;

-- adoptioncaserevision
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = '352a29f4-0c5e-42d1-ad35-159d4dde86b6' ;

update adoptioncaserevision
set enddate = '2021-07-31 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-22420'
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = '352a29f4-0c5e-42d1-ad35-159d4dde86b6' ;


-- 5049141	06/01/2022	05/16/2023	$835.00
-- Update Provider ID as 6005979 and start/end dates as 08/01/2021 to 07/31/2022
-- adoptioncaseagreementrate
-- b44116c8-21af-426c-bb8f-910c155b2e67

select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = 'b44116c8-21af-426c-bb8f-910c155b2e67' ;

update adoptioncaseagreementrate
set provider_id = 6005979,
	startdate = '2021-08-01 08:00:00',
	enddate = '2022-07-31 04:00:00',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-22420'
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = 'b44116c8-21af-426c-bb8f-910c155b2e67' ;
	
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = 'b44116c8-21af-426c-bb8f-910c155b2e67' ;
	
update adoptioncaserevision
set provider_id = 6005979,
	startdate = '2021-08-01 08:00:00',
	enddate = '2022-07-31 04:00:00',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-22420'
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = '352a29f4-0c5e-42d1-ad35-159d4dde86b6'
	and adoptionrevisionid = '42e2ba4e-f38e-4d53-a80d-65c77692eccc' ;
	

update adoptioncaserevision
set provider_id = 6005979,
	startdate = '2021-08-01 08:00:00',
	enddate = '2022-07-31 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-22420'
where adoptionagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5'
	and adoptionagreementrateid = '352a29f4-0c5e-42d1-ad35-159d4dde86b6'
	and adoptionrevisionid = '2f7ec8e5-ba35-45e3-86e2-fa2c0526b4eb' ;	

-- Update Adoption Agreement Start date to original 2013-06-27 00:00:00 ( Current value 2021-08-01 04:00:00)
select startdate, enddate, updatedby, updatedon, * 
	from adoptioncaseagreement
where adoptioncaseid = 'bf5bffa2-74d2-4b67-b099-964c265736df'
	and activeflag = 1 ;
	
update adoptioncaseagreement
set startdate = '2013-06-27 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-22420'
where adoptioncaseid = 'bf5bffa2-74d2-4b67-b099-964c265736df'
	and activeflag = 1 ;

select startdate, enddate, updatedby, updatedon, activeflag 
	from adoptioncaseagreementrevision
where adoptioncaseagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5' ;

update adoptioncaseagreementrevision
set startdate = '2013-06-27 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-22420'
where adoptioncaseagreementid = '36791209-ed5b-44fe-8ba4-183ce4a6aad5' ;

