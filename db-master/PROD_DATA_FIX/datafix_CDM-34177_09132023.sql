-- CDM-34177 - Payment Issue
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case
      
-- Adoption Case ID: 3198871 - dawn.young@maryland.gov
-- Client ID: 3221517 (SHAKUR WILSON) - 0eb2480a-6d1a-4adf-84ea-c28b3d4d959b
-- Provider ID: 5020321	(Angelia Wilson)
-- Adoption ID: 30178 - 04/28/2011 To 04/10/2028 - be8a330c-3485-42f4-8d80-d67e352bca05
-- Rate ID: f5802147-9326-418d-9868-7053e89b4dd4 - 08/25/2023 To 08/24/2024 - $835.00
-- adoptionagreementid  = 9743ba83-0d42-4f14-b227-1d8c89d03127

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no iActive Home Approval  
-- Fix Provided: Datafix has been promoted to update the provider info and 
--				 to trigger the under/over batch for generating the missing August 2023 payment.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Provider ID: 5020321	(Angelia Wilson) - Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'be8a330c-3485-42f4-8d80-d67e352bca05'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5020321, 
	parent1providerid = 5020321, 
	parent1providername = 'Angelia Wilson', -- 'LaVonte Jamar Wilson'
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-34177',
	updatedon = now()
where adoptioncaseid = 'be8a330c-3485-42f4-8d80-d67e352bca05'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5020321
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '9743ba83-0d42-4f14-b227-1d8c89d03127'
	and adoptionagreementrateid = 'f5802147-9326-418d-9868-7053e89b4dd4'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5020321,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-34177'
where adoptionagreementid = '9743ba83-0d42-4f14-b227-1d8c89d03127'
	and adoptionagreementrateid = 'f5802147-9326-418d-9868-7053e89b4dd4'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '9743ba83-0d42-4f14-b227-1d8c89d03127'
	and adoptionagreementrateid = 'f5802147-9326-418d-9868-7053e89b4dd4';

update adoptioncaserevision
set provider_id = 5020321,
	updatedon = now(), 
	updatedby = 'CDM-34177'
where adoptionagreementid = '9743ba83-0d42-4f14-b227-1d8c89d03127'
	and adoptionagreementrateid = 'f5802147-9326-418d-9868-7053e89b4dd4'
	and provider_id is null ;

update adoptioncaserevision
set provider_id = 5020321,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-34177'
where adoptionagreementid = '9743ba83-0d42-4f14-b227-1d8c89d03127'
	and adoptionagreementrateid = 'f5802147-9326-418d-9868-7053e89b4dd4'
	and approvaldate is not null
	and activeflag = 1 ;

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5020321
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
	update_user_id = 'CDM-34177'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5020321
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
		