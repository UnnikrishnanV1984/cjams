/*
   Issue Description: CDM-31500
   Category/ Module  :Approval inbox
   Root cause: user want to remove case from the user pending approval dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set activeflag=0 ,updatedby = 'CDM-31500', 
updatedon = now() where activeflag=1 and  routingid ='f3db8a9a-0d72-4b3a-ac05-462594179694';