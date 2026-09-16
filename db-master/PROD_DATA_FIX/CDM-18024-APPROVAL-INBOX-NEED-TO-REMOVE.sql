/*
   Issue Description: CDM-18024
         Category/ Module  : removing approved items from inbox
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	set activeflag = 0,
		updatedby = 'CDM-18024',
		updatedon = now()
	where routingid in (
		'1ef1434f-20fa-40cf-9b77-7862cce2ee9d',
		'40cf98b7-c153-4231-96c6-2e08287b4e54',
		'26d1daa0-4139-4098-9023-35143281a014'
	);