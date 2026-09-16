/*
  Issue Description: CDM-41219 
   Category/ Module  : N/A 
   Root cause: User request to Data fix to remove the cases from the Assign Transfer dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update cjams.intaketransfers 
	set activeflag = 0,
	updatedby = 'CDM-41219', 
		updatedon = now()
	where intaketransferid ='52e95dda-c92a-40a5-893a-270d27ec17e0';
	
update cjams.intaketransfers 
	set activeflag = 0,
	updatedby = 'CDM-41219', 
		updatedon = now()
	where intaketransferid ='0cf83243-16c8-4432-87cd-d979a57cc01d';
	

update cjams.intaketransfers 
	set activeflag = 0,
	updatedby = 'CDM-41219', 
		updatedon = now()
	where intaketransferid ='6663f311-d51c-40b0-837d-a202fc335e10';

update cjams.intaketransfers 
	set activeflag = 0,
	updatedby = 'CDM-41219', 
		updatedon = now()
	where intaketransferid ='95e7ed75-01e6-4e9c-9683-491decdcb8ab';

update cjams.intaketransfers 
	set activeflag = 0,
	updatedby = 'CDM-41219', 
		updatedon = now()
	where intaketransferid ='68310bc7-ebde-43bc-90d4-df34db60f6af';