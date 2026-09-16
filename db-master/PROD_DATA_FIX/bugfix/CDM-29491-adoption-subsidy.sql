/*
   Issue Description: CDM-29491
   Category/ Module  :adoption-subsidy
   Pull request# for code fix: not a code fix
   Reason why no related code fix: BA requested a data fix
   Status of the code fix if already submitted and expected prod fix date: 
*/


update adoptioncaseagreement 
set updatedby = 'CDM-29491', updatedon = now(),
effectiveswitchdate = '2022-11-30 05:00:00' where adoptionagreementid = 'd6a4e0ec-3b8a-46a1-b67e-75ae60eb2ee1';

update adoptioncaseagreementrate
set updatedby = 'CDM-29491', updatedon = now(),
activeflag = 0 where adoptionagreementrateid in('be58b026-d5a9-43c4-8570-0137dbbe0b77');

update adoptioncaseagreementrate 
set updatedby = 'CDM-29491', updatedon = now(),
enddate = '2022-11-30 08:00:00' where adoptionagreementrateid in('6a46f1ea-ae2e-470d-8c44-b554f3dfb84b');

update adoptioncaserevision set enddate = '2022-11-30 08:00:00',updatedby = 'CDM-29491', updatedon = now()
where adoptionagreementrateid in('6a46f1ea-ae2e-470d-8c44-b554f3dfb84b');

update adoptioncaseagreementrate set updatedby = 'CDM-29829', updatedon = now(),approvaldate = now()
where adoptionagreementid = 'd6a4e0ec-3b8a-46a1-b67e-75ae60eb2ee1'
and adoptionagreementrateid 
in ('e9e92780-1865-4c7e-b64e-5592e0591ea5',
'15845a67-3f68-48b3-aa13-1ff4cd3cdf03',
'6a46f1ea-ae2e-470d-8c44-b554f3dfb84b');