/*
   Issue Description: CDM-37829
   Category/ Module  :Person 
   CJAMSPID: 202822834 (fb14552d-7316-4196-b239-c620f0269a10)
   Root cause: User requested to remove the SEN flag.
   Fix Provided: Datafix has been promoted to remove the SEN flag
*/

select personid,cjamspid, substanceexposednewbornflag, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
	   substanceexposednewborntimetamp, substanceclasses, othersubstances, senstatusflag, updatedby, updatedon 
from   person
where  cjamspid = 202822834 and activeflag = 1;
-- UPDATE cjams.person
-- SET substanceexposednewbornflag=1, substanceexposednewbornsourcetypekey='2954', substanceexposednewbornsourceid='I241012082807', substanceexposednewborntimetamp='2024-03-12 18:51:25.303', substanceclasses='["BCOC","BOTH","BENZO"]', othersubstances='"METH" UNCLEAR IF METHAMPHETAMINES OR METHADONE', senstatusflag=0, updatedby='cwsenupdt', updatedon='2024-03-12 22:45:00.295'
-- WHERE personid='fb14552d-7316-4196-b239-c620f0269a10'::uuid;

update person 
	set substanceexposednewbornflag = null, 
		substanceclasses = null, 
		substanceexposednewbornsourceid = null,
		substanceexposednewbornsourcetypekey = null, 
		substanceexposednewborntimetamp = null, 
		othersubstances = null,
		senstatusflag = null,
		updatedby = 'CDM-37829',
		updatedon = now() 
	where personid='fb14552d-7316-4196-b239-c620f0269a10'::uuid;