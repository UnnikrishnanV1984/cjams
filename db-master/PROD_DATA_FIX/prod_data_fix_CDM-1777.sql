update intakeservicerequestcourthearing 
set hearingstatustypekey = 'CONCULD', updatedon = now(), updatedby = 'Datafix user as per CDM-1777'
where servicecaseid = '51d0c07a-b610-497d-82d1-8e8ffa9c7b3e' and hearingstatustypekey = 'UNCNTST'