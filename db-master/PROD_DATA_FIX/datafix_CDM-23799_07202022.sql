-- CDM-23799 - Subsidy payment missing
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case
   
-- Case ID: 3085943
-- Client ID: 1441497 (HANNAH HEWETT) - faf65473-255c-44fb-938e-0f0f58b41ac9
-- Provider ID: 5008790 (Kimberly Hewitt)
-- Adoption ID: 6734 - 2005-01-01 To 2025-06-02 - 2829e520-ee8b-4c7b-be23-92c8c49bc9e2

-- Category/ Module: Adoption (Case Management) 
-- Root cause: TDB 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update -- Provider ID: 5008790 (Kimberly Hewitt)- Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '2829e520-ee8b-4c7b-be23-92c8c49bc9e2'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5008790, 
	parent1providerid = 5008790, 
	parent1providername = 'Kimberly Hewitt', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-23799',
	updatedon = now()
where adoptioncaseid = '2829e520-ee8b-4c7b-be23-92c8c49bc9e2'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5008790
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '18012126-2a06-4ff4-802d-61ec37ce5883'
	and adoptionagreementrateid = '4fa12605-ba20-420e-8e1e-14b99a89ac9a'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5008790,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-23799'
where adoptionagreementid = '18012126-2a06-4ff4-802d-61ec37ce5883'
	and adoptionagreementrateid = '4fa12605-ba20-420e-8e1e-14b99a89ac9a'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '18012126-2a06-4ff4-802d-61ec37ce5883'
	and adoptionagreementrateid = '4fa12605-ba20-420e-8e1e-14b99a89ac9a' ;

update adoptioncaserevision
set provider_id = 5008790,
	updatedon = now(), 
	updatedby = 'CDM-23799'
where adoptionagreementid = '18012126-2a06-4ff4-802d-61ec37ce5883'
	and adoptionagreementrateid = '4fa12605-ba20-420e-8e1e-14b99a89ac9a' ;

update adoptioncaserevision
set provider_id = 5008790,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-23799'
where adoptionagreementid = '18012126-2a06-4ff4-802d-61ec37ce5883'
	and adoptionagreementrateid = '4fa12605-ba20-420e-8e1e-14b99a89ac9a'
	and approvaldate is not null
	and activeflag = 1 ;
	
-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id = 3208442
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-23799'
where payment_id = 3208442
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3208442
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-23799'
where payment_id = 3208442
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3208442
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-23799'
where payment_id = 3208442
	and delete_sw = 'N' ;
