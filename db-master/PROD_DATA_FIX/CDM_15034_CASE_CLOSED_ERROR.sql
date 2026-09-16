/*
   Issue Description: CDM-15034
   Category/ Module  :  Case closure
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   backup data: No OOH Program area for the case			
		Service Case ID : 'b6049d66-c043-4776-8742-ffae01d2c810';
		Previsous statustypekey : 'Closed'
		Service Disposition ID: '974bf14a-0bcb-4cc8-b173-d3a003535f4a';
*/


UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-15034',updatedon = now() 
	WHERE servicecaseid = 'b6049d66-c043-4776-8742-ffae01d2c810';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-15034',updatedon = now() 
	where servicecasedispositionid = '974bf14a-0bcb-4cc8-b173-d3a003535f4a';