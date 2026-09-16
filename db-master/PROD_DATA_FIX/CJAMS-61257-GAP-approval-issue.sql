/*
Issue Description:CJAMS-61257 Gap Agreement
Category/Module: Gap Agreement
Root cause: 3164722 GAP agreement cannot be approved as there is an exisiting payment the Agreement approval request didnot go through
            due to roles issue which is already fixed in the last minor release.The request was sent on 2025-07-15 09:03:00.864 and 2025-07-16 16:21:14.417 from lisa.delee@montgomerycountymd.gov on  
            to crystal.stewart@montgomerycountymd.gov for the client Case 3164722 - Ezekiel Gilbert Date of Birth 6/3/2007.
Fix provided: Data fix has been done enable approval flow for the GAP agreement by bringing it to the previous state. Please try completing the annual review after the data fix
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: This is a know Beacon roles issue and was fixed in the last minor release.
*/


update routing
set activeflag =1,
	updatedon = now(),
	updatedby = 'CJAMS-61257'
where routingid = 'e41857fa-1c02-4706-bf9c-7da2cd130fa6'	
and objectid = 'f2572507-8759-4900-a60c-77f3750a35ad'
and activeflag = 0;