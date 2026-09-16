/*
  Issue Description:  CDM-41910
   Category/ Module  : Persons
   Root cause: User request to Data fix to active flag zero for the extra record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-41910', updatedon = now() where intakeserviceid = '3590b19f-6d76-4865-bf74-6ae7c2c23400' 
and personid = '6d1bb7c7-81ec-4aae-a30e-0bde4e799ede'
and actorid = '3b8e7cb7-78ea-46f3-80ec-89842b72351f' and activeflag = 1;


update personrole set activeflag = 0,updatedby = 'CDM-41910', updatedon = now()  
where personid = '6d1bb7c7-81ec-4aae-a30e-0bde4e799ede' and 
intakeserviceid = '3590b19f-6d76-4865-bf74-6ae7c2c23400' and personroleid = '1988ed53-e048-4c5b-a6f1-6cab6bca61c1'
and activeflag = 1;

update actor set activeflag = 0, updatedby = 'CDM-41910', updatedon = now() where  actorid = '3b8e7cb7-78ea-46f3-80ec-89842b72351f' and activeflag = 1;

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-41910', updatedon = now() where personid = '5226e5cc-874d-4d3a-a316-dbe02b25dad9' 
and intakeserviceid = '3590b19f-6d76-4865-bf74-6ae7c2c23400' and actorid = 'de355bdc-448f-4e41-989c-b7b7b567cc44' and activeflag = 1;


update personrole set activeflag = 0,updatedby = 'CDM-41910', updatedon = now()  
where personid = '5226e5cc-874d-4d3a-a316-dbe02b25dad9'  
and intakeserviceid = '3590b19f-6d76-4865-bf74-6ae7c2c23400' and personroleid = '84ee3415-f150-4090-9b20-b3e8967d6634'
and activeflag = 1;


update actor set activeflag = 0, updatedby = 'CDM-41910', updatedon = now() where  personid = '5226e5cc-874d-4d3a-a316-dbe02b25dad9'  
and intakeserviceid = '3590b19f-6d76-4865-bf74-6ae7c2c23400' and actorid = 'de355bdc-448f-4e41-989c-b7b7b567cc44'
and activeflag = 1;