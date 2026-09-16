/*
Issue Description:241022913865:Please modify the three indicated physical abuse findings to indicated neglect findings. OAH ordered the department to make the modification in our database. Documentation supporting this request has been uploaded to the document tab. Screen 
Category/Module: User Error
Root cause: User request modify the finding from unsubstantiated sexual abuse to unsubstantiated child neglect.
Fix provided: DB query to insert missing intakeservicerequestsdm into the note
Data/Code fix ticket#: CJAMS-59715
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
select * from servicerequesttypeconfigdispositioncode where intakeserreqstatustypeid =  '7995cecb-062d-406c-8ea9-b1da4b1877d8';
delete from intakeservicerequestsdm where  updatedby  = 'CJAMS-59715';
delete  from investigationfinding i   where updatedby  = 'CJAMS-59715';
delete from intakeservicerequestactor i where updatedby = 'CJAMS-59715';
delete from investigationallegation where   updatedby = 'CJAMS-59715';
*/



update intakeservicerequestsdm
set ismalpa_childtoxic = null, isnegrh_treatmenthealthrisk = true,updatedby  = 'CJAMS-59715',updatedon  = now()
where intakeservicerequestsdmid = 'ce7b27de-779b-4fbd-8f02-b795663a3a86' and activeflag =1;

update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',updatedby  = 'CJAMS-59715',updatedon  = now()
where activeflag = 1 and investigationallegationid in (
'da007917-4ff2-48db-8811-11aeafe5eef6',
'ccc1a4fa-ff8f-4797-a329-f617e166a84d',
'4a43494f-971e-4213-8e26-6f1f43d03880') ;