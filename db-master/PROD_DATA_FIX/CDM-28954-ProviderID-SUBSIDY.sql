/*
   Issue Description: CDM-28954
   Category/ Module  :  Agreement documents
   Root cause: Updating the provider id 
   Pull request# for data fix:  8089
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
-- Update Provider ID: 5008016
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '863173a5-0389-4221-aadf-ee6b401ffa36'
	and activeflag  = 1 ;


update adoptioncaseagreement 
set providerid = 5008016, 
	parent1providerid = 5008016, 
	parent1providername = 'Michael Keene', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-28954',
	updatedon = now()
where adoptioncaseid = '863173a5-0389-4221-aadf-ee6b401ffa36'
	and activeflag  = 1 ;


-- Update Provider ID as 5008016
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '330f5647-79b1-46aa-a991-687f4bb81e6c'
	and adoptionagreementrateid = '58f3a583-fb66-4195-9c59-408c2183f0c1'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5008016,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-28954'
where adoptionagreementid = '330f5647-79b1-46aa-a991-687f4bb81e6c'
	and adoptionagreementrateid = '58f3a583-fb66-4195-9c59-408c2183f0c1'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '330f5647-79b1-46aa-a991-687f4bb81e6c'
	and adoptionagreementrateid = '58f3a583-fb66-4195-9c59-408c2183f0c1';

update adoptioncaserevision
set provider_id = 5008016,
	updatedon = now(), 
	updatedby = 'CDM-28954'
where adoptionagreementid = '330f5647-79b1-46aa-a991-687f4bb81e6c'
	and adoptionagreementrateid = '58f3a583-fb66-4195-9c59-408c2183f0c1';

update adoptioncaserevision
set provider_id = 5008016,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-28954'
where adoptionagreementid = '330f5647-79b1-46aa-a991-687f4bb81e6c'
	and adoptionagreementrateid = '58f3a583-fb66-4195-9c59-408c2183f0c1'
	and approvaldate is not null
	and activeflag = 1 ;
	