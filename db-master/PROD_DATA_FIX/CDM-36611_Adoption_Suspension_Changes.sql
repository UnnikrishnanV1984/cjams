-- CDM-36611 Subsidy Rate Payment number
/*
--	Issue Description: 
	Adoptive parent/Payee, James M. Dancy Jr. #5014669, passed away on June 25, 2023. 
	Co applicant, adoptive parent, Tonnette Dancy #6089595 is the new payee. 
	Payments should began in her name and provider number as of June 24, 2023. 
	Finance will not issue payments until the provider number has been changed to #6089595
    
-- Adoption Case ID: 3176165
-- Client ID: 2700427 (SYASIA DANCY) - a99348bf-bd67-4762-bf33-432e2827db5d
-- Adoption ID: 21527 - 2009-05-18 To 2026-02-22 - ff77e8d8-7ad9-4dd0-a85f-73d3ff63d7a9
-- New Provider ID: 6067957 (Tonnette Dancy)
-- Old Provider ID: 5014669 (James M. Dancy Jr.)

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Error	
-- Fix Provided: Datafix has been promoted to fix the overlapping Adoption suspensions.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--adoptionsuspensionids
--a9ddaeee-805f-4a4f-8ede-3054bd99cbd0	2023-12-01 05:00:00	2023-12-01 05:00:00	1
--c809b640-1cce-4281-bbea-f214c08f5f31	2023-11-13 05:00:00	2023-12-01 05:00:00	1
--4dd9f961-152d-45cf-b7a7-1d0c42910308	2023-09-12 04:00:00	2023-10-06 04:00:00	1


-- Delete below suspension records
--a9ddaeee-805f-4a4f-8ede-3054bd99cbd0	2023-12-01 05:00:00	2023-12-01 05:00:00	
--c809b640-1cce-4281-bbea-f214c08f5f31	2023-11-13 05:00:00	2023-12-01 05:00:00	
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid 
	in (	'a9ddaeee-805f-4a4f-8ede-3054bd99cbd0',
			'c809b640-1cce-4281-bbea-f214c08f5f31'
		)	
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set activeflag = 0,
	updatedby = 'CDM-36611',
	updatedon = now()
where adoptionsuspensionid 
	in (	'a9ddaeee-805f-4a4f-8ede-3054bd99cbd0',
			'c809b640-1cce-4281-bbea-f214c08f5f31'
		)	
	and activeflag = 1 ;	

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid 
	in (	'a9ddaeee-805f-4a4f-8ede-3054bd99cbd0',
			'c809b640-1cce-4281-bbea-f214c08f5f31'
		)	
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set activeflag = 0,
	updatedby = 'CDM-36611',
	updatedon = now()
where adoptionsuspensionid 
	in (	'a9ddaeee-805f-4a4f-8ede-3054bd99cbd0',
			'c809b640-1cce-4281-bbea-f214c08f5f31'
		)	
	and activeflag = 1 ;


-- To Update Start Date as 2023-06-26 05:00:00.000
--4dd9f961-152d-45cf-b7a7-1d0c42910308	2023-09-12 04:00:00	2023-10-06 04:00:00	1
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '4dd9f961-152d-45cf-b7a7-1d0c42910308'
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set suspensionbegindate = '2023-06-26 05:00:00.000',
	suspensionenddate = null,
	approvaldate = now(),
	updatedby = 'CDM-36611',
	updatedon = now()
where adoptionsuspensionid = '4dd9f961-152d-45cf-b7a7-1d0c42910308'
	and activeflag = 1 ;	

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = '4dd9f961-152d-45cf-b7a7-1d0c42910308'
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set suspensionbegindate = '2023-06-26 05:00:00.000',
	suspensionenddate   = null,
	approvaldate = now(),
	updatedby = 'CDM-36611',
	updatedon = now()
where adoptionsuspensionid = '4dd9f961-152d-45cf-b7a7-1d0c42910308' 
	and activeflag = 1 ;	
	
-- Update adoptioncaseagreement with old provider	
select * from adoptioncaseagreement where adoptionagreementid = '06bd20ab-6b21-4834-bcbd-8ec3a3ab9cf0';

update adoptioncaseagreement
set parent1providerid = 5014669,
	parent1providername = 'James M. Dancy Jr.',
	updatedby = 'CDM-36611',
	updatedon = now()
where adoptionagreementid = '06bd20ab-6b21-4834-bcbd-8ec3a3ab9cf0'
	and activeflag = 1 ;
	
	
-- adoptioncaserevision already have provider_id 5014669



update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-36611'
where delete_sw = 'N'
	and payment_id 
		in (	select ps.payment_id
				from tb_payment_detail pd,
					tb_payment_status ps
				where pd.payment_id = ps.payment_id
					and pd.delete_sw = 'N'
					and ps.delete_sw = 'N'
					and pd.subsidy_agreement_id  = 21527
					and pd.final_service_id = 501
					and ps.payment_status_cd = '1635'
	   	   );
		   
update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-36611'
where  delete_sw = 'N'
	and payment_id 
		in (	select ps.payment_id
				from tb_payment_detail pd,
					tb_payment_status ps
				where pd.payment_id = ps.payment_id
					and pd.delete_sw = 'N'
					and ps.delete_sw = 'N'
					and pd.subsidy_agreement_id  = 21527
					and pd.final_service_id = 501
					and ps.payment_status_cd = '1635'
	   	   );
	   	  
	   	   
update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-36611'
where payment_id 
	in ( select ps.payment_id
		from tb_payment_detail pd,
			tb_payment_status ps
		where pd.payment_id = ps.payment_id
			and pd.delete_sw = 'N'
			and ps.delete_sw = 'N'
			and pd.subsidy_agreement_id  = 21527
			and pd.final_service_id = 501
			and ps.payment_status_cd = '1635'
		)	
	and payment_status_cd = '1635'	 
	and delete_sw = 'N' ;