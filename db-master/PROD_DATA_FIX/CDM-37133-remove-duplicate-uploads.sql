
-- CDM-37133 -  remove all  pending upload document
/*
-- Issue Description: 
   Document table Data Cleanup of Duplicate Unsaved documents Clean up (activeflag = 2)
      
-- Category/ Module: Documents (Case Document Management) 
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted for duplicate unsaved documents Clean up 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A


*/


select al_sqlcode, as_mess from cjams.sp_cw_documents_data_fix('CDM-37133'::character varying);