/*
   Issue Description: CDM-30684
   Category/ Module  :Person
   Pull request# for code fix: 
   Reason why no related code fix:user requested to remove SEN flag from person 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update person set substanceexposednewbornflag = null, substanceclasses = null, substanceexposednewbornsourceid = null,substanceexposednewbornsourcetypekey = null, substanceexposednewborntimetamp = null, othersubstances = null  ,updatedby = 'CDM-30684',updatedon = now() where personid = '3f6c6ab5-5c92-449e-9aca-36de7bccbd0d';