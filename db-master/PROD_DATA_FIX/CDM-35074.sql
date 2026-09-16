/*
 * CDM-35074 - No provider ID listed
 * Customer Email ID:melanie.ledbetter1@maryland.gov
 * Customer Name:Melanie Ledbetter
 * Focus Area:Payments
 * Description - 3230925:This adoptive parent is not getting paid the monthly subsidy. The child turned 18 in July and all paperwork was submitted 
 * and approved but no provider ID is listed so the payments have stopped. 
 * Provider ID is missing from the Adoption Subsidy Agreement & Subsidy Rate.
 * Client Name : ALAISIA AIST (CJAMS PID # 3591462)
 * Provider Name: Dayna Aist (Provider ID# 5028980)
 * 
 */

select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '56643559-5ac7-42fa-879b-0234051b531d'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5028980, 
	parent1providerid = 5028980, 
	parent1providername = 'Dayna  Aist', 
	-- issingleparent = NULL,
	updatedby = 'CDM-35074',
	updatedon = now()
where adoptioncaseid = '56643559-5ac7-42fa-879b-0234051b531d'
	and activeflag  = 1 ;
	
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '6cae2d1c-5719-4e41-b54b-85e68a46c92d'
	and adoptionagreementrateid in ('2ae95e9e-ff30-4b46-9604-6681b7e17036','cb94e033-7885-4fe9-8b6c-a21d960d74a6')
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5028980,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-35074'
where adoptionagreementid = '6cae2d1c-5719-4e41-b54b-85e68a46c92d'
	and adoptionagreementrateid in ('2ae95e9e-ff30-4b46-9604-6681b7e17036','cb94e033-7885-4fe9-8b6c-a21d960d74a6')
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '6cae2d1c-5719-4e41-b54b-85e68a46c92d'
	and adoptionagreementrateid in ('2ae95e9e-ff30-4b46-9604-6681b7e17036','cb94e033-7885-4fe9-8b6c-a21d960d74a6');

update adoptioncaserevision
set provider_id = 5028980,
	updatedon = now(), 
	updatedby = 'CDM-35074'
where adoptionagreementid = '6cae2d1c-5719-4e41-b54b-85e68a46c92d'
	and adoptionagreementrateid in ('2ae95e9e-ff30-4b46-9604-6681b7e17036','cb94e033-7885-4fe9-8b6c-a21d960d74a6')
	and provider_id is null ;

update adoptioncaserevision
set provider_id = 5028980,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-35074'
where adoptionagreementid = '6cae2d1c-5719-4e41-b54b-85e68a46c92d'
	and adoptionagreementrateid in ('2ae95e9e-ff30-4b46-9604-6681b7e17036','cb94e033-7885-4fe9-8b6c-a21d960d74a6')
	and approvaldate is not null
	and activeflag = 1 ;

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5028980
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
	update_user_id = 'CDM-35074'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5028980
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
		
--select * from adoptioncaseagreement where adoptioncaseid = '56643559-5ac7-42fa-879b-0234051b531d' and activeflag = 1 ;
--select alternateid , * from adoptioncase where adoptioncaseid = '56643559-5ac7-42fa-879b-0234051b531d';
--
--select *
--from tb_payment_header
--where payment_id in (
--select payment_id
--from tb_payment_detail
--where subsidy_agreement_id = 38842
--and final_service_id = 501
--and delete_sw = 'N'
--)
--and delete_sw = 'N'
--and provider_id is null;

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3730780, 3730781, 3730782)
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-35074'
where payment_id in (3730780, 3730781, 3730782)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3730780, 3730781, 3730782)
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-35074'
where payment_id in (3730780, 3730781, 3730782)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3730780, 3730781, 3730782)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-35074'
where payment_id in (3730780, 3730781, 3730782)
	and delete_sw = 'N' ;	
