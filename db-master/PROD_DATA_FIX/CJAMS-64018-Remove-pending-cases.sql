
/*
Issue: CJAMS-64018 Cases show waiting to be assigned, that have already been assigned.
Category/Module: Assign case 
Root cause: User requested to remove the cases from assigment dashboard
Fix provided:  Data fix has been done to remove the cases from the assignment dashboard
Data/Code fix ticket#: CJAMS-64018
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for data fix.
*/


--Service case number 3165875
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64018'
where routingid = '8f6143b0-ed64-43a8-9a5a-dd681b0d81c5'
and objectid in  ('ce0e275d-40fc-4e15-aa97-11db9b4a4614')
and activeflag =1 ;

---Case number 251023285507(IR) Intake number - I251013529751
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64018'
where objectid = 'I251013529751'
and activeflag =1 ;

--Case number 2020015501374 
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64018'
where routingid = 'ee74d52e-cdb4-4088-a6d7-73012cffbee3'
and objectid in  ('b96adebf-5dab-4e89-bcc1-ba1154049261')
and activeflag =1 ;



