
/*
   Issue Description: CDM-21618
   Category/ Module  : Prod data fix for updating Guardian Relation ship
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 5078797
update adoptioncaseagreement set providerid = '5078605', parent1providerid = '5078605', parent2providerid = null, updatedby = 'CDM-21776', updatedon = now() 
 where adoptionagreementid = '2354720d-4f13-454c-abc0-a2d82faf7386';

-- 2022-02-10 05:00:00
update adoptioncaseagreementrate set enddate = '2021-10-04 05:00:00', approvaldate = now(), updatedby = 'CDM-21776', updatedon = now() 
where adoptionagreementrateid = '47e9fe24-430f-493d-b274-5bac57b88c9d';

update adoptioncaserevision set enddate = '2021-10-04 05:00:00', approvaldate = now(), updatedby = 'CDM-21766', updatedon = now() 
where adoptionagreementrateid = '47e9fe24-430f-493d-b274-5bac57b88c9d' and adoptionagreementid = '2354720d-4f13-454c-abc0-a2d82faf7386'
and activeflag = 1;

