/*
   Issue Description: CDM-32520
   Category/ Module  :  remove intake
   Root cause: user asked to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32520'
where objectid in('I231010643131','I221010303941');

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32520'
where intakenumber in('I231010643131','I221010303941');

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32520'
where intakenumber in('I231010643131','I221010303941');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-32520'
where intakenumber in('I231010643131','I221010303941');