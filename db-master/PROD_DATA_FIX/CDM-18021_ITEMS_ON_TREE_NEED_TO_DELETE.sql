/*
   Issue Description: CDM-18021
      Category/ Module  : removing approved items from inbox
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing 
	set activeflag = 0,
		updatedby = 'CDM-18021',
		updatedon = now()
	where routingid in (
		'70654653-2b8d-4b10-91de-756124630541',
		'0f59e374-c509-4834-9864-c511a614dc58',
		'07b5a68d-2abc-4aa2-a194-9df2ea738437'
	);