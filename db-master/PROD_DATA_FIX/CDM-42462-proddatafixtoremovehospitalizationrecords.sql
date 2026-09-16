/*
   Issue Description: CDM-42462
   Category/ Module  : Prod data fix to Remove Living arrangement
   Root cause:
   Pull request# for code fix: CIDM-9735
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update placement set activeflag = 0, updatedby = 'CDM-42462', updatedon = now()
where placementid = '0b269f5d-4b59-43db-a546-42875f909836';


update livingarrangement set activeflag = 0, updatedby = 'CDM-42462', updatedon = now()
where placementid = '0b269f5d-4b59-43db-a546-42875f909836';

update placementrevision set activeflag = 0, updatedby = 'CDM-42462', updatedon = now()
where placementid = '0b269f5d-4b59-43db-a546-42875f909836';

update routing set activeflag = 0, updatedby = 'CDM-42462', updatedon = now()
where routingid = '1638f004-c546-42a0-b0f4-b7cf1ec3fb2f';


update personhospitalization set activeflag = 0, updatedby = 'CDM-42462', updatedon = now()
where hospitalizationid in ('3636bd2f-aed2-4105-a05a-89844c922bef','b0a7f012-5709-4421-97f8-25d694ef8f2a', '79f044d3-f392-424f-bdf0-f446d24ecb49');