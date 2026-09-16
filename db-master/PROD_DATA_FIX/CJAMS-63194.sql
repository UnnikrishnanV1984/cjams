/*
Issue: CJAMS-63194 Remove staff from pick list
Category/Module: User Profile
Root cause: Below users are no more with agency and removed from sailpoint. Need to delete from CJAMS
			jamie.kane@maryland.gov
			lorrie.brennan@maryland.gov
			melissa.thomaswicks@maryland.gov

Fix provided:  Data fix has been done to remove the user from all the user profile related tables.
Data/Code fix ticket#: CJAMS-63194
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User already removed from sailpoint and data fix should resolve it
*/

/*
jamie.kane@maryland.gov				211a82cf-e115-4cd8-90c5-08758b0935c5	9534
lorrie.brennan@maryland.gov			2cee5e56-05ff-4e2f-af09-6e6e0ad487a6	4878
melissa.thomaswicks@maryland.gov	2d83fec2-644b-4c77-be45-edf55a1d0428	5232
*/

update userprofile set activeflag = 0, updatedby = 'CJAMS-63194', updatedon = now() 
where securityusersid in ('211a82cf-e115-4cd8-90c5-08758b0935c5', '2cee5e56-05ff-4e2f-af09-6e6e0ad487a6', '2d83fec2-644b-4c77-be45-edf55a1d0428') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-63194', updatedon = now() 
where securityusersid  in ('211a82cf-e115-4cd8-90c5-08758b0935c5', '2cee5e56-05ff-4e2f-af09-6e6e0ad487a6', '2d83fec2-644b-4c77-be45-edf55a1d0428') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-63194', updatedon=now()  
where securityusersid in ('211a82cf-e115-4cd8-90c5-08758b0935c5', '2cee5e56-05ff-4e2f-af09-6e6e0ad487a6', '2d83fec2-644b-4c77-be45-edf55a1d0428') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-63194', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('211a82cf-e115-4cd8-90c5-08758b0935c5', '2cee5e56-05ff-4e2f-af09-6e6e0ad487a6', '2d83fec2-644b-4c77-be45-edf55a1d0428') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-63194', updatedon=now() 
where securityusersid in('211a82cf-e115-4cd8-90c5-08758b0935c5', '2cee5e56-05ff-4e2f-af09-6e6e0ad487a6', '2d83fec2-644b-4c77-be45-edf55a1d0428') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-63194', updatedon = now() 
where principalid in('9534', '4878', '5232') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-63194', updatedon = now() 
where userid in (9534, 4878, 5232) and activeflag = 1;