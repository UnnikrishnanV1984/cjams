-- CDM-33096 - CLONE - Documents Health Table
/*
-- Issue Description: 
   Document table Data Cleanup
   Person profile documents metadata moved from transaction table to document properties table. 
   
-- Category/ Module: Documents (Case Document Management) 
-- Root cause: Change in the design of CJAMS Person Health Tab Documents upload functionality. 
-- Fix Provided: Datafix has been promoted to update documentproperties table with Person - Health tab transaction ID
--  	         Columns: additionalobjecttype and additionalobjectid
--				 Multiple documents were missed in the fix provided with CIDM-7375
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

@Devops:

This fix is having new Stored Procedure and a datafix script 

So, the order of deployment is 
1) Deploy SP first sp_cw_documents_data_fix.sql
2) then run datafix_CDM-33096_07212023.sql

*/


select al_sqlcode, as_mess from cjams.sp_cw_documents_data_fix('CDM-33096'::character varying) ;
