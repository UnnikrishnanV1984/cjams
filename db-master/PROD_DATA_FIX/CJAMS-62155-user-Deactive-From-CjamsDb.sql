/*
  Issue Description: CJAMS-62155 Datafix required to deactivate below two user profiles in cjams db
                     almonique.vaughan@montgomerycountymd.gov                 
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             jocelyn.tillman2@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No 
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: almonique.vaughan@montgomerycountymd.gov
--securityuserid: 3ecaf5cd-9451-48a6-a9c8-bfcde1bd1e24
-- id : 75500144


update userprofile set activeflag = 0, updatedby = 'CJAMS-62155', updatedon = now() 
where securityusersid in ('3ecaf5cd-9451-48a6-a9c8-bfcde1bd1e24') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-62155', updatedon = now() 
where securityusersid  in ('3ecaf5cd-9451-48a6-a9c8-bfcde1bd1e24') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62155', updatedon=now()  
where securityusersid in ('3ecaf5cd-9451-48a6-a9c8-bfcde1bd1e24') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62155', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('3ecaf5cd-9451-48a6-a9c8-bfcde1bd1e24') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62155', updatedon=now() 
where securityusersid in('3ecaf5cd-9451-48a6-a9c8-bfcde1bd1e24') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-62155', updatedon = now() 
where id in('75500144') and activeflag = 1;

--no records
update userresource set activeflag = 0, updatedby = 'CJAMS-62155', updatedon = now() 
where userresourceid in ('619831e1-dc44-4b58-a45e-a92896fc70e9',
'e3572598-2898-49ff-b252-ed835e1d951d',
'8c072083-5cfd-4c0c-a8fb-09f7e9b41cd8',
'e037096b-6f9e-4917-acdb-4cad70018b3a',
'04fc8a0c-2125-4421-9333-f14c108ec8bc',
'ce99c981-fa9a-4e6e-bbb6-1b1e52f20de9') and activeflag = 1;