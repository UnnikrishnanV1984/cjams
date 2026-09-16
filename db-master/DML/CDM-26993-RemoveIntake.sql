/*
   Issue Description: CDM-26993
   Category/ Module  :  Remove intake
   Root cause: user asked to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*No Records on the Routing and intakesnapshot table Hence removing records only from intakedastatus and intakedastaging */

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26993'
where intakenumber in ('I221010243477','I221010304000');

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26993'
where intakenumber in ('I221010243477','I221010304000');