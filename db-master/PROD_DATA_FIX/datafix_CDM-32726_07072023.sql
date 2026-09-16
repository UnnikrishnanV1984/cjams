-- CDM-32726 - Documents
/*
-- Issue Description: 
   Document table Data Cleanup
   
-- To delete Duplicate Saved (Draft) documents (activeflag = 2) 

-- Category/ Module: Documents (Case Document Management) 
-- Root cause: The code is having a flaw due to which multiple documents are getting uplodaed as saved docs. 
			   Manasa/Chandra are working on the Code fix.
-- Fix Provided: Generic datafix has been promoted to the delete Duplicate Saved (Draft) documents, we will re-run this until the code is moved to prod.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select al_sqlcode, as_mess from cjams.sp_cw_documents_data_fix('CDM-32726'::character varying) ;
