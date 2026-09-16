-- CDM-27187 - Adoption Subsidy
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case and generate the missign payments

-- Adoption Case ID: 3225487
-- Client ID: 3538842 (MAYA	SOPHIA SMITH) - dfa9a10f-fb63-4ff5-864d-08de57677fbe
-- Provider ID: 5045166 (Jennifer Harless-smith) - Local Department Home
-- Adoption ID: 37288 - 2013-06-28 To 2025-09-28 - b2e23ac8-c033-4c8a-badc-c40c32e65904

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue on the Provider mudule side, No Home apporval with Active Switch 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update -- Provider ID: 5045166 (Jennifer Harless-smith) - Local Department Home
-- 240080	3610		Jennifer Harless-smith - Applicant
-- 240081	3611		Michael Smith		   - Co-Applicant

select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'b2e23ac8-c033-4c8a-badc-c40c32e65904'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5045166, 
	parent1providerid = 5045166, 
	parent1providername = 'Jennifer Harless-smith', 
	parent2providerid = 5045166,  
	parent2providername = 'Michael Smith', 
	-- issingleparent = NULL,
	updatedby = 'CDM-27187',
	updatedon = now()
where adoptioncaseid = 'b2e23ac8-c033-4c8a-badc-c40c32e65904'
	and activeflag  = 1 ;
	

select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '62b6517c-7cc9-4166-9822-89ce72b8d82b'
	and adoptionagreementrateid 
		in ('f6d3948e-ac2c-47de-a396-2d6e1c81a1cd', '0e9786c2-5007-4f54-ac4b-b348c1a4fb63')
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5045166,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-27187'
where adoptionagreementid = '62b6517c-7cc9-4166-9822-89ce72b8d82b'
	and adoptionagreementrateid 
		in ('f6d3948e-ac2c-47de-a396-2d6e1c81a1cd', '0e9786c2-5007-4f54-ac4b-b348c1a4fb63')
	and activeflag = 1 ;

-- Trigger Under/Over
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '62b6517c-7cc9-4166-9822-89ce72b8d82b'
 	and adoptionagreementrateid 
		in ('f6d3948e-ac2c-47de-a396-2d6e1c81a1cd', '0e9786c2-5007-4f54-ac4b-b348c1a4fb63')
	and approvaldate is not null
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5045166,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-27187'
where adoptionagreementid = '62b6517c-7cc9-4166-9822-89ce72b8d82b'
 	and adoptionagreementrateid 
		in ('f6d3948e-ac2c-47de-a396-2d6e1c81a1cd', '0e9786c2-5007-4f54-ac4b-b348c1a4fb63')
	and approvaldate is not null
	and activeflag = 1 ;
	
-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3271157, 3269705, 3269704)
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27187'
where payment_id in (3271157, 3269705, 3269704)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3271157, 3269705, 3269704)
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27187'
where payment_id in (3271157, 3269705, 3269704)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3271157, 3269705, 3269704)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27187'
where payment_id in (3271157, 3269705, 3269704)
	and delete_sw = 'N' ;


-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa	.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5045166
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
	update_user_id = 'CDM-27187'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5045166
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
