-- CIDM-7375 Data fixes to update link between the document table and Person
/*
-- Issue Description: 
   Document table Data Cleanup
   
-- 1.Person profile documents metadata moved from transaction table to document properties table. 

	1.	personimmunization
	2.	personbehavioralhealth
	3.	birthhealthinfo
	4.	clientunder5yearsinfo
	5.	personfmlymdclhstry
	6.	personhospitalization
	7.	personhealthinsurance
	8.	personsexualinfo
	9.	personexamination
	10.	personabusesubstance
	11.	personmedicpshychotropic
	12.	personphycisianinfo
	13.	personmedicalcondition
	14.	personhlthmobilityspeech
	15. personhlthfeeding

-- 2. Unsaved documents count mismatch (activeflag = 2)

-- Category/ Module: Documents (Case Document Management) 
-- Root cause: Change in the design of CJAMS Person Health Tab Documents upload functionality. 
-- Fix Provided: Datafix has been promoted to update documentproperties table with Person - Health tab transaction ID
--  	         Columns: additionalobjecttype and additionalobjectid
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select al_sqlcode, as_mess from cjams.sp_cw_documents_data_fix('CIDM-7375'::character varying) ;
