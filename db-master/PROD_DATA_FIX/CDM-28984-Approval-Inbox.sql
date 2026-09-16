/*
   Issue Description: CDM-28984
   Category/ Module  : Approval Inbox
   Root cause: user wants to delete the record form pending approval tab
   Pull request# for data fix: 8138
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update routing 
	set  updatedby = 'CDM-28984',updatedon = now(), activeflag = 0
	where  routingid = '8e1b4ca1-0f46-4fc7-8748-ef4e1fad84c7';