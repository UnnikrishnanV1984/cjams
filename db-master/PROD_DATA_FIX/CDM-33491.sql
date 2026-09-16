/*
   Issue Description: CDM-33491
   Category/ Module  : approval inbox Screen
   Root cause: user want to remove Case approval inbox Screen
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set activeflag=0, updatedby ='CDM-33491', updatedon = now() where  routingid='94935c80-49cc-44d1-817d-39204cf29097';