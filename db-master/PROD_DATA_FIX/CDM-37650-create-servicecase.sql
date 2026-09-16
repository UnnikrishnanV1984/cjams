/*
  Issue Description: CDM-36484 - The service case (241021915623) will not allow it to be assigned in Cjams to the Family Preservation team, Monique Hill 443-423-7148, and her supervisor Cherrelle Robertson 443-423-7365.
  Root cause: Service case is not being populated for the intake (I241012075646) .
  Fix provided : created service case for the intake (I241012075646) and added caseassignment record.
*/

--intakeserviceid --> 44578bd8-c74e-4268-a425-8984343346ec
--servicerequestnumber --> 241021915623
--supervisor id --> 4d1dfcc6-5bbb-44c7-898a-a399f1229278
-- New Servicecaseno created --> 241030291320 

select * from cjams.createservicecase('44578bd8-c74e-4268-a425-8984343346ec','',1,'4d1dfcc6-5bbb-44c7-898a-a399f1229278','ASSGN','intake');

-- assigning the case to the supervisor for caseworker assignment
INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate)
	VALUES('4d1dfcc6-5bbb-44c7-898a-a399f1229278','4d1dfcc6-5bbb-44c7-898a-a399f1229278','4d1dfcc6-5bbb-44c7-898a-a399f1229278','CDM-37650',now(),now(),now(),'servicecase',(select servicecaseid from intakeservicerequest where intakeserviceid='44578bd8-c74e-4268-a425-8984343346ec'),
	'assignment','W',now()::date);