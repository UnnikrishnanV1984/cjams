/*
Issue: CJAMS-66980 Incorrect Suspension Dates
Category/Module: GAP / Suspension
Root cause: Please remove the two manual suspension and change the auto suspension start date from 04/20/2026 to 03/20/2026.

 In this case, there are three suspension available, user created two manual suspension with the start date is 03/20/2026 and 03/22/2026, and one suspension (04/20/2026) was created by the system as the adopted child is removed in case # 231030152077 with start date is 03/20/2026. So we can not removed the suspension with start date 04/20/2026, This start date we can change manually once Manual suspensions are removed
Fix provided:  Data fix has been done to remove the incorrect GAP suspension record and trigger the pending payments.
Data/Code fix ticket#: CJAMS-65035
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Draft suspension created and data fix needed for this issue.
*/



update adoptioncasesuspension
set activeflag = 0, updatedon =now(), updatedby ='CJAMS-66980'
where adoptionsuspensionid  in ('a56cf48f-0270-47a8-a2ce-b833d3667afc','f45461c6-1cc3-4e1d-b010-7b1e4a64a0a3')
and activeflag=1;


update adoptioncasesuspensionrevision
set activeflag = 0, updatedon =now(), updatedby ='CJAMS-66980'
where adoptionsuspensionid in ('a56cf48f-0270-47a8-a2ce-b833d3667afc','f45461c6-1cc3-4e1d-b010-7b1e4a64a0a3')
and activeflag=1;


update routing
set activeflag = 0, updatedon =now(), updatedby ='CJAMS-66980'
where objectid in ('a56cf48f-0270-47a8-a2ce-b833d3667afc','f45461c6-1cc3-4e1d-b010-7b1e4a64a0a3')
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon =now(), updatedby ='CJAMS-66980'
where adoptionagreementrateid = 'c9e52fef-247f-411e-ae07-4cb2943bbb53'
and activeflag = 1;