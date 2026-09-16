/*
   Issue Description: CDM-37427
   Category/ Module  : Prod data fix to add child records
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.assessment
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{childdatagrid}', 
	'[{"age": "12 Yrs", "childname": " Kevin J Ruggerio Junior ", "clientid": "202585532"},
	  {"age": "2 Month(s)", "childname": "Nicholas Ruggerio", "clientid": "202585602"}
      ]'),
  updatedby = 'CDM-37427', updatedon = now()
where assessmentid ='0374bd3e-a077-4d13-8214-380644803386';