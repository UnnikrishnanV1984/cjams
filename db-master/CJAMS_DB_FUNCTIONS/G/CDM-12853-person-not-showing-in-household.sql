update intakeservicerequestactor set 
actorid = '0d24d076-c8f6-4005-b3c8-e24d313278c1',
updatedby = 'CDM-12853',
updatedon = now()
where intakeservicerequestactorid = '691f93ee-7009-4c80-9608-75696c4b6890';


update actor set 
activeflag = 0,
updatedby = 'CDM-12853',
updatedon = now()
where actorid = 'd16fc4ec-cf3b-415c-8cd8-78e32678cef6';