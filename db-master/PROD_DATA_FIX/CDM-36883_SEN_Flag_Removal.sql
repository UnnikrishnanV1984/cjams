/*
   Issue Description: CDM-36883
   Category/ Module  :Person 
   CJAMSPID: 202795475 (8251e596-260b-47b3-b9a5-3c548dd55610)
   Pull request# for code fix: 
   Reason why no related code fix:user requested to remove SEN flag from person 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update person 
	set substanceexposednewbornflag = null, 
		substanceclasses = null, 
		substanceexposednewbornsourceid = null,
		substanceexposednewbornsourcetypekey = null, 
		substanceexposednewborntimetamp = null, 
		othersubstances = null,
		senstatusflag = null,
		updatedby = 'CDM-36883',
		updatedon = now() 
	where personid = '8251e596-260b-47b3-b9a5-3c548dd55610';