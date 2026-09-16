/*
-- CDM-29178 - Am unable to pull Provider ID number 
-- Issue Description: 
   Am unable to pull Provider ID number 
   Provider name & ID are not populated in the adoption agreement and subsidy rate screen.
   email# mavis.asare-dwamenah@maryland.gov
*/

-- Update Provider ID: 5003403

select adoptionagreementid, providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'a54a9ac7-8201-44db-9abb-e32c4af4251d'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5003403, 
	parent1providerid = 5003403, 
	parent1providername = 'Trina Brown', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-29178',
	updatedon = now()
where adoptioncaseid = 'a54a9ac7-8201-44db-9abb-e32c4af4251d'
	and activeflag  = 1 ;

select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
, adoptionagreementrateid 
    from adoptioncaseagreementrate
where adoptionagreementid = '6cb8ca47-983f-4c45-bedd-806b1aed924b'
    and activeflag = 1 
order by startdate desc;

-- Update Provider ID as 5003403
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '6cb8ca47-983f-4c45-bedd-806b1aed924b'
	and adoptionagreementrateid = 'c7a85389-3660-4f14-b5e5-9e557674192a'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5003403,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29178'
where adoptionagreementid = '6cb8ca47-983f-4c45-bedd-806b1aed924b'
	and adoptionagreementrateid = 'c7a85389-3660-4f14-b5e5-9e557674192a'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '6cb8ca47-983f-4c45-bedd-806b1aed924b'
	and adoptionagreementrateid = 'c7a85389-3660-4f14-b5e5-9e557674192a';

update adoptioncaserevision
set provider_id = 5003403,
	updatedon = now(), 
	updatedby = 'CDM-29178'
where adoptionagreementid = '6cb8ca47-983f-4c45-bedd-806b1aed924b'
	and adoptionagreementrateid = 'c7a85389-3660-4f14-b5e5-9e557674192a';

update adoptioncaserevision
set provider_id = 5003403,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-28824'
where adoptionagreementid = '6cb8ca47-983f-4c45-bedd-806b1aed924b'
	and adoptionagreementrateid = 'c7a85389-3660-4f14-b5e5-9e557674192a'
	and approvaldate is not null
	and activeflag = 1 ; 