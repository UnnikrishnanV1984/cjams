/*
   Issue Description: CDM-35099
   Category/ Module  : Prod data fix to update the provider id details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptioncaseagreement  set providerid = 5025881, parent1providerid = 5025881, updatedby = 'CDM-35099', updatedon = now()
where adoptionagreementid = '38b1b46a-e58b-42e9-872b-4d028088a207' and activeflag  = 1 ;

update adoptioncaseagreementrate set provider_id ='5025881', approvaldate = now(), updatedby = 'CDM-35099',updatedon = now() 
where adoptionagreementid='38b1b46a-e58b-42e9-872b-4d028088a207' and
adoptionagreementrateid in ('32a28d7a-cec3-4280-94e1-e1c0d23bc2dd','7e791d66-5c55-431b-a5a9-43200cb4f1a8');

update adoptioncaserevision set provider_id = 5025881, updatedon = now(), updatedby = 'CDM-35099'
where adoptionagreementid = '38b1b46a-e58b-42e9-872b-4d028088a207' and adoptionagreementrateid in ('32a28d7a-cec3-4280-94e1-e1c0d23bc2dd','7e791d66-5c55-431b-a5a9-43200cb4f1a8') and approvaldate is not null
and activeflag = 1 ;
