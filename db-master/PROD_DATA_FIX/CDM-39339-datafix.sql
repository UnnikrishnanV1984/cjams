/*
   Issue Description: CDM-39339
   Category/ Module  : Approval
   Root cause:Dummy service case (241030337699) created by CJAMS and there is no person available in the person tab.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update servicecase set activeflag =0, updatedby = 'CDM-39339', updatedon = now() 
where servicecaseid = 'ad73a764-ce0c-4bb9-844c-aa946a4ac03e' and activeflag=1;

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-39339', updatedon = now() 
where servicecaseid = 'ad73a764-ce0c-4bb9-844c-aa946a4ac03e' and activeflag=1;

update servicecaserequest set activeflag = 0, updatedby = 'CDM-39339', updatedon = now() 
where servicecaseid = 'ad73a764-ce0c-4bb9-844c-aa946a4ac03e' and activeflag=1;

update routing set activeflag=0 where objectid='ad73a764-ce0c-4bb9-844c-aa946a4ac03e'
and eventcode='SRVC' and activeflag = 1;