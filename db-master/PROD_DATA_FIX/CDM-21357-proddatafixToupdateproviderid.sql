
/*
   Issue Description: CDM-21380
   Category/ Module  : Unable to end date adoption reunification
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--3151437
update guardianship set guardianoneproviderid = '5027357', updatedon = now(), updatedby = 'CDM-21357'
where gapid = 'dd378c8d-36e1-4937-bfec-5e41994b6354';

update  gapagreementrate set provider_id = '5027357', updatedon = now(), updatedby = 'CDM-21357' 
where gapagreementrateid  = 'd6082cae-4258-4096-94ff-ae76e16387d0';

update gapratesrevision set approvaldate = now(), providerid = '5027357', updatedon = now(), updatedby = 'CDM-21357'
where gaprateid = 'd6082cae-4258-4096-94ff-ae76e16387d0' and activeflag = 1;


--202102105520
update guardianship set guardianoneproviderid = '6003351', updatedon = now(), updatedby = 'CDM-21357'
where gapid = '6cfb42e3-00c9-49b3-9eee-574becc946ad';

update  gapagreementrate set provider_id = '6003351', updatedon = now(), updatedby = 'CDM-21357' 
where gapagreementrateid  = 'f8ca2343-0a75-4201-a8a9-93a2b3849ea1';

update gapratesrevision set approvaldate = now(), providerid = '6003351', updatedon = now(), updatedby = 'CDM-21357'
where gaprateid = 'f8ca2343-0a75-4201-a8a9-93a2b3849ea1' and activeflag = 1;