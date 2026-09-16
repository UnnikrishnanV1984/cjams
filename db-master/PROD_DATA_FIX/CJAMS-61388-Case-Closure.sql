/*
   Issue Description: CJAMS-61388
   Category/ Module  : remove service case /intake
   Root cause: User Request, Case opened in error. No persons to be confirmed. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
--Remove intake
select * from CW_transactions_dataclenup('INTKE','I251013340286','CJAMS-61388');

--remove servicecase
--select * from servicecase s where servicecasenumber = '251030550063'
update servicecase set activeflag =0, updatedby = 'CJAMS-61388', updatedon = now() 
where servicecaseid = '1a3618db-b35d-44bb-90f5-3f1700e8a863' and activeflag=1;

update caseassignment set activeflag = 0, updatedby = 'CJAMS-61388', updatedon = now() 
where objectid = '1a3618db-b35d-44bb-90f5-3f1700e8a863' and activeflag = 1 ;

update servicecasedisposition set activeflag = 0, updatedby = 'CJAMS-61388', updatedon = now() 
where servicecaseid = '1a3618db-b35d-44bb-90f5-3f1700e8a863' and activeflag=1;

update routing
set activeflag = 0,
	updatedby = 'CJAMS-61388',
	updatedon = now()
where objectid = '1a3618db-b35d-44bb-90f5-3f1700e8a863'
	and activeflag=1;