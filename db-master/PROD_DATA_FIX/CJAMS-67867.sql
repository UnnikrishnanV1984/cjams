/*
   Issue Description: CJAMS-67867
   Category/ Module  : Adoption Subsidy payment
   Root cause: user requested to updated provider id and also start date and end date for subsidy rates
   Fix provided: Data fix is done to update the date and also to updte the provider id
   Is code fix required : N
   Pull request# for data fix:8044
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update adoptioncaseagreementrate
set startdate='2026-05-01 04:00:00.000',
    approvaldate =now(),
    updatedby = 'CJAMS-67867',
    updatedon = now()
where adoptionagreementrateid ='d8ddaa21-c88d-4939-8c1b-0c57239902f2' and activeflag=1;


update adoptioncaserevision
set  startdate = '2026-05-01 04:00:00.000',
     approvaldate = now(),
    updatedby = 'CJAMS-67867',
    updatedon = now()
where adoptionagreementrateid ='d8ddaa21-c88d-4939-8c1b-0c57239902f2' and activeflag=1;


update adoptioncaseagreementrate
set enddate ='2026-04-30 00:00:00.000',
    provider_id ='5018657',
    approvaldate =now(),
    updatedby = 'CJAMS-67867',
    updatedon = now()
where adoptionagreementrateid ='4c9da0fb-02cf-4181-b1c6-b1dc4cfd8393' and activeflag=1;


update adoptioncaserevision
set  enddate  = '2026-04-30 00:00:00.000',
     provider_id ='5018657',
     approvaldate = now(),
    updatedby = 'CJAMS-67867',
    updatedon = now()
where adoptionagreementrateid ='4c9da0fb-02cf-4181-b1c6-b1dc4cfd8393'and adoptionrevisionid ='e372b1ae-8f8c-4fe9-a8e4-427e421aba39' and activeflag=1;

