/*
   Issue Description: CDM-25138
   Category/ Module  : Prod data fix to update received date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 2022-09-06 11:10:00.000
update intakedastaging 
set daterecieved = '2022-07-06 09:00:00.000'
		, timerecieved = '2022-07-06 09:00:00.000'
		, jsondata = replace(jsondata :: text , '9/6/2022, 11:10:00 AM', '7/6/2022, 9:00:00 AM')::json
		, updatedby = 'CDM-25138'
		, updatedon = now()
where intakenumber = 'I221010310779' and activeflag = 1 ;


update intakeservicerequest set intakedaterecieved = '2022-07-06 09:00:00.000', updatedby = 'CDM-25138'
		, updatedon = now()
 where IntakeNumber = 'I221010310779';	

update intakesnapshot 
set 	jsondata = replace(jsondata :: text , '9/6/2022, 11:10:00 AM', '7/6/2022, 9:00:00 AM')::json
		, updatedby = 'CDM-25138'
		, updatedon = now()
where intakenumber = 'I221010310779' and activeflag = 1 ;



-- 2022-09-02 08:42:48.000
update intakedastaging 
set daterecieved = '2022-08-17 08:00:00.000'
		, timerecieved = '2022-08-17 08:00:00.000'
		, jsondata = replace(jsondata :: text , '9/2/2022, 8:42:48 AM', '8/17/2022, 8:00:00 AM')::json
		, updatedby = 'CDM-25138'
		, updatedon = now()
where intakenumber = 'I221010310061' and activeflag = 1 ;


update intakeservicerequest set intakedaterecieved = '2022-08-17 08:00:00.000', updatedby = 'CDM-25138'
		, updatedon = now()
 where IntakeNumber = 'I221010310061';	

update intakesnapshot 
set 	jsondata = replace(jsondata :: text , '9/2/2022, 8:42:48 AM', '8/17/2022, 8:00:00 AM')::json
		, updatedby = 'CDM-25138'
		, updatedon = now()
where intakenumber = 'I221010310061' and activeflag = 1 ;

