/*
   Issue Description: CJAMS-59092
   Category/ Module  : Services: Other
   Root cause: Requested to do the data fix to delete narrative from B.Pack PID#204085076 POSC section VI.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update safecareplan
  set comments = null,
	  updatedon = now()
where objectid = 'edcfa386-7a53-43d5-9226-eaf8573133f7'
  and safecareplanid = '307d1b12-536f-485c-9991-2f8970c7a9c3'
  and activeflag = 1;
