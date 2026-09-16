 -- CDM-29705 - Adoption Subsidy
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case and generate the missign payments

-- Adoption Case ID: 3152845
-- Client ID: 2032290 (ELIZABETH VANIDERSTINE) - dfa9a10f-fb63-4ff5-864d-08de57677fbe
-- Provider ID: 5005776 (Ginger Van Iderstine) - Local Department Home
-- Adoption ID: 37288 - 2013-06-28 To 2025-09-28 - 735af28e-e536-4934-a949-4edf43cd0695

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue on the Provider mudule side, No Home apporval with Active Switch 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update -- Provider ID: 5005776 (Ginger Van Iderstine) - Local Department Home
-- 240080	3610		Ginger Van Iderstine - Applicant
-- 240081	3611		null - Co-Applicant

select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '735af28e-e536-4934-a949-4edf43cd0695' and adoptionagreementid = '8bcc1193-5592-4db5-9b22-5caffcc2b5f6'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5005776, 
	parent1providerid = 5005776, 
	parent1providername = 'Ginger Van Iderstine', 
	parent2providerid = null,  
	parent2providername = null, 
	-- issingleparent = NULL,
	updatedby = 'CDM-29705',
	updatedon = now()
where adoptioncaseid = '735af28e-e536-4934-a949-4edf43cd0695' and adoptionagreementid = '8bcc1193-5592-4db5-9b22-5caffcc2b5f6'
	and activeflag  = 1 ;
	

select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '8bcc1193-5592-4db5-9b22-5caffcc2b5f6'
	and adoptionagreementrateid 
		in ('6f4a300e-4ffa-496d-ae62-8c52a3fda37a')
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5005776,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29705'
where adoptionagreementid = '8bcc1193-5592-4db5-9b22-5caffcc2b5f6'
	and adoptionagreementrateid 
		in ('6f4a300e-4ffa-496d-ae62-8c52a3fda37a')
	and activeflag = 1 ;

-- Trigger Under/Over
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '8bcc1193-5592-4db5-9b22-5caffcc2b5f6'
 	and adoptionagreementrateid 
		in ('6f4a300e-4ffa-496d-ae62-8c52a3fda37a')
	and approvaldate is not null
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5005776,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29705'
where adoptionagreementid = '8bcc1193-5592-4db5-9b22-5caffcc2b5f6'
 	and adoptionagreementrateid 
		in ('6f4a300e-4ffa-496d-ae62-8c52a3fda37a')
	and approvaldate is not null
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5005776,
	-- approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29705'
where adoptionagreementid = '8bcc1193-5592-4db5-9b22-5caffcc2b5f6'
 	and adoptionagreementrateid 
		in ('6f4a300e-4ffa-496d-ae62-8c52a3fda37a')
	-- and approvaldate is not null
	and activeflag = 1 ;

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5005776
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
	update_user_id = 'CDM-29705'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5005776
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
