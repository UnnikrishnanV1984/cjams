-- CDM-38521 - unselected case assigned
/*
-- Issue Description: 

	2020031104046 - Was assigned to  Jasmine Huddleston, reassigned to Cher Harvey in error
	3164013 - Was assigned to Cassandra Sutton, reassigned to Jasmine Huddleston in error
	211030009128  - Was assigned to Cassandra Sutton, reassigned to Collins in error after approval
	
-- Case ID: 211030009128, 3164013, 2020031104046

   
-- Category/ Module: unselected case assigned
-- Root cause: unselected case assigned
-- Resolution: reassigned back 
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2020031104046 - Was assigned to  Jasmine Huddleston, reassigned to Cher Harvey in error
-- update routing set activeflag = 1, updatedby = 'CDM-38521', updatedon = now()  where routingid='ea13de63-8e58-4aa4-8793-92123cc2dabc';
-- update routing set activeflag = 0, updatedby = 'CDM-38521', updatedon = now()  where routingid='7940b9a7-8f64-4231-80c6-7777f0f38d53'; 
-- update routing set activeflag = 0, updatedby = 'CDM-38521', updatedon = now()  where routingid='d9f73a6f-8982-4c67-ae0b-5c19ead96cb7'; 
-- 	3164013 - Was assigned to Cassandra Sutton, reassigned to Jasmine Huddleston in error
update routing set activeflag = 1, updatedby = 'CDM-38521', updatedon = now()  where routingid='7e5b1c58-05d1-4c19-ac1e-cb43a63445b7';
update routing set activeflag = 0, updatedby = 'CDM-38521', updatedon = now()  where routingid='79246e86-431f-4aef-b996-ead345fb4d3e'; 
--updating status  202 pending from cassandra
-- 204
update routing set routingstatustypeid = 202, updatedby = 'CDM-38521', updatedon = now()  where routingid = '7e5b1c58-05d1-4c19-ac1e-cb43a63445b7';


-- 211030009128  - Was assigned to Cassandra Sutton, reassigned to Collins in error after approval
update routing set activeflag = 1, updatedby = 'CDM-38521', updatedon = now()  where routingid='8df7f737-aab8-465d-8a90-68b7a6972d04';
update routing set activeflag = 0, updatedby = 'CDM-38521', updatedon = now()  where routingid='69c9fd5a-c29b-4354-b2b2-e84f00dda7c7';
-- 202 , 204 removing cassandra and angie collins approval
update routing set activeflag = 0, updatedby = 'CDM-38521', updatedon = now()  where routingid in ('8df7f737-aab8-465d-8a90-68b7a6972d04', '721e1467-0a97-43a8-8d7e-0b112a1f2407');
-- activating 204 approval from cassandra 
update routing set activeflag = 1, updatedby = 'CDM-38521', updatedon = now()  where routingid = 'f8ec02ea-866b-444b-b250-a47758d4c5e8';




