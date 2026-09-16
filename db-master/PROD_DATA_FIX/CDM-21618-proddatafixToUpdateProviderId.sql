
/*
   Issue Description: CDM-21618
   Category/ Module  : Prod data fix for updating Provider ID
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update guardianship set guardianoneproviderid = '6003256', updatedon = now(), updatedby = 'CDM-21618'
where gapid = 'c8854a92-5ba7-4498-ba7e-0ee3bdaccefd';

update  gapagreementrate set provider_id = '6003256', updatedon = now(), updatedby = 'CDM-21618' 
where gapagreementrateid  = '62e107b4-9c6d-463d-95fd-84c989d857d2';

update gapratesrevision set approvaldate = now(), providerid = '6003256', updatedon = now(), updatedby = 'CDM-21618'
where gaprateid = '62e107b4-9c6d-463d-95fd-84c989d857d2' and activeflag = 1;