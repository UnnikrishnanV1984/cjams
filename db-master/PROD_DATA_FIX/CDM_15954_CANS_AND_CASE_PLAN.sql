/*
   Issue Description: CDM-15954
   Category/ Module  :  cans and case plan closure
   Root cause: user wants to close
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   backup data: 
		/*
		update routing r 
		set activeflag = 1, updatedby = 'CDM-15954', updatedon = now()
		where routingid = 'f9ae4226-f908-40da-a393-3ba0abdb9ba7';
	*/



update routing r 
	set activeflag = 0, updatedby = 'CDM-15954', updatedon = now()
	where routingid = 'f9ae4226-f908-40da-a393-3ba0abdb9ba7';