/*
  Issue Description: CDM-24352 Unable to assign cases
   Category/ Module  :  user management
   Root cause: Central Policy Staff,CW role was present in the useresource table
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

-- denise.braun@maryland.gov
update userresource 
set activeflag = 0 , updatedon = now(), updatedby = 'CDM-24352'
where userresourceid ='8f790549-57e3-465c-b10e-1361c06e28c0' and roleid =3150 and userid =3305 and activeflag = 1;

--remove the unwanted role for the user (removed cw supervisor role and update it with IV-E role)
update rolemapping 
set roleid = 1750, updatedon = now(), updatedby ='CDM-24352'
where roleid = 36 and id= 95489475 and principalid =3305;