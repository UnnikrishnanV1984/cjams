/*
   Issue Description: CDM-32458 - stuck approval
   Category/ Module  : Approval Inbox - case pending approval
   Dashboard:Dashboard:The James Penely approval was approved but is stuck in my in box. 
   Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/cjams-dashboard/cw-approval
   Root cause: user wants to delete the record form pending approval tab
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/

-- Customer Email ID:kathleen.chaney@maryland.gov
-- inspect the page u will get object id from that you will get routing id
-- "objectid": "58a57787-5c62-4f35-b4cf-578f69eeb15e"    
-- servicerequestnumber = 2020035704938
   
    
    select distinct routingid,* from routing where objectid = '58a57787-5c62-4f35-b4cf-578f69eeb15e' and activeflag=1;
    update routing 
	set  updatedby = 'CDM-32458',updatedon = now(), activeflag = 0
	where  routingid in (
		'cdca9bcd-6e56-4c20-b72a-23d0672fd86a');