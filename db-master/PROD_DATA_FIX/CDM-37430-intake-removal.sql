/*
   Issue Description: CDM-37430
   Category/ Module  : Dashboard
   Root cause: Updating the substanceexposednewbornsourceid with the corresponding intakeid.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix: Needs only data fix
*/

select cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	substanceexposednewborntimetamp, substanceclasses, othersubstances, updatedby, updatedon 
from person
where cjamspid =  202794310
	and activeflag = 1;
	

update person
set substanceexposednewbornsourcetypekey = '2954',
	substanceexposednewbornsourceid = 'I241012055665',
	updatedby = 'CDM-37430', 
	updatedon = now()
where cjamspid = 202794310
	and activeflag = 1;