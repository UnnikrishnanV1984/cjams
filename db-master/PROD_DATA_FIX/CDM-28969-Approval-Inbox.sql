/*
   Issue Description: CDM-28969
   Category/ Module  :  Approval Inbox
   Root cause: user wants to delete the approved record from pending inbox
   Pull request# for data fix: 8078
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update routing 
	set  updatedby = 'CDM-28969',updatedon = now(), activeflag = 0
	where  routingid = 'e6f53a44-5e7a-42c7-8d14-92e59c8a0d1b';