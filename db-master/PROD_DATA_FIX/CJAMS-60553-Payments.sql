/*
Issue:Subsidy rate tab did not update correctly after assigning a new provider in the adoption agreemen
Category/Module: Bug
Root cause: The previous provider’s subsidy rate slab was not ended before switching to the new provider, and the “Switch Adoptive Parent” button was not used to trigger the proper update.
Fix provided: DB queries  update enddate intakeservreqchildremoval tables
Data/Code fix ticket#: CJAMS-60553
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The fix required is a data correction and proper user workflow (clicking the Switch button before assigning a new provider).
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreementrate
set startdate = '2025-06-17 00:00:00' , enddate = '2026-06-16 00:00:00', updatedby = 'CJAMS-60553', updatedon = NOW(), provider_id = '6222021'
where adoptionagreementrateid  = '9473ed42-f94d-406d-8666-dc94959c0cce' and adoptionagreementid = '16a8796a-2b13-482f-96f6-4b920f230b46' and activeflag = 1;


update adoptioncaseagreementrate
set enddate = '2025-06-16 00:00:00', updatedby = 'CJAMS-60553', updatedon = NOW()
where adoptionagreementrateid  = '7359f887-2a6e-4628-abfa-87d26c730cb7' and adoptionagreementid = '16a8796a-2b13-482f-96f6-4b920f230b46' and activeflag = 1;


update adoptioncaserevision
set startdate = '2025-06-17 00:00:00' , enddate = '2026-06-16 00:00:00', updatedby = 'CJAMS-60553', updatedon = NOW(), provider_id = '6222021'
where adoptionrevisionid  = '4051e945-b961-4f65-b1fb-09fa8aa4db21' and activeflag = 1;


update adoptioncaserevision
set enddate = '2025-06-16 00:00:00', updatedby = 'CJAMS-60553', updatedon = NOW()
where adoptionrevisionid = '21f5c2fd-261c-4eb9-8249-6a6c1685af8f'  and activeflag = 1;
