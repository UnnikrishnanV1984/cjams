-- CIDM-5492 - SAFE-C Data Fix needed (bulk cases)
/*
-- Issue Description: 
   Safe-C Assessments with missing child info. 
  
-- Category/ Module: Case Management
-- Root cause: Code was having flaw and fix was deployed in production.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200936578",
      "childname": "Emmanuel Tanis"
    },
    {
      "age": "3 Yrs",
      "clientid": "200936579",
      "childname": "Jennika Tanis"
    }
    ]')
--	,updatedby = 'CIDM-5492-R10'
--	,updatedon = now()
where assessmentid = '9dc87373-3099-4ca0-aea4-a6402409ea1b'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "24 Day(s)",
      "clientid": "200936580",
      "childname": "Jonathan Tanis"
    }
    ]')
--	,updatedby = 'CIDM-5492-R10'
--	,updatedon = now()
where assessmentid = '9b9dab53-9507-4fcc-b62b-f8e1fd13dc32'
	and activeflag = 1 ;
