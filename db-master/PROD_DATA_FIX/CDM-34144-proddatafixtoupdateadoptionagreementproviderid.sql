/*
   Issue Description: CDM-34144
   Category/ Module  : Prod data fix to update the adoptive prvider id
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update adoptioncaseagreement 
set providerid = 5018376, 
	updatedby = 'CDM-34144',
	updatedon = now()
where adoptioncaseid = 'fa7e9196-79fa-4dc3-a882-4112a9fd3dd5'
	and activeflag  = 1 ;


update adoptioncaseagreementrate
set provider_id = 5018376,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-34144'
where adoptionagreementid = 'fa7e9196-79fa-4dc3-a882-4112a9fd3dd5'
	and adoptionagreementrateid in ('f6948de4-8b07-42f3-a548-6c5aed3a4f17','4dfc31ac-9a03-455e-aa74-19c311836de7')
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5018376,
	updatedon = now(), 
	updatedby = 'CDM-34144'
where adoptionagreementid = 'fa7e9196-79fa-4dc3-a882-4112a9fd3dd5'
	and adoptionagreementrateid in ('f6948de4-8b07-42f3-a548-6c5aed3a4f17','4dfc31ac-9a03-455e-aa74-19c311836de7')
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5018376,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-34144'
where adoptionagreementid = 'fa7e9196-79fa-4dc3-a882-4112a9fd3dd5'
	and adoptionagreementrateid in ('f6948de4-8b07-42f3-a548-6c5aed3a4f17','4dfc31ac-9a03-455e-aa74-19c311836de7')
	and approvaldate is not null
	and activeflag = 1 ;