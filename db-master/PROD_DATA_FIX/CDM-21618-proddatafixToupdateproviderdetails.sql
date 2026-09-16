
/*
   Issue Description: CDM-21618
   Category/ Module  : Prod data fix for updating Guardian Relation ship
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update guardianship set guardianoneproviderid = '6003256', updatedon = now(), updatedby = 'CDM-21618'
where gapid = '23f722ee-d9b6-4965-ae8e-4a3bfcd38a0e';

update  gapagreementrate set provider_id = '6003256', updatedon = now(), updatedby = 'CDM-21618' 
where gapagreementrateid  = 'a11f8b57-9662-4c5b-9a84-d0f8524eaf4e';

update gapratesrevision set approvaldate = now(), providerid = '6003256', updatedon = now(), updatedby = 'CDM-21618'
where gaprateid = 'a11f8b57-9662-4c5b-9a84-d0f8524eaf4e' and activeflag = 1;