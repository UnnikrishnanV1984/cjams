/*
   Issue Description: CDM-33345
   Category/ Module  :Person
   Pull request# for code fix: 
   Reason why no related code fix:user requested to remove SEN flag from person 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update person set senstatusflag = null,substanceexposednewbornflag = null, substanceclasses = null, substanceexposednewbornsourceid = null,substanceexposednewbornsourcetypekey = null, substanceexposednewborntimetamp = null, othersubstances = null  ,updatedby = 'CDM-33345',updatedon = now() where personid = '4eeaf828-8d3c-45a7-ac0f-52ca7e506230';