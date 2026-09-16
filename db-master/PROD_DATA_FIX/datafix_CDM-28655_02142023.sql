/*
	Issue Description: CDM-28655 - CPS Case not showing up

	-- PS case # 231020355823 is not available in CJAMS
	select actiontype, intakeserviceid, servicecaseid, intakenumber,servicerequestnumber,activeflag from intakeservicerequest 
	where servicerequestnumber = '231020355823' ;
	select activeflag,* from actor where intakeserviceid ='15052245-1bb3-46ab-9f2e-a446eda0e0ec'
	select activeflag,* from intakeservicerequestactor where intakeserviceid ='15052245-1bb3-46ab-9f2e-a446eda0e0ec'
  
	email : meagann.ricker@maryland.gov
*/

update intakeservicerequest
set actiontype = 'AR',
	updatedby = 'CDM-28655',
	updatedon = now()
where servicerequestnumber = '231020355823';