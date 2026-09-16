 /*
  Issue Description: CDM-29316 FTDM Role issue - Cleanup 
   Category/ Module  :  User management
   Root cause: Clean up the FTDM role 
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
--'jennifer.pettis@maryland.gov' 
--remove role CJAMS_SSA_FTDM_QI_SUPERVISOR 
select * from cjams.userresource    where userid='9660' and activeflag =1
and roleid =5989 and permissiongroupid ='2105ed26-fdaf-41d5-aca8-19b334f78daa';

update cjams.userresource set activeflag =0, updatedby ='CDM-29316', updatedon = now() 
where userid='9660' and activeflag =1
and roleid =5989 and permissiongroupid ='2105ed26-fdaf-41d5-aca8-19b334f78daa';

--remove this role CJAMS_SSA_FTDM_FACILITATOR
/*'ashley.stuck@maryland.gov',
'katie.hitch@maryland.gov',
'melissa.moore@maryland.gov',
'shanae.jones@maryland.gov',
'dawn.jackson1@maryland.gov',
'nicole.logan@maryland.gov',
'jennifer.evans@maryland.gov'*/
select * from rolemapping r  where principalid in (
'4067',
'14528',
'9694',
'9731',
'9778',
'9986',
'9600'
) and activeflag =1 and teamtypekey='CW'
and roleid=5987;
/*
update rolemapping set activeflag =0, updatedby ='CDM-29316', updatedon = now()  where principalid in (
'4067',
'14528',
'9694',
'9731',
'9778',
'9986',
'9600'
) and activeflag =1 and teamtypekey='CW'
and roleid=5987;*/


--Revert it back to CWCW
/*'ashley.stuck@maryland.gov',
'katie.hitch@maryland.gov',
'melissa.moore@maryland.gov'*/
select * from rolemapping r  where principalid in (
'4067',
'14528',
'9694'
) 
--and activeflag =1 
and teamtypekey='CW'
and roleid=5987;

update cjams.rolemapping set  roleid  =71, updatedby ='CDM-29316', updatedon = now()   where principalid in (
'4067',
'14528',
'9694'
) 
--and activeflag =1 
and teamtypekey='CW'
and roleid=5987;

--Revert it back to CWSP
/*'shanae.jones@maryland.gov',
'dawn.jackson1@maryland.gov',
'nicole.logan@maryland.gov',
'jennifer.evans@maryland.gov'*/

select * from cjams.rolemapping r  where principalid in (
'9731',
'9778',
'9986',
'9600'
) 
--and activeflag =1 
and teamtypekey='CW'
and roleid=5987;

update cjams.rolemapping set roleid  =36, updatedby ='CDM-29316', updatedon = now()  where principalid in (
'9731',
'9778',
'9986',
'9600'
) 
--and activeflag =1 
and teamtypekey='CW'
and roleid=5987;