-- CDM-34760 - Provider ID missing from paymenets
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case and fix Home Approval data
      
-- Adoption Case ID: 3177843
-- Client ID: 2744626 (ROBERT LEWIS	WEBB) - ca09dc40-b82e-45c5-bb03-16de20de81c6
-- Provider ID: 5024979	(Michelle Webb)
-- Adoption ID: 22169 - 2009-08-28 To 2024-08-02 - 9cd7f587-9b0f-4ee5-9c90-63572e3cae36

-- Rate ID: 8e34fa31-f531-4d9b-bd1e-135593a3dbff - 2023-08-01 To 2024-07-31 - $835.00
-- adoptionagreementid  = 581d607e-da61-4067-b55e-af201dad3bd3

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no iActive Home Approval  
-- Fix Provided: Datafix has been promoted to update the provider info, provider home approval data and to trigger the under/over batch for generating the missing payments.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update the provider info and fix Home approval data (CDM-34760)
-- Update Provider ID: 5024979	(Michelle Webb) - Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '9cd7f587-9b0f-4ee5-9c90-63572e3cae36'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5024979, 
	parent1providerid = 5024979, 
	parent1providername = 'Michelle Webb', -- 'Joshua Burton Webb'
	parent2providerid = 5024979,  
	parent2providername = 'Joshua Webb', 
	-- issingleparent = NULL,
	updatedby = 'CDM-34760',
	updatedon = now()
where adoptioncaseid = '9cd7f587-9b0f-4ee5-9c90-63572e3cae36'
	and activeflag  = 1 ;
	
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '581d607e-da61-4067-b55e-af201dad3bd3'
	and adoptionagreementrateid = '8e34fa31-f531-4d9b-bd1e-135593a3dbff'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5024979,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-34760'
where adoptionagreementid = '581d607e-da61-4067-b55e-af201dad3bd3'
	and adoptionagreementrateid = '8e34fa31-f531-4d9b-bd1e-135593a3dbff'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '581d607e-da61-4067-b55e-af201dad3bd3'
	and adoptionagreementrateid = '8e34fa31-f531-4d9b-bd1e-135593a3dbff';

update adoptioncaserevision
set provider_id = 5024979,
	updatedon = now(), 
	updatedby = 'CDM-34760'
where adoptionagreementid = '581d607e-da61-4067-b55e-af201dad3bd3'
	and adoptionagreementrateid = '8e34fa31-f531-4d9b-bd1e-135593a3dbff'
	and provider_id is null ;

update adoptioncaserevision
set provider_id = 5024979,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-34760'
where adoptionagreementid = '581d607e-da61-4067-b55e-af201dad3bd3'
	and adoptionagreementrateid = '8e34fa31-f531-4d9b-bd1e-135593a3dbff'
	and approvaldate is not null
	and activeflag = 1 ;

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5024979
	and pa.delete_sw = 'N'
	and (select count(*)
			from prov.tb_provider_approval pa1
		 where pa1.provider_id = pa.provider_id
			and pa1.delete_sw = 'N'
			and pa1.active_sw = 'Y'
		 ) = 0
order by pa.provider_approval_id desc
limit 1 ;
	 
update prov.tb_provider_approval pa2
set active_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-34760'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5024979
				and pa.delete_sw = 'N'
				and (select count(*)
						from prov.tb_provider_approval pa1
					 where pa1.provider_id = pa.provider_id
						and pa1.delete_sw = 'N'
						and pa1.active_sw = 'Y'
					 ) = 0
			order by pa.provider_approval_id desc
			limit 1 
		) ;
		