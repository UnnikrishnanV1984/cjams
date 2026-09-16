
/*
Issue Description: Please remove Carole Friend and Charity Boyce from the dropdown list in CJAMS.
Category/Module:
Root cause: CPS Supervisor Cindy Olah requests removal of Carole Friend and Charity Boyce from her CJAMS dropdown list. Carole Friend is an adult services worker supervised by Rebecca Jester, as indicated in SailPoint. Cindy supervises Charity but will no longer receive case assignments.
Fix provided: Soft delete the team member records for Carole Friend and Charity Boyce in the teammember table, soft delete the team member assignment records for Carole Friend and Charity Boyce in the cjams.teammemberassignment table, soft delete the role mapping records for Carole Friend and Charity Boyce in the rolemapping table, and soft delete the user resource records for Carole Friend and Charity Boyce in the userresource table.
Data/Code fix ticket#:CJAMS-63870
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue involves removing specific users from a CJAMS dropdown list, which is managed through database records. No code changes are needed as the fix is handled via data updates (soft deletes) to deactivate the relevant entries in teammember, teammemberassignment, rolemapping, and userresource tables.
*/
update teammember set activeflag = 1, updatedby = 'CJAMS-63870', updatedon = now()
where teammemberid in ('9292c7d7-e016-40b3-a805-beebf6523d8f', '904f5569-7cd8-42e5-a2a7-fcf8f9e28425') and activeflag = 0;

update cjams.teammemberassignment set activeflag=1, updatedby='CJAMS-63870', updatedon=now() 
where securityusersid in ('2c6dab55-6226-494f-ab15-9d5324d35aad', '57fb5fe0-7e83-49ee-958c-1a9383b3f3a0') and activeflag=0;

/*Carole*/
update rolemapping set activeflag = 1, updatedby = 'CJAMS-63870', updatedon = now() 
where principalid='27322' and id='125993939' and activeflag = 0;

update userresource set activeflag = 1, updatedby = 'CJAMS-63870', updatedon = now() 
where userid='27322' and userresourceid in ('58a860b0-7a3a-4c91-ad19-4d6cbd9e61ba','9ad7db3a-7687-4445-9341-6eeb3592dba0')and activeflag = 0;
/*Charity*/
update rolemapping set activeflag = 1, updatedby = 'CJAMS-63870', updatedon = now() 
where id in ('151770763','151764762','151776764','157575136')
and principalid='52620' and activeflag = 0;
update userresource set activeflag = 1, updatedby = 'CJAMS-63870', updatedon = now() 
where userid='52620' and userresourceid='619d0b41-6304-45f0-abe7-9ded696c5092' and activeflag = 0;