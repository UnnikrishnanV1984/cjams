/*
  Issue Description:  CDM-41149
   Category/ Module  : Approval
   Root cause: Data fix for the case 241022830879
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE cjams.intakeservicerequestdispositioncode
SET activeflag = 0, updatedby='CDM-41149', updatedon=now()
WHERE intakeservicerequestdispositioncodeid = '0c09e876-13a1-4e46-8d32-334807599fdd';  

UPDATE cjams.caseassignment
SET activeflag = 0, updatedby='CDM-41149', updatedon=now()
WHERE caseassignmentid='9c686d3b-dc26-4694-ae2b-6a417d1addb8';

UPDATE cjams.intakeservicerequest
set activeflag = 0, updatedby='CDM-41149', updatedon=now()
WHERE intakeserviceid='18ed731d-226b-44e4-92d1-5015e064933f';

UPDATE cjams.routing
SET activeflag = 0
WHERE objectid = '18ed731d-226b-44e4-92d1-5015e064933f' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-41149', updatedon = now()
where objectid='18ed731d-226b-44e4-92d1-5015e064933f' and activeflag =1;

update caseassignment set activeflag = 0, updatedby = 'CDM-41149', updatedon = now()
where objectid='18ed731d-226b-44e4-92d1-5015e064933f' and activeflag =1;

update actor set activeflag = 0, updatedby = 'CDM-41149', updatedon = now()
where intakeserviceid='18ed731d-226b-44e4-92d1-5015e064933f' and activeflag =1;

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-41149', updatedon = now()
where intakeserviceid='18ed731d-226b-44e4-92d1-5015e064933f' and activeflag =1;

update actorrelationship set activeflag = 0, updatedby = 'CDM-41149', updatedon = now()
where intakeserviceid='18ed731d-226b-44e4-92d1-5015e064933f' and activeflag =1;

update personrole set activeflag = 0, updatedby = 'CDM-41149', updatedon = now()
where intakeserviceid='18ed731d-226b-44e4-92d1-5015e064933f' and activeflag =1;

update personroletype set activeflag = 0, updatedby = 'CDM-41149', updatedon = now() where personroleid in ('b5af2718-23f3-484b-88fb-b4f665f7e4eb','f7815e43-7132-444d-94e2-389fe4bfbef4','44badcd3-0794-4422-874f-98d28311f87c',
'b4b7d3e2-7316-41b6-8103-59dfc53aa3fc','2b422be4-540e-40f1-8300-a145cbef6936','e226371d-730e-4ccc-9d85-e9c7ad74c078');