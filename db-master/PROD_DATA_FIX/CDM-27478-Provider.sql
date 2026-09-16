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
where adoptioncaseid = '9bd6063f-eecc-4c4b-965b-2c8d7d5669a3'
	and activeflag  = 1 ;



update adoptioncaseagreement 
set providerid = 5012257, 
	parent1providerid = 5012257, 
	parent1providername = 'James Selby', 
	updatedby = 'CDM-27478',
	updatedon = now()
where adoptioncaseid = '9bd6063f-eecc-4c4b-965b-2c8d7d5669a3'
	and activeflag  = 1 ;



 --Update Provider ID as 5012257
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '7e40ab33-4439-42fb-a5d7-60517561db0d'
	and adoptionagreementrateid = 'e21034f5-c2b6-4223-b8f0-e245ed459f6f'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5012257,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-27478'
where adoptionagreementid = '7e40ab33-4439-42fb-a5d7-60517561db0d'
	and adoptionagreementrateid = 'e21034f5-c2b6-4223-b8f0-e245ed459f6f'
	and activeflag = 1 ;

    
update adoptioncaseagreementrate
set provider_id = 5012257,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-27478'
where adoptionagreementid = '7e40ab33-4439-42fb-a5d7-60517561db0d'
	and adoptionagreementrateid = 'e21034f5-c2b6-4223-b8f0-e245ed459f6f'
	and activeflag = 1 ;

    update adoptioncaserevision
set provider_id = 5012257,
	updatedon = now(), 
	updatedby = 'CDM-27478'
where adoptionagreementid = '7e40ab33-4439-42fb-a5d7-60517561db0d'
	and adoptionagreementrateid = 'e21034f5-c2b6-4223-b8f0-e245ed459f6f';


update adoptioncaserevision
set provider_id = 5012257,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-27478'
where adoptionagreementid = '7e40ab33-4439-42fb-a5d7-60517561db0d'
	and adoptionagreementrateid = 'e21034f5-c2b6-4223-b8f0-e245ed459f6f'
	and approvaldate is not null
	and activeflag = 1 ;





-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5012257
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
	update_user_id = 'CDM-27478'
where provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5012257
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


    update  tb_payment_header set delete_sw ='Y', update_ts = now(),
	update_user_id = 'CDM-27478'
	where  payment_id = 3275517;



update  tb_payment_detail set delete_sw ='Y', update_ts = now(),
	update_user_id = 'CDM-27478'
	where  payment_id = 3275517;


update tb_payment_status set delete_sw ='Y', update_ts = now(),
	update_user_id = 'CDM-27478'
	where  payment_id = 3275517;
