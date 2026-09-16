/*
   Issue Description: CJAMS-59763
   Category/ Module  :  remove intake
   Root cause: user asked to remove intake as new intake and case already created.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59763'
where objectid = 'I251013280490';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59763'
where intakenumber = 'I251013280490';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59763'
where intakenumber = 'I251013280490'
	and activeflag=1;

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59763'
where intakenumber = 'I251013280490';

update intakeservicerequest
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-59763'
 where intakenumber = 'I251013280490' and activeflag = 1 ;