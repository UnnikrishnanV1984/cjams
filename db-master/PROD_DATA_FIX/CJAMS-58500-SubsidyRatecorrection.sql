/*
Issue Description: The entry dated for 3/13/25 needs to be deleted so that the entry from 4/4/24 can be corrected.
Category/Module: Support
Root cause: Old approved subsidy records cannot be changed by the user.
Fix provided: DB queries to update  record in adoptionagreementrateid and adoptioncaserevision tables.
Data/Code fix ticket#: CJAMS-58500
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/



update adoptioncaserevision
set paymentamout = 735, updatedby = 'CJAMS-58500', updatedon = now()
where adoptionrevisionid ='227f77a8-8d99-45ff-9f46-d76517f7652d' and activeflag =1;


update adoptioncaseagreementrate
set paymentamout = 735, updatedby = 'CJAMS-58500', updatedon = now()
where adoptionagreementrateid  ='aee8d531-91fe-4099-81d0-d1e1970b6ed6' and activeflag =1;