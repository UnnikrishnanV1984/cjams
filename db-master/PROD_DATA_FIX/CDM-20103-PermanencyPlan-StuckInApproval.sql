/*
   Issue Description: CDM-20103
   Category/ Module  : Permanency plan stuck in approval inbox
   Root cause: user wants to delete approved record which is still showing in inbox 
   Pull request# for code fix: 4736
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update routing 
set activeflag = 0, updatedby = 'CDM-20103', updatedon = now()
where routingid = 'f4ecafae-d210-4c34-8ae4-cbf32f9f019c';