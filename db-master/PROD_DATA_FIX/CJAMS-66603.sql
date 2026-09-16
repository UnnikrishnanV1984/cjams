/*
Issue: LGA unit and worker name, Sara Donham need to be removed from CJAMS workload list
Category/Module: User Profile
Root cause: Below users are no more with agency and removed from sailpoint. Need to delete from CJAMS
			kelsie.hardesty@maryland.gov
			sara.donham@maryland.gov 
Fix provided:  Data fix has been done to remove the user from all the user profile related tables.
Data/Code fix ticket#: CJAMS-66603
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User already removed from sailpoint and data fix should resolve it
*/
update userprofile set activeflag = 0, updatedby = 'CJAMS-66603', updatedon = now() 
where securityusersid in ('3051cee0-9551-4665-8c87-d2421a0f2fe3', '991e43ab-c06b-4195-b446-c4f80ef8433a') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-66603', updatedon = now() 
where securityusersid  in ('3051cee0-9551-4665-8c87-d2421a0f2fe3', '991e43ab-c06b-4195-b446-c4f80ef8433a') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-66603', updatedon=now()  
where securityusersid in ('3051cee0-9551-4665-8c87-d2421a0f2fe3', '991e43ab-c06b-4195-b446-c4f80ef8433a') and activeflag=1;

update teammember set activeflag = 0, updatedby = 'CJAMS-66603', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('3051cee0-9551-4665-8c87-d2421a0f2fe3', '991e43ab-c06b-4195-b446-c4f80ef8433a') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-66603', updatedon=now() 
where securityusersid in ('3051cee0-9551-4665-8c87-d2421a0f2fe3', '991e43ab-c06b-4195-b446-c4f80ef8433a') and activeflag=1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-66603', updatedon = now() 
where principalid in('11950', '3999')and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-66603', updatedon = now() 
where userid in (11950, 3999) and activeflag = 1;
