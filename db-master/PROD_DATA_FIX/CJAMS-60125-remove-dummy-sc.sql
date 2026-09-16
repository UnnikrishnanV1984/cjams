/*
   Issue Description: CJAMS-60125
   Category/ Module  : remove service case 
   Root cause: User Request, This case the duplicate where all the information was moved to the other case
   and now user wants to delete this dummy service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update servicecase set activeflag =0, updatedby = 'CJAMS-60125', updatedon = now() 
where servicecaseid = '1e684e24-d49b-4276-bf8c-c1cb82000344' and activeflag=1;

update caseassignment set activeflag = 0, updatedby = 'CJAMS-60125', updatedon = now() 
where objectid = '1e684e24-d49b-4276-bf8c-c1cb82000344' and activeflag = 1 ;

update servicecasedisposition set activeflag = 0, updatedby = 'CJAMS-60125', updatedon = now() 
where servicecaseid = '1e684e24-d49b-4276-bf8c-c1cb82000344' and activeflag=1;

update routing
set activeflag = 0,
	updatedby = 'CJAMS-60125',
	updatedon = now()
where objectid = '1e684e24-d49b-4276-bf8c-c1cb82000344'
	and activeflag=1;