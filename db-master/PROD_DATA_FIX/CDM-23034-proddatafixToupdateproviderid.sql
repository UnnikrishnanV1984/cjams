/*
   Issue Description: CDM-23034
   Category/ Module  : Prod data fix to update provider id
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



 update guardianship set guardianoneproviderid = '5095312',updatedon = now(), updatedby = 'CDM-23034'
 where gapid in ('d1515dbe-7759-4926-90e1-2bb5f3d68287','a485edd7-787c-4e16-bdbc-8e4a4d910116');

update  gapagreementrate set provider_id = '5095312', updatedon = now(), updatedby = 'CDM-23034' 
where gapagreementrateid  in ('1836debb-c8aa-4860-aae0-60fbf09b6645','4a28dbde-8b1e-4bb6-a621-f173ae1748ba');

update gapratesrevision set approvaldate = now(), providerid = '5095312', updatedon = now(), updatedby = 'CDM-23034'
where gaprateid in ('1836debb-c8aa-4860-aae0-60fbf09b6645','4a28dbde-8b1e-4bb6-a621-f173ae1748ba') and activeflag = 1;