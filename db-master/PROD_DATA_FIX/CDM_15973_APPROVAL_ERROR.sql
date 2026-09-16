/*
   Issue Description: CDM-15973
   Category/ Module  :  Approval Error
   Root cause: user wants to close
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   backup data: 
		
		update routing r 
		set activeflag = 0, updatedby = 'CDM-15954', updatedon = now()
		where routingid = '25f9d38d-a294-40e5-abbc-b9be7020e7b9';
	*/



    update routing r 
	set activeflag = 0, updatedby = 'CDM-15954', updatedon = now()
	where routingid = '25f9d38d-a294-40e5-abbc-b9be7020e7b9';