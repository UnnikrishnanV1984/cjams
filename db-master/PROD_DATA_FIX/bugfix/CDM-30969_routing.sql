/*
   Issue Description: CDM-30969
   Category/ Module  : routing
   Root cause: In the Case 3229197:None of the 3 children in this case have a review date/hyperlink for the review period
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/
update
	routing
set
	activeflag = 0,
	updatedby = 'CDM-30969',
	updatedon = now()
where
	routingid in ('3a20cd7a-2ad7-4814-86d3-3d5dc5f5fdb6', '062bd5f2-4cf0-4df9-b7c2-3455dd7027d2', '20be41ca-f2f2-4bb7-934f-7d14ec1a1cb1', 'cd0fe329-54ac-476b-9859-70199d9c9f95')
	and activeflag = 1;