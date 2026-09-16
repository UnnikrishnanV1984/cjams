-- CJAMS-59639  Unable to locate Case
/*
--	Issue Description: 
	 251022982731 is not available in the case search but it is available under the person program assignment
-- Category/ Module: Persons: Others
-- Root cause: 251022982731 is not available in the case search but it is available under the person program assignment
-- Fix Provided: Datafix has been promoted to delete the personprogram area.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea 
   set entityid = '3066098',
       updatedby = 'CJAMS-59639',
       objecttypekey = 'servicecase',
       objectid = 'ed4a4bc7-6b19-4b67-9129-d3899d3a340c',
	   updatedon = now()
where personprogramid = '692f19e4-adf2-4554-bf7f-b3ee96cd2c65'
   and personid = '13ffdefe-0c49-4bda-8d1c-12a08f92c619'
   and activeflag = 1;
