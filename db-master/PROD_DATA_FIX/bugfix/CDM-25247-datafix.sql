/*
   Issue Description: CDM-25247
   Category/ Module  : IVE - Approvals dashboard
   Root cause: duplicate entry for cjamspid/removalid 3729038/168409
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select 	activeflag , * 
from 	routing 
where 	routingid = '8aef668c-ef3f-4218-8500-3a42a797100f' and activeflag =1;

update 	routing 
set 	activeflag = 0,
		updatedby = 'CDM-25247',
		updatedon = now()
where 	routingid = '8aef668c-ef3f-4218-8500-3a42a797100f' and activeflag =1;