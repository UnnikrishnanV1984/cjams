-- CDM-39466 - CW intake & User management 
/* Issue Description:User is no more active in cjams 

-- Intake case number: I221010334015, I221010322984, I221010297556, I221010289976, I221010274512, I221010245838, I211010209057

-- Category/ Module: Workload and user management 

-- Root cause: User is no more active in cjams
-- Fix Provided: Datafix has been provided to delete intake and worker
-- Pull request# N/A

*/
---Delete intakes
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39466'
where intakenumber in ('I221010334015', 'I221010322984', 'I221010297556', 'I221010289976', 'I221010274512', 'I221010245838', 'I211010209057') and activeflag =1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39466'
where intakenumber in ('I221010334015', 'I221010322984', 'I221010297556', 'I221010289976', 'I221010274512', 'I221010245838', 'I211010209057') and activeflag =1;	
---deactiavte user
update userprofile set activeflag = 0, updatedby = 'CDM-39466', updatedon = now() 
where securityusersid in ('9a2cdf05-9645-40d7-acf5-2af15980f663') and activeflag = 1;

update muser set activeflag = 0, updatedby = 'CDM-39466', updatedon = now() 
where securityusersid in ('9a2cdf05-9645-40d7-acf5-2af15980f663')  and activeflag = 1;

update cjams.securityusers set activeflag=0, updatedby='CDM-39466', updatedon=now()  
where securityusersid in ('9a2cdf05-9645-40d7-acf5-2af15980f663') and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CDM-39466', updatedon=now() 
where securityusersid in ('9a2cdf05-9645-40d7-acf5-2af15980f663') and activeflag = 1;

update rolemapping set activeflag = 0, updatedby = 'CDM-39466', updatedon = now() 
where principalid in ('4839') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CDM-39466', updatedon = now() 
where userid in (4839) and activeflag = 1;

UPDATE teammember SET activeflag = 0,	updatedby = 'CDM-39466',updatedon = now()
WHERE teammemberid IN ('e37e602a-d827-4f68-94f1-99209c67c477') and activeflag = 1;