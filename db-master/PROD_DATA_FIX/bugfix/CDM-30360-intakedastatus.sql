
/*
   Issue Description: CDM-30360
   Category/ Module  : intakedastatus,  intakedastaging, routing, intakesnapshot
   Root cause: User created duplicate by mistake and wants I231010564895 duplicate needs to be deleted 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

 update
	routing
set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-30360'
where
	objectid = 'I231010564895';

update
	intakedastatus
set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-30360'
where
	intakenumber = 'I231010564895';

update
	intakedastaging
set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-30360'
where
	intakenumber = 'I231010564895';

update
	intakesnapshot
set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-30360'
where
	intakenumber = 'I231010564895';