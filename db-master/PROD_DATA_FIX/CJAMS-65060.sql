/*
Issue Description:CJAMS-65060 Delete intake
Category/Module: Intake Dashboard
Root cause: User is requested to remove the Intake # I261013862887
Fix provided: Data fix has been done to delete the intake from intake related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should remove it.
*/


update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-65060',
    updatedon = now()
where intakenumber='I261013862887'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-65060',
    updatedon = now()
where intakenumber='I261013862887'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-65060',
    updatedon = now()
where objectid = 'I261013862887'
and activeflag = 1;

update intakesnapshot 
set activeflag =0,
    updatedby = 'CJAMS-65060',
    updatedon = now()
where intakenumber = 'I261013862887'
and activeflag = 1;

update documentproperties
set activeflag = 0,
	updatedby = 'CJAMS-65060',
	updatedon = now()
where documentpropertiesid in('b43af0f3-feb4-4a9b-a1d2-39169a50b561','c1346635-9482-4c8e-9df9-3cf9b52c893d','e6910fc6-14ec-4ce3-a53c-5d8c40817fbf')
 	  and activeflag = 1 ;
 	  
 	 
update documentattachment
set activeflag = 0,
	updatedby = 'CJAMS-65060',
	updatedon = now()
where documentpropertiesid in('b43af0f3-feb4-4a9b-a1d2-39169a50b561','c1346635-9482-4c8e-9df9-3cf9b52c893d','e6910fc6-14ec-4ce3-a53c-5d8c40817fbf')
 	  and activeflag = 1 ;

update intakeservicerequest set servicecaseid = null,
updatedby = 'CJAMS-65060', updatedon = now() 
where intakenumber = 'I261013862887';

