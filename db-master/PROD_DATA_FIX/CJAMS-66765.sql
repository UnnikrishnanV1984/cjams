
/*
Issue: Service Log Pending
Category/Module: Purchase Authorization
Root cause: Reroute the approval to melinda.baldwin@maryland.gov. 
Fix provided: Data fix provided to update the routing table with correct approver.
Data/Code fix ticket#: CJAMS-66765
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: data fixed in the database as per user request.
Status of the code fix: Data fix completed, PR raised for documentation.
*/ 
update routing set tosecurityusersid='6f9d10f6-2055-4ffb-8667-1b8b84b11ec2',updatedby='CJAMS-66765',updatedon=now()
WHERE routingid='c174116d-fa5f-4384-8c2a-4d90fbd81344' and teamid  ='263e4d5d-cf6c-4e7d-8c35-394a62e46028' and activeflag =1;