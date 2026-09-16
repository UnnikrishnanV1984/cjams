
/*Issue Description: CJAMS access removal
Category/Module: User Access
Root cause: Pamela Bowser transitioned to a new role and was removed from CJAMS roles in Sailpoint, but remains an active user in the CJAMS database, necessitating a manual data deactivation
Fix provided: DB query to deactivate the user in all relevant CJAMS user tables from the backend.
Code/Data fix ticket#: CJAMS-66507
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: A datafix is being performed to manually deactivate the user in the CJAMS database
*/
update userprofile set activeflag = 0, updatedby = 'CJAMS-66507', updatedon = now() 
where securityusersid='8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40' and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-66507', updatedon = now() 
where securityusersid='8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40' and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-66507', updatedon=now()  
where securityusersid='8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40' and activeflag=1;

update teammember set activeflag = 0, updatedby = 'CJAMS-66507', updatedon = now()
where teammemberid= (select teammemberid from teammemberassignment where securityusersid='8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40' and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-66507', updatedon=now() 
where securityusersid='8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40' and activeflag=1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-66507', updatedon = now() 
where principalid='5225' and activeflag = 1;

update userresource  set activeflag = 0, updatedby = 'CJAMS-66507', updatedon = now() 
where userid ='5225' and activeflag = 1;

update userprofileaddress set activeflag = 0, updatedby = 'CJAMS-66507', updatedon = now() 
where securityusersid='8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40' and activeflag=1;

update as_teammemberassignment set activeflag=0, updatedby='CJAMS-66507', updatedon=now() 
where securityusersid='8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40' and activeflag=1;

--as_teammemberassignment has a record with teammemberid 'a552d205-d277-4486-82e1-ef3048b814e4'.
update teammember set activeflag=0, updatedby='CJAMS-66507', updatedon=now() 
where teammemberid='a552d205-d277-4486-82e1-ef3048b814e4' and activeflag=1;