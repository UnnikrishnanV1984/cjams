/*
 * CDM-39735 - Incorrect Disposition
 * Customer Email ID:angelesa.blackwell1@maryland.gov
 * Description - 241021910106:Case mistakenly closed with incorrect disposition. 
 * data fix to reopen the closed CPS-IR case 241021910106.  SSA approval received.
 * 
 */

--select exitdate, servicecaseid, intakeserreqstatustypeid, * from intakeservicerequest where intakeserviceid = 'd8f254c2-23bc-46b2-822c-889ed27c8afa';
--select * from intakeservicerequestdispositioncode where intakeserviceid = 'd8f254c2-23bc-46b2-822c-889ed27c8afa' and activeflag=1 and intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8';
UPDATE intakeservicerequestdispositioncode
SET activeflag =0, 
updatedby = 'CDM-39735',
updatedon = now() 
WHERE 
intakeserviceid = 'd8f254c2-23bc-46b2-822c-889ed27c8afa' and intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8' and activeflag=1;

update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
updatedon= now(), updatedby='CDM-39735'
where intakeserviceid = 'd8f254c2-23bc-46b2-822c-889ed27c8afa';

--select enddate , * from personprogramarea p where entityid  = '241021910106' and activeflag  = 1;
UPDATE cjams.personprogramarea
SET enddate=null,
updatedby = 'CDM-39735',
updatedon = now() 
WHERE entityid  = '241021910106' and activeflag  = 1;

--select enddate , * from caseassignment where objectid  = 'd8f254c2-23bc-46b2-822c-889ed27c8afa' and activeflag=1;
UPDATE cjams.caseassignment
SET enddate=null,
updatedby = 'CDM-39735',
updatedon = now() 
WHERE objectid  = 'd8f254c2-23bc-46b2-822c-889ed27c8afa' and activeflag=1;
