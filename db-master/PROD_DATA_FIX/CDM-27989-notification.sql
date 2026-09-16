 /*
  Issue Description: CDM-27989 
   Category/ Module  :  Incorrect MD THINK System alerts forCJAMS
   Root cause:
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update usernotificationmap set activeflag=0, updatedby='CDM-27989', updatedon=now() 
where Tosecurityusersid  = '68ef9cf7-bc1f-4b84-86bf-ee867d3d215d' and activeflag=1
and usernotificationid in (select usernotificationid from usernotification where
Securityusersid = '68ef9cf7-bc1f-4b84-86bf-ee867d3d215d' and activeflag=1);

update usernotification set activeflag=0, updatedby='CDM-27989', updatedon=now() where
Securityusersid = '68ef9cf7-bc1f-4b84-86bf-ee867d3d215d' and activeflag=1;

-- Deacitvating IVE for this role 126 -Admin Audit Monitor CQI
update cjams.role_resource set activeflag=0, updatedby='CDM-27989', updatedon=now() 
where roleid=126 and activeflag=1 and resourceid='9a29e0be-1506-4b30-a2c3-8b4ac0c8a1e0';