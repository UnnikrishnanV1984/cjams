/*
   Issue Description: CDM-16668
   Category/ Module  :  Removing approved items
   Root cause: user requeseted to update placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing 
	set activeflag = 0,
		updatedby = 'CDM-16668',
		updatedon = now()
	where routingid in ('8c9caa92-6bd9-470f-a10b-f4d6f3a13358',
						'76a19fc6-0dc5-4c0d-9e0a-344bc98321e1',
						'72e558bd-12e8-4222-9f9d-66cd93d5c501');