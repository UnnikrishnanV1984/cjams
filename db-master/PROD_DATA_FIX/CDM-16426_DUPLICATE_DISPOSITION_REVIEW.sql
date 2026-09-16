/*
   Issue Description: CDM-16426
   Category/ Module  :  Disposition review
   Root cause: user wants to remove from pending approval list
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

   */



   update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-16426',
		updatedon = now()
	where routingid in ('dafb8fb1-ffa9-431a-ba51-9d246498d66b','4f259465-6654-4195-92dd-e7234f9eb697','70d3f2fe-9c6d-4a99-9e47-dbc97eb62749','5a06b90b-d734-4de4-a131-334c1f0e383f');