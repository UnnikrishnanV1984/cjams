/*
   Issue Description: CDM-28262
   Category/ Module  : Remove approvals from inbox
   Root cause: user wants to delete approved records
   Pull request# for data fix: 7839
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing 
	set  updatedby = 'CIDM-28262',updatedon = now(), activeflag = 0
	where  routingid  in ('5c58b2ef-7fe3-4402-ad46-4378852052bf','a67dcaa0-4338-4c4f-9016-8472d7c42850');