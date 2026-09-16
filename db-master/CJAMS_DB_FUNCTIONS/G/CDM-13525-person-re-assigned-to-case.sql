update intakeservicerequestactor set 
servicecaseid = 'a165c7e5-1d14-4b74-a734-b3582a8a578e',
updatedby = 'CDM-13525',
updatedon = now()
where intakeservicerequestactorid in ('8bf70e46-a673-4c3f-a8a2-f42990b7fa67','e2ef10e3-184c-40c9-ae1a-2a5966b61834');

update actor set 
servicecaseid = 'a165c7e5-1d14-4b74-a734-b3582a8a578e',
updatedby = 'CDM-13525',
updatedon = now()
where actorid in ('888e0563-05ce-4b47-92c9-51871635c851');