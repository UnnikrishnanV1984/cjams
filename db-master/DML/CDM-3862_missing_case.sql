
update cjams.intakeservicerequest set activeflag = 0, updatedby = 'CDM-3862', updatedon = now() where intakeserviceid = '56b915b3-6bd2-40a6-a344-f242a69ca00d';

update cjams.intakeservicerequestactor set servicecaseid = 'c0d5fdfb-bad1-405c-a600-ec5bca8417fc' , updatedby = 'CDM-3862' , updatedon = now(), intakeserviceid = null where intakenumber = 'I202000575290';

update cjams.actor set servicecaseid = 'c0d5fdfb-bad1-405c-a600-ec5bca8417fc' , updatedby = 'CDM-3862' , updatedon = now(), intakeserviceid = null where intakenumber = 'I202000575290';

update cjams.personrole set servicecaseid = 'c0d5fdfb-bad1-405c-a600-ec5bca8417fc' , updatedby = 'CDM-3862' , updatedon = now(), intakeserviceid = null where intakenumber = 'I202000575290';

update cjams.personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-3862', datatransferflag = 'D' where objectid = '56b915b3-6bd2-40a6-a344-f242a69ca00d';
	
