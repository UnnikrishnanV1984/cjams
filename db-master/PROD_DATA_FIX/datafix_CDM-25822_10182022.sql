-- CDM-25822 - Adoption Subsidy
/*
-- Issue Description: 
To update Provider Info on the Adoption Case and generate the missign payments

-- Case ID:3238280
-- Client ID: 3650442 (BYRON DANIEL WEIMERT) - 469cf784-de3b-4e04-a82e-da13dd5b9074
-- Adoption ID: 40437 - 2014-04-17 To 2025-02-17 - 858044be-ff40-4604-bcd0-ae07d9029479
-- Provider ID: 5057103 (Emily Weimert)

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update -- Provider ID: 5057103 (Emily Weimert)- Local Department Home
-- 228152	3610		Emily		Weimert
-- 228153	3611		Jeffrey		Weimert
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '858044be-ff40-4604-bcd0-ae07d9029479'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5057103, 
	parent1providerid = 5057103, 
	parent1providername = 'Emily Weimert', 
	parent2providerid = 5057103,  
	parent2providername = 'Jeffrey Weimert', 
	-- issingleparent = NULL,
	updatedby = 'CDM-25822',
	updatedon = now()
where adoptioncaseid = '858044be-ff40-4604-bcd0-ae07d9029479'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5057103 in adoptioncaseagreementrate was done with CDM-25091

-- Trigger Under/Over
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '35b484f6-3de2-460c-8cb1-7822c91edfb5'
 	and adoptionagreementrateid = '68f22485-2328-47bf-accf-94a528800c06' 
	and approvaldate is not null
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5057103,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-25822'
where adoptionagreementid = '35b484f6-3de2-460c-8cb1-7822c91edfb5'
 	and adoptionagreementrateid = '68f22485-2328-47bf-accf-94a528800c06' 
	and approvaldate is not null
	and activeflag = 1 ;
	
-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3233522, 3233521, 3233520, 3193022, 3180730, 3180729, 3180728)
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-25822'
where payment_id in (3233522, 3233521, 3233520, 3193022, 3180730, 3180729, 3180728)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3233522, 3233521, 3233520, 3193022, 3180730, 3180729, 3180728)
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-25822'
where payment_id in (3233522, 3233521, 3233520, 3193022, 3180730, 3180729, 3180728)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3233522, 3233521, 3233520, 3193022, 3180730, 3180729, 3180728)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-25822'
where payment_id in (3233522, 3233521, 3233520, 3193022, 3180730, 3180729, 3180728)
	and delete_sw = 'N' ;


-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa	.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5057103
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
set pa2.active_sw = 'Y',
	pa2.update_ts = now(),
	pa2.update_user_id = 'CDM-25822'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5057103
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
