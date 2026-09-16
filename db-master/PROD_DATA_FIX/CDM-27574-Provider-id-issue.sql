
/*
   Issue Description: CDM-27574
   Category/ Module  : INtake
   Root cause: 3265526:Kiaya Burroughs-Reed adoption subsidy not rolling over to finance given provider ID not 
   populating in subsidy rate.
We need to fix the Submission History to Display each change in Status.
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '8b84373d-35c5-47ca-9860-e70f65446d87'
	and activeflag  = 1 ;



update adoptioncaseagreement 
set providerid = 5048485, 
	parent1providerid = 5048485, 
	parent1providername = 'Danny Reed', 
	updatedby = 'CDM-27574',
	updatedon = now()
where adoptioncaseid = '8b84373d-35c5-47ca-9860-e70f65446d87'
	and activeflag  = 1 ;



 --Update Provider ID as 5008139
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = 'a78ae710-8629-4547-b533-96b0fbf8033e'
	and adoptionagreementrateid = '755b298a-ab2b-4d9d-865e-b43829ec8cb2'
	and activeflag = 1 ;


update adoptioncaseagreementrate
set provider_id = 5048485,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-27574'
where adoptionagreementid = 'a78ae710-8629-4547-b533-96b0fbf8033e'
	and adoptionagreementrateid = '755b298a-ab2b-4d9d-865e-b43829ec8cb2'
	and activeflag = 1 ;


    update adoptioncaserevision
set provider_id = 5048485,
	updatedon = now(), 
	updatedby = 'CDM-27574'
where adoptionagreementid = 'a78ae710-8629-4547-b533-96b0fbf8033e'
	and adoptionagreementrateid = '755b298a-ab2b-4d9d-865e-b43829ec8cb2'
	and approvaldate is not null
	and activeflag = 1 ;


-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5048485
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
	update_user_id = 'CDM-27574'
where provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5048485
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


--updating provider id in subsidyrate list

update adoptioncaseagreementrate set provider_id ='5048485', updatedby = 'CDM-27574',
	updatedon = now() where adoptionagreementid='a78ae710-8629-4547-b533-96b0fbf8033e' and
	 adoptionagreementrateid= '1d5e653b-59a0-4c43-9de2-2fa1d3475f72';
