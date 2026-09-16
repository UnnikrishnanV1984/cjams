-- CDM-35528 - Error on Document Tab
/*
-- Issue Description: 
   Document table Data Cleanup of Duplicate Unsaved documents Clean up (activeflag = 2)
      
-- Category/ Module: Documents (Case Document Management) 
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted for duplicate unsaved documents Clean up 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

@Devops:

This fix is having new Stored Procedure and a datafix script 

So, the order of deployment is 
1) Deploy SP first sp_cw_documents_data_fix.sql
2) then run datafix_CDM-35528_08012023.sql

*/


select al_sqlcode, as_mess from cjams.sp_cw_documents_data_fix('CDM-35528'::character varying) ;
