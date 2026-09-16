/*
-- Issue Description: 
 Flex Fund 2335065 - BCDSS - Amazon purchase only rolled to Debra Dandridge. She has retired from the Agency. You will have to put a ticket into CJAMS to have it rolled over to another Finance Staff ( Linnel Benton) to be denied or approved,   
	Case ID: 3270333 
	Client ID: 3992266 (JAYDEN NICKENS)
    Provider ID: 5036607 (Baltimore City Department of Social Services)
    Auth ID: 2335065  
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing
set tosecurityusersid ='b0fbf926-91a3-4a91-a6a4-62e458683797',--df4e91fc-5824-45b0-baae-788cacf3bc79
	updatedby = 'CJAMS-63133',
	updatedon = now()
where routingid = 'c8af9a34-545c-433e-8a46-adf80057662f'
	and objectid = '2335065'
	and activeflag = 1
	and tosecurityusersid = 'df4e91fc-5824-45b0-baae-788cacf3bc79';