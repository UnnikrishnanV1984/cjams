/*
   Issue Description: CDM-34571
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update adoptionagreement set activeflag = 0, updatedby = 'CDM-34571', updatedon = now()
where adoptionagreementid in ('6bee116a-6054-43e4-96c2-a207c118bcca', 'bafecf19-a724-4dc0-b4fa-9c0a7d3a9633',
'87453d59-fa2c-47dc-99bf-ad5978d67044','1c5d48ba-bb07-458e-b21b-69cc20383045','cf293794-8ae0-4db3-907d-0940263dc4fb') and activeflag = 1;

update adoptionagreementraterevision set activeflag = 0, updatedby = 'CDM-34571', updatedon = now()
where adoptionagreementid in ('6bee116a-6054-43e4-96c2-a207c118bcca','bafecf19-a724-4dc0-b4fa-9c0a7d3a9633',
'87453d59-fa2c-47dc-99bf-ad5978d67044','1c5d48ba-bb07-458e-b21b-69cc20383045','cf293794-8ae0-4db3-907d-0940263dc4fb') and activeflag = 1;
