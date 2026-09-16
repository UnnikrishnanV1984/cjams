/*
  Issue Description: CJAMS-62249 Datafix required to deactivate below two user profiles in cjams db
                     alexandra.mcclellan@maryland.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             alexandra.mcclellan@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: alexandra.mcclellan@maryland.gov
--securityuserid: 7aabe9fe-8838-41a9-a953-f17e3c9c5de9
-- id : ('130408960','45999228')


update userprofile set activeflag = 0, updatedby = 'CJAMS-62249', updatedon = now() 
where securityusersid in ('7aabe9fe-8838-41a9-a953-f17e3c9c5de9') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-62249', updatedon = now() 
where securityusersid  in ('7aabe9fe-8838-41a9-a953-f17e3c9c5de9') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62249', updatedon=now()  
where securityusersid in ('7aabe9fe-8838-41a9-a953-f17e3c9c5de9') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62249', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('7aabe9fe-8838-41a9-a953-f17e3c9c5de9') and activeflag=1) 
and activeflag = 1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62249', updatedon = now()
where teammemberid='f4785055-0f5f-4250-af15-0d13b6a99233' and activeflag=1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62249', updatedon=now() 
where securityusersid in('7aabe9fe-8838-41a9-a953-f17e3c9c5de9') and activeflag =1;

update cjams.as_teammemberassignment set activeflag=0, updatedby='CJAMS-62249', updatedon=now() 
where teammemberid in('f4785055-0f5f-4250-af15-0d13b6a99233')and securityusersid='7aabe9fe-8838-41a9-a953-f17e3c9c5de9' and activeflag =1;


update rolemapping set activeflag = 0, updatedby = 'CJAMS-62249', updatedon = now() 
where id in('130408960','45999228') and activeflag = 1;

--no records
update userresource set activeflag = 0, updatedby = 'CJAMS-62249', updatedon = now() 
where userresourceid  in ('c95c897b-a1ff-4c08-aa11-f3f56e0847d0') and activeflag = 1;
