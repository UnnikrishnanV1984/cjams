/*
   Issue Description: CDM-30562
   Category/ Module  : Approval inbox
   Root cause: user requested remove case form the approval inbox 
   Pull request# for code fix: 8781
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-30562',
    updatedon = now()
where routingid ='46a140d6-439a-43f6-a3ae-652eb5f943f2';