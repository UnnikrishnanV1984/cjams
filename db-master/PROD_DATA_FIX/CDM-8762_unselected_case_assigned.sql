-- CIDM-8762 - unselected case assigned
/*
-- Issue Description: 

	2020031104046 - Was assigned to  Jasmine Huddleston, reassigned to Cher Harvey in error
	
-- Case ID: 211030009128, 3164013, 2020031104046

   
-- Category/ Module: unselected case assigned
-- Root cause: unselected case assigned
-- Resolution: reassigned back 
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2020031104046 - Was assigned to  Jasmine Huddleston, reassigned to Cher Harvey in error
update routing set activeflag =0, updatedby = 'CIDM-8762', updatedon = now() where routingid ='d9f73a6f-8982-4c67-ae0b-5c19ead96cb7';
update routing set activeflag =1, updatedby = 'CIDM-8762', updatedon = now() where routingid ='ea13de63-8e58-4aa4-8793-92123cc2dabc';


update ivecaseclosurereview set ivereviewstatus  ='CCR_Assigned', updatedby = 'CIDM-8762', updatedon = now() 
 where ivecaseclosurereviewid='e03b4769-0cf9-446e-9f88-a9c675d1274d';

