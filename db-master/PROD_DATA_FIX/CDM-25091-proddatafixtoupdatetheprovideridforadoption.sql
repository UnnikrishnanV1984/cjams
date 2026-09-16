/*
   Issue Description: CDM-25091
   Category/ Module  : Prod data fix to update the provider ID for adoption
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update adoptioncaseagreementrate set provider_id = '5057103', updatedon = now(), updatedby = 'CDM-25091' 
where adoptionagreementrateid = '68f22485-2328-47bf-accf-94a528800c06';

update adoptioncaserevision set provider_id = '5057103', updatedon = now(), updatedby = 'CDM-25091',approvaldate = now()  
where adoptionagreementrateid = '68f22485-2328-47bf-accf-94a528800c06';