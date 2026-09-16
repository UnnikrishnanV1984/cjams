/*
   Issue Description: CDM-37602
   Category/ Module  : Dashboard
   Root cause: User created intake accidentally.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	substanceexposednewborntimetamp, substanceclasses, othersubstances, updatedby, updatedon 
from person
where cjamspid =  202796190
	and activeflag = 1;

update person
set substanceexposednewbornsourcetypekey = '2954',
	substanceexposednewbornsourceid = 'I241012056781',
	updatedby = 'CDM-37602', 
	updatedon = now()
where cjamspid = 202796190
	and activeflag = 1;