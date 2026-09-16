/*
   Issue Description: CDM-25914
   Category/ Module  : case assignment
   Root cause: user wants to re-assign case 

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--211020154324 : Appeal worker have open assignment but not listed in her dashboard
update 	routing 
set 	eventcode = 'APPL', 
		routingstatustypeid = 15,
		updatedby = 'CDM-25914',
		updatedon = now()
where 	tosecurityusersid = '22417e18-7b17-4bce-aa0a-e6c68eae7426' 
		and objectid = '146f2d23-e963-49ba-8a57-28aa53d5f2ba'
		and activeflag = 1;