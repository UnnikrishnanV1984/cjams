/*
    Issue Description: CDM-28260
    Category/ Module  :  Agreement
    Root cause: providerid missing in subsidy rate
    Pull request# for code fix: 7752
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
*/
 
 

update adoptioncaseagreement 
set providerid =  5008134, 
	parent1providerid =  5008134, 
	parent1providername = 'Doreen Voorhees', 
	updatedby = 'CDM-28260',
	updatedon = now()
where adoptioncaseid = 'e80b03bb-4f5e-48f9-8afb-d3307998d38c'
	and activeflag  = 1 ;
	



update adoptioncaseagreementrate
set provider_id =  5008134
,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-28260'
where adoptionagreementid = '7c9c2656-1f5f-4178-8a8d-094446facdff'
	and adoptionagreementrateid = 'acac4d51-537c-402f-b8db-737aa69bc58c'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '7c9c2656-1f5f-4178-8a8d-094446facdff'
	and adoptionagreementrateid = 'acac4d51-537c-402f-b8db-737aa69bc58c';

update adoptioncaserevision
set provider_id =  5008134
,
	updatedon = now(), 
	updatedby = 'CDM-28260'
where adoptionagreementid = '7c9c2656-1f5f-4178-8a8d-094446facdff'
	and adoptionagreementrateid = 'acac4d51-537c-402f-b8db-737aa69bc58c';

update adoptioncaserevision
set provider_id =  5008134
,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-28260'
where adoptionagreementid = '7c9c2656-1f5f-4178-8a8d-094446facdff'
	and adoptionagreementrateid = 'acac4d51-537c-402f-b8db-737aa69bc58c'
	and approvaldate is not null
	and activeflag = 1 ;