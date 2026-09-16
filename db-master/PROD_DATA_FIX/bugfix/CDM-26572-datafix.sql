-- CDM-26572 - CARMEN MURRAY-PERMANENCY PLAN ISSUES.
/*
-- Issue Description: 
	1. Permanancy Plan - Plan established date is null
	
-- Category/ Module: Pending Approval Inbox
-- Root cause: This is a migrated data record which has null for planestablisheddate 

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	establisheddate, activeflag, * 
from 	permanencyplan 
where 	servicecaseid = '3035a123-38c7-4d78-8b89-85a7ec6c5f06' and permanencyplanid ='cc6335c6-d39a-46ce-acda-462a9776713f';

update 	permanencyplan
set 	establisheddate = '2012-10-22 00:00:00',
		updatedby = 'CDM-26572',
		updatedon = now()
where 	servicecaseid = '3035a123-38c7-4d78-8b89-85a7ec6c5f06' and permanencyplanid ='cc6335c6-d39a-46ce-acda-462a9776713f';