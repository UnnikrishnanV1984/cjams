
/*
Issue: Past employees to be deleted out of CJAMS
Category/Module: User Profile
Root cause: Two users are no more with agency and removed from sailpoint. Need to delete from CJAMS
Fix provided:  Data fix has been done to remove the user from all the user profile related tables.
Data/Code fix ticket#: CJAMS-66412
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User already removed from sailpoint and data fix should resolve it
*/
update userprofile set activeflag = 0, updatedby = 'CJAMS-66412', updatedon = now() 
where securityusersid in ('a2d33374-e9f5-40da-847f-cd762ba84387', 'fd4afdc9-44c3-42eb-9c7d-7ebbf143825b') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-66412', updatedon = now() 
where securityusersid  in ('a2d33374-e9f5-40da-847f-cd762ba84387', 'fd4afdc9-44c3-42eb-9c7d-7ebbf143825b') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-66412', updatedon=now()  
where securityusersid in ('a2d33374-e9f5-40da-847f-cd762ba84387', 'fd4afdc9-44c3-42eb-9c7d-7ebbf143825b') and activeflag=1;

update teammember set activeflag = 0, updatedby = 'CJAMS-66412', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('a2d33374-e9f5-40da-847f-cd762ba84387', 'fd4afdc9-44c3-42eb-9c7d-7ebbf143825b') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-66412', updatedon=now() 
where securityusersid in ('a2d33374-e9f5-40da-847f-cd762ba84387', 'fd4afdc9-44c3-42eb-9c7d-7ebbf143825b') and activeflag=1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-66412', updatedon = now() 
where principalid in('5207', '5196')and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-66412', updatedon = now() 
where userid in (5207, 5196) and activeflag = 1;