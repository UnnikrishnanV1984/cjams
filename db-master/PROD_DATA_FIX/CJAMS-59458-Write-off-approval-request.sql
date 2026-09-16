/*
   Issue Description: CJAMS-59458
   Category/ Module  : write-off account Receivable
   Root cause: Request went to the deactivated Financial Supervisor.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing 
set tosecurityusersid = '94904d66-78cd-4c6b-9794-f18531eb4bc1',
	updatedby = 'CJAMS-59458',
	updatedon = now()
where objectid in ('1723514','1723512','1723515','1723513')
and activeflag =1;