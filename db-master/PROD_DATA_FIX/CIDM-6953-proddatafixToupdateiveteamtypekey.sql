/*
   Issue Description: CIDM-6953
   Category/ Module  : Prod data fix to update correct IVE Role Mapping
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- CW
update teammemberroletype set teamtypekey = 'IV-E' , updatedon = now() , updatedby = 'CIDM-6953'
where 
description in ('IV-E Eligibility Analyst',
'IV-E Eligibility Quality Assurance',
'IV-E Eligibility Administrator', 'IV-E Eligibility Administrator Assistant') and activeflag = 1;