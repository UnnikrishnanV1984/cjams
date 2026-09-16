/*
   Issue Description: CDM-33490
   Category/ Module  : approval inbox Screen
   Root cause: user want to remove Case approval inbox Screen
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set activeflag=0, updatedby ='CDM-33490', updatedon = now() where  routingid='6e1ba685-e0b9-4301-86de-279fac14382e';