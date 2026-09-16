/*
   Issue Description: CDM-25098
   Category/ Module  : Permanancy plan
   Root cause: PermanancyPlanId (objectid) in routing table was  8870f6a1-8da9-4d40-af81-8f1d19cf3acf instead of 5c98fde7-712a-4a2a-b6c4-19e700d55935
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select 	* from routing r 
where 	routingid = '31f55e7f-c93c-4cc9-bfd0-1240edcc7d0f'
		and objectid = '8870f6a1-8da9-4d40-af81-8f1d19cf3acf'
		and activeflag = 1;
	
update 	routing 
set 	objectid = '5c98fde7-712a-4a2a-b6c4-19e700d55935',
		updatedby = 'CDM-25098',
		updatedon  = now()
where 	routingid = '31f55e7f-c93c-4cc9-bfd0-1240edcc7d0f'
		and objectid = '8870f6a1-8da9-4d40-af81-8f1d19cf3acf'
		and activeflag = 1;