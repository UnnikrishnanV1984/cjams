
update intakedastaging set status='Closed', updatedon=now() where activeflag=1 and intakenumber='I202000259049';

update intakeservicerequest set intakeservicerequestclassid='00000000-0000-0000-0000-000000000000',
actiontype=null, updatedon=now(), updatedby='CJAMS-40' where servicerequestnumber IN ('2020070016721');


delete from usernotificationmap where usernotificationid in (
select distinct usernotificationid from Usernotification where activeflag = 1  and subject like 'Diposition status changed to %' and 
objectid in (select intakeserviceid::character varying from intakeservicerequest where servicerequestnumber = 2020024014827) );

delete from Usernotification where activeflag = 1  and subject like 'Diposition status changed to %' and 
objectid in (select intakeserviceid::character varying from intakeservicerequest where servicerequestnumber = 2020024014827);

delete from intakeservicerequestdispositioncode where intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8' and 
intakeserviceid IN (
select intakeserviceid from intakeservicerequest where servicerequestnumber = 2020024014827
);

update intakeservicerequest set intakeserreqstatustypeid ='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby= 'CJAMS-40', 
updatedon=now() where servicerequestnumber = 2020024014827 and 
intakeserreqstatustypeid ='7995cecb-062d-406c-8ea9-b1da4b1877d8' ;


