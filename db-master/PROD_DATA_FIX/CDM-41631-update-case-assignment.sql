/*
  Issue Description: CDM-41631 - Intake approved but not connected to create a service case.
  Root cause: Service case is not being populated for the intake (I241013139764) .
  Fix provided : created service case for the intake (I241013139764) and added caseassignment record.
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

--intakeserviceid --> 76e52e95-fc7a-4e54-a8f1-1b88a937b37a
--servicerequestnumber --> 241021915623
--supervisor id --> ef3032b3-2f5a-4b48-8b27-c33cf654abf6
-- New Servicecaseno created --> 241030402122

update caseassignment
set responsibilitytypekey = 'family',
startdate = '2024-09-17 11:17:00',
toworkeridno = 'fc18350a-e495-49c7-929a-049679f0a228',
toteamid = '3783b16b-2c12-4664-a4d8-429a7b933f82',
updatedby = 'CDM-41631',
updatedon = now()
where objectid='ec237a1e-d46a-4e3e-bd01-d95b0ff122e5';



update routing 
set toroleid='CWCW',
tosecurityusersid='fc18350a-e495-49c7-929a-049679f0a228',
updatedby = 'CDM-41631',
updatedon = now()
where objectid='ec237a1e-d46a-4e3e-bd01-d95b0ff122e5';


update servicecase 
set startdate='2024-09-17 11:17:00.000', 
insertedon='2024-09-17 11:17:00.000',
updatedon=now(),
updatedby='CDM-41631'
where servicecaseid ='ec237a1e-d46a-4e3e-bd01-d95b0ff122e5';

