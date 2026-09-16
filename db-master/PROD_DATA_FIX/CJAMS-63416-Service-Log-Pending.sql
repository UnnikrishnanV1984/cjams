/*
Issue Description: :221030018224:Flex fund is pending approval from a retired fiscal supervisor Debra Dandridge. I have reached out to finance but they are not able to access this request and deny it. The Authorization ID is 2335061. We are unable to end date the service log and close the case until this request can be denied.
Category/Module: Support
Root cause: User Request, user requested to re-route the funding approval to  Beverly Brice (beverly.brice@maryland.gov) instead of Debra Danbridge
Fix provided: DB queries to update  record in routing table.
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/

update routing
set tosecurityusersid = '676ac1ec-f338-4646-a786-b3af379986f9',--df4e91fc-5824-45b0-baae-788cacf3bc79
	updatedby = 'CJAMS-63416',
	updatedon = now()
where routingid = '78307c96-55bd-46c0-80c0-446d559671c7' 
	and activeflag = 1;