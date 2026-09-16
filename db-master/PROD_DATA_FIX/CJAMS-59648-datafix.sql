/* 
    Issue Description: CJAMS-59648
   Category/ Module  : Cases to be assigned
   Root cause: :251023050797 - This case can be deleted
   Fix provided: Data fix has been promoted 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


update intakeservicerequest 
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where servicerequestnumber = '251023050797'
and activeflag = 1;

update intakeservicerequestsdm 
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where intakeserviceid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;

update intakeservicerequestdispositioncode 
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where intakeserviceid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;


update caseassignment 
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where objectid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;

update  personprogramarea
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where objectid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;

update actor
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where intakeserviceid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where intakeserviceid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;

update personrole
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where intakeserviceid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;

update actorrelationship
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where intakeserviceid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;

update  personroletype
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where personroleid in ('fae8a65f-91a0-42b6-9b08-364b69d04491','f45b6a96-8333-420d-ad61-02e097144783',
'a989fcef-a752-40c5-8a12-18feb6d247a9','040e8380-cbbc-4163-a0bc-36192990c484')
and activeflag = 1;

update routing
set activeflag = 0,
updatedby = 'CJAMS-59648',
updatedon = now()
where objectid = '54954975-45c5-42b0-9c45-1aef9d0e432e'
and activeflag = 1;