-- CDM-30913 - Delete on hold payments
/*
-- Issue Description: 
	Request to delete on hold payments for Adoption case 3285807 from dates 2/1/23 - 4/30/23. 

-- Adoption Case ID: 3285807
-- Client ID: 4209426 (MALACHI JAMES DUNCAN) -	b109f7a2-45a7-44e8-bbe1-e7ff821f0cc5
-- Adoption ID: 48420 - 2018-03-12 To 2034-06-24 - 48660279-c169-4837-8cfd-24b1942c52e8
-- Provier ID: 5085029 (Rachel Duncan)

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error, Provider was changed on Adoption Agreement screen, but the rate slab was not updated.  
-- Fix Provided: Datafix has been promoted to delete the on Hold Adoption Payments.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Fix Adoption Rate Slabs
-- Update End Date as 2023-01-31 
-- 5085029	2022-03-12 10:00:00.000	2023-03-11 10:00:00.000
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon  
	from adoptioncaseagreementrate 
where adoptionagreementrateid  = 'f0c618de-5189-45b8-8c29-dcacd392e118' ;

update adoptioncaseagreementrate
set enddate = '2023-01-31 10:00:00.000',
	updatedby = 'CDM-30913',
	updatedon = now(),
	approvaldate = now()
where adoptionagreementrateid  = 'f0c618de-5189-45b8-8c29-dcacd392e118' ;

select provider_id, startdate, enddate, approvaldate, updatedon, updatedby  
	from adoptioncaserevision 
where adoptionagreementrateid  = 'f0c618de-5189-45b8-8c29-dcacd392e118' ;

update adoptioncaserevision
set enddate = '2023-01-31 10:00:00.000',
	updatedby = 'CDM-30913',
	updatedon = now()
where adoptionagreementrateid  = 'f0c618de-5189-45b8-8c29-dcacd392e118' 
	and approvaldate is null ;

update adoptioncaserevision
set enddate = '2023-01-31 10:00:00.000',
	updatedby = 'CDM-30913',
	updatedon = now(),
	approvaldate = now()
where adoptionagreementrateid  = 'f0c618de-5189-45b8-8c29-dcacd392e118' 
	and approvaldate is not null ;

-- Update Provider ID as 6029140 & Dates as 2023-02-01 To 2024-01-31
-- 5085029	2023-03-12 14:00:00.000	2024-03-11 14:00:00.000
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon  
	from adoptioncaseagreementrate 
where adoptionagreementrateid  = 'f0ec88e1-2c0c-4d51-82d2-2800889e65c2' ;

update adoptioncaseagreementrate
set provider_id = 6029140,
	startdate = '2023-02-01 14:00:00.000',
	enddate = '2024-01-31 10:00:00.000',
	updatedby = 'CDM-30913',
	updatedon = now(),
	approvaldate = now()
where adoptionagreementrateid  = 'f0ec88e1-2c0c-4d51-82d2-2800889e65c2' ;

select provider_id, startdate, enddate, approvaldate, updatedon, updatedby  
	from adoptioncaserevision a  
where adoptionagreementrateid  = 'f0ec88e1-2c0c-4d51-82d2-2800889e65c2' ;

update adoptioncaserevision
set provider_id = 6029140,
	startdate = '2023-02-01 14:00:00.000',
	enddate = '2024-01-31 10:00:00.000',
	updatedby = 'CDM-30913',
	updatedon = now()
where adoptionagreementrateid  = 'f0ec88e1-2c0c-4d51-82d2-2800889e65c2' 
	and approvaldate is null ;

update adoptioncaserevision
set provider_id = 6029140,
	startdate = '2023-02-01 14:00:00.000',
	enddate = '2024-01-31 10:00:00.000',
	updatedby = 'CDM-30913',
	updatedon = now(),
	approvaldate = now()
where adoptionagreementrateid  = 'f0ec88e1-2c0c-4d51-82d2-2800889e65c2' 
	and approvaldate is not null ;

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3421256, 3393164, 3361818)
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30913'
where payment_id in (3421256, 3393164, 3361818)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3421256, 3393164, 3361818)
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30913'
where payment_id in (3421256, 3393164, 3361818)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3421256, 3393164, 3361818)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30913'
where payment_id in (3421256, 3393164, 3361818)
	and delete_sw = 'N' ; 
