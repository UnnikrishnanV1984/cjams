/*	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no info on Home Approval  
-- Fix Provided: Datafix has been promoted to update the provider info on Adoption Agreement & Rate screen 

select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '30e4466b-4c85-4ce0-a0b1-98bcce23980f'
	and activeflag  = 1 ;



update adoptioncaseagreement 
set providerid = 5008139, 
	parent1providerid = 5008139, 
	parent1providername = 'Joann Savage', 
	updatedby = 'CDM-27698',
	updatedon = now()
where adoptioncaseid = '30e4466b-4c85-4ce0-a0b1-98bcce23980f'
	and activeflag  = 1 ;



 --Update Provider ID as 5008139
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '7417f881-4962-4305-b658-d1b0f72d1e2a'
	and adoptionagreementrateid = '2ac7ec65-ba55-4df3-a4ee-0205e4536f27'
	and activeflag = 1 ;


update adoptioncaseagreementrate
set provider_id = 5008139,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-27698'
where adoptionagreementid = '7417f881-4962-4305-b658-d1b0f72d1e2a'
	and adoptionagreementrateid = '2ac7ec65-ba55-4df3-a4ee-0205e4536f27'
	and activeflag = 1 ;


    update adoptioncaserevision
set provider_id = 5008139,
	updatedon = now(), 
	updatedby = 'CDM-27698'
where adoptionagreementid = '7417f881-4962-4305-b658-d1b0f72d1e2a'
	and adoptionagreementrateid = '2ac7ec65-ba55-4df3-a4ee-0205e4536f27'
	and approvaldate is not null
	and activeflag = 1 ;


-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5008139
	and pa.delete_sw = 'N'
	and (select count(*)
			from prov.tb_provider_approval pa1
		 where pa1.provider_id = pa.provider_id
			and pa1.delete_sw = 'N'
			and pa1.active_sw = 'Y'
		 ) = 0
order by pa.provider_approval_id desc
limit 1 ;


	 
update prov.tb_provider_approval 
set active_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27698'
where provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5008139
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
