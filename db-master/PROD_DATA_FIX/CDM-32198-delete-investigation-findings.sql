/*
   Issue Description: CDM-32198
   Category/ Module  : Investigation finding
   Root cause: User requested to remove the wrong investigation findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need to do data fix
*/


update Investigationmaltreatment 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-32198' 
where maltreatmentid in ('887a3970-e2c1-47e6-9dc5-498a18e2dac4', 'fa99c75a-c86b-4266-b99b-9b4532075ae6','67684d8d-d081-41fb-958d-f85cc9cc7dfc','4c61026c-090f-492d-a60d-a64d819f4467');