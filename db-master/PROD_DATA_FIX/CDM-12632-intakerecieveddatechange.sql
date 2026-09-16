-- 0202-04-23 14:07:56
update intakedastaging 
set daterecieved = '2021-04-23 14:07:56'
		, timerecieved = '2021-04-23 15:56:02'
		, jsondata = replace(jsondata :: text , '4/23/202, 2:07:56 PM', '4/23/2021, 2:07:56 PM')::json
		, updatedby = 'CDM-12632'
		, updatedon = now()
where intakenumber = 'I202100550573' and activeflag = 1 ;


update intakeservicerequest set intakedaterecieved = '2021-04-23 14:07:56', updatedby = 'CDM-12632'
		, updatedon = now()
 where IntakeNumber = 'I202100550573';	

update intakesnapshot 
set 	jsondata = replace(jsondata :: text , '4/23/202, 2:07:56 PM', '2021-04-23T14:07:56.000Z')::json
		, updatedby = 'CDM-12632'
		, updatedon = now()
where intakenumber = 'I202100550573' and activeflag = 1 ;