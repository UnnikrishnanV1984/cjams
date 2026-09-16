/*
 Issue Description:CJAMS-61680
 Category/ Module: Workload
 Root cause:Partial fix as well as wrong fix was provided on CJAMS-61680 to remove the worker idania.hernandez@montgomerycountymd.gov
 from the CJAMS as the user is still active in the AS instead the user was deactivated from the user profile.
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 previous fix file: CJAMS-61680-user-Deactive-From-CjamsDb.sql
 */
update userprofile
set activeflag = 1, 
	updatedby = 'CJAMS-61680', 
	updatedon = now() 
where securityusersid = '76038e22-8708-44fe-b59e-1c9b747f66ed' and activeflag=0;

update muser
set activeflag = 1, 
	updatedby = 'CJAMS-61680', 
	updatedon = now() 
where securityusersid = '76038e22-8708-44fe-b59e-1c9b747f66ed' and activeflag=0;

update securityusers
set activeflag = 1, 
	updatedby = 'CJAMS-61680', 
	updatedon = now() 
where securityusersid = '76038e22-8708-44fe-b59e-1c9b747f66ed' and activeflag=0;

--select activeflag ,updatedby ,id ,* from muser u where securityusersid  = '76038e22-8708-44fe-b59e-1c9b747f66ed'
--select * from rolemapping r where principalid  ='4746';

update rolemapping 
set activeflag = 0, 
	updatedby = 'CJAMS-61680', 
	updatedon = now() 
where principalid  = '4746' and roleid = 3512 and activeflag=1;