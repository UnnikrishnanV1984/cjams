/*
Issue Description:CJAMS-60681 Gap Agreement
Category/Module: Gap Agreement
Root cause: 3194516 GAP agreement cannot be approved as there is an exisiting payment the Agreement approval request didnot go through
            due to roles issue which is already fixed in the last minor release.The request was sent on 2025-07-02 11:08:31 from lisa.delee@montgomerycountymd.gov
            to crystal.stewart@montgomerycountymd.gov for the client Case 3194516 - Nevaeh Butler 4/4/2007.
Fix provided: Data fix has been done enable approval flow for the GAP agreement by bringing it to the previous state. lisa.delee@montgomerycountymd.gov needs to send a request to crystal.stewart@montgomerycountymd.gov
              again for the GAP extension post which the flow should work as expected.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: This is a know Beacon roles issue and was fixed in the last minor release.
*/


update routing
set activeflag =1,
	updatedon = now(),
	updatedby = 'CJAMS-60681'
where routingid = 'c13586b3-8119-455e-81a8-4a9ec60b13bc'	
and objectid = 'fcd4e03e-d88c-45dc-b037-6320866f7144';
