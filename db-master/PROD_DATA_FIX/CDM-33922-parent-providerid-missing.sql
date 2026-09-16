/*
   Issue Description: CDM-33922
   Category/ Module  : Subisdy rate
   Root cause: Parent 1 provider id  missing
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptioncaseagreement set parent1providerid ='5007806' ,updatedby= 'CDM-33922',updatedon =now() where adoptioncaseid ='30674246-7ee4-45bc-ae17-8ffc2f918cb8';

update adoptioncaserevision
set provider_id = 5007806,
	updatedon = now(), 
	updatedby = 'CDM-33922'
where adoptionagreementid = '887efa61-252b-489d-a4a9-8daec87d274c'
	and adoptionagreementrateid = 'b1b62d9d-36f9-4bfe-b13f-d1ccd332623b'
   and approvaldate is not null
	and activeflag = 1 ;
	
update adoptioncaseagreementrate
set provider_id = 5007806,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-33922'
where adoptionagreementid = '887efa61-252b-489d-a4a9-8daec87d274c'
	and adoptionagreementrateid = 'b1b62d9d-36f9-4bfe-b13f-d1ccd332623b'
	and activeflag = 1 ;