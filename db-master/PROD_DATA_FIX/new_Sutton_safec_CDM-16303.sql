/*
   Issue Description: CDM-16303
   Category/ Module  : case approvals
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/


update assessment
	set submissiondata = replace(submissiondata::text, '"dateassessmentinitiated": "2021-08-24T16:55:55.000Z"', '"dateassessmentinitiated": "2021-08-23T16:55:55.000Z"')::json, 
		updatedby = 'CDM-16303', 
		updatedon = now()
	where assessmentid = '3bb397f2-b63f-4675-bb1a-4cba284823cf';