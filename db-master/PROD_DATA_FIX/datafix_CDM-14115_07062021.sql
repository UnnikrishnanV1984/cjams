-- CDM-14115 - Payment Issues
/*
--	Issue Description: 
	User Request to change the Adoption Suspensions 
    
	Correct Adoption Suspension are as below,
	Start date 8/21/2018 - End Date 3/31/2019
	Start Date 8/1/2020 - End Date 12/31/2020

	All other Suspensions will be removed.
   
-- Adoption Case ID: 3162880 - rosemarie.price@maryland.gov
-- Client ID: 2299362 (DAYJHANIA RENEE'	HOUSTON) - 7fb9afba-a4b3-404d-92ad-93d940402238
-- Adoption ID: 18317 - 2007-12-19 To 2021-08-20 - be1559d4-20ac-4a4d-8ca9-f78e1d08b9c7
-- Provider ID: 5029326	(Richard S Houston) 

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Error	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete  
-- dc9efded-ae12-4bf2-98b2-b31d8bf0fe29 2020-08-01 To 2021-05-11
-- 442c4093-ab64-478d-b086-3ba8034cec71	2018-01-12 To 2020-12-31 

select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid in ( 'dc9efded-ae12-4bf2-98b2-b31d8bf0fe29', '442c4093-ab64-478d-b086-3ba8034cec71' )
	and activeflag = 1 ;
	
update adoptioncasesuspension
set activeflag = 0,
	updatedby = 'CDM-14115',
	updatedon = now()
where adoptionsuspensionid in ( 'dc9efded-ae12-4bf2-98b2-b31d8bf0fe29', '442c4093-ab64-478d-b086-3ba8034cec71' )
	and activeflag = 1;

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
	from adoptioncasesuspensionrevision
where adoptionsuspensionid in ( 'dc9efded-ae12-4bf2-98b2-b31d8bf0fe29', '442c4093-ab64-478d-b086-3ba8034cec71' )
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set activeflag = 0,
	updatedby = 'CDM-14115',
	updatedon = now()
where adoptionsuspensionid in ( 'dc9efded-ae12-4bf2-98b2-b31d8bf0fe29', '442c4093-ab64-478d-b086-3ba8034cec71' )
	and activeflag = 1 ;	
	
-- Update
-- 1b01fcf1-65d1-4149-8b82-3f9946e26ae4	2020-08-01 To 2020-12-31 
--										2018-08-21 To 2019-03-31
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '1b01fcf1-65d1-4149-8b82-3f9946e26ae4'
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set suspensionbegindate = '2018-08-21 04:00:00',
	suspensionenddate = '2019-03-31 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-14115',
	updatedon = now()
where adoptionsuspensionid = '1b01fcf1-65d1-4149-8b82-3f9946e26ae4'
	and activeflag = 1 ;	

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = '1b01fcf1-65d1-4149-8b82-3f9946e26ae4'
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set suspensionbegindate = '2018-08-21 04:00:00',
	suspensionenddate = '2019-03-31 05:00:00',
	approvaldate = now(),
	updatedby = 'CDM-14115',
	updatedon = now()
where adoptionsuspensionid = '1b01fcf1-65d1-4149-8b82-3f9946e26ae4' 
	and activeflag = 1 ;	


-- No changes to dates, update to trigger udre/over 
-- 49811938-b23e-4dd1-ad4e-311cd2dc393e	2020-08-01 To 2020-12-31 
	
select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = '49811938-b23e-4dd1-ad4e-311cd2dc393e'
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set approvaldate = now(),
	updatedby = 'CDM-14115',
	updatedon = now()
where adoptionsuspensionid = '49811938-b23e-4dd1-ad4e-311cd2dc393e' 
	and activeflag = 1 ;	
	

-- To trigger udre/over starting 2018 service periods 
select startdate, enddate, paymentamout, status, approvaldate, updatedon, updatedby 
	from adoptioncaseagreementrate
where adoptionagreementrateid
	in ( 
	'7893a825-3414-45a8-be09-704ac3009c54',
	'b0a9d079-c740-4f55-89f3-2af0373c8797',
	'd4015c93-883b-418b-b9c7-3f0d0e0ba34f',
	'd66f64f9-26c1-4298-b9b0-4dcb81caf667',
	'700b6eae-4355-40d8-9b4a-d39e94f55698',
	'80f17c04-ec7a-4715-98f4-ff82ec48d707'
	)
and activeflag  = 1
order by startdate ;

update adoptioncaseagreementrate
set updatedby = 'CDM-14115',
	updatedon = now()
where adoptionagreementrateid
	in ( 
	'7893a825-3414-45a8-be09-704ac3009c54',
	'b0a9d079-c740-4f55-89f3-2af0373c8797',
	'd4015c93-883b-418b-b9c7-3f0d0e0ba34f',
	'd66f64f9-26c1-4298-b9b0-4dcb81caf667',
	'700b6eae-4355-40d8-9b4a-d39e94f55698',
	'80f17c04-ec7a-4715-98f4-ff82ec48d707'
	)
and activeflag  = 1 ;

