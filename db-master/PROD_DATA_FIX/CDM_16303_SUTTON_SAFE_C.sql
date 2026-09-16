/*
   Issue Description: CDM-16303
   Category/ Module  :  Assesments
   Root cause: userwants to update the time from aug 24 to aug 23
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update assessment
	set submissiondata = replace(submissiondata, '"dateassessmentinitiated": "2021-08-24T16:55:55.000Z"', '"dateassessmentinitiated": "2021-08-23T16:55:55.000Z"'), 
		updatedby = 'CDM-16303', 
		updatedon = now()
	where assessmentid = '3bb397f2-b63f-4675-bb1a-4cba284823cf';