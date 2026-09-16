/*
    Issue no: CDM-16713
    Root cause: Requested in error
    Data Fix: Removing the pending request from approval inbox 
*/
update routing 
set activeflag = 0, updatedby = 'CDM-16713', updatedon = now()
where routingid = '635dbc81-39ce-4578-8dad-c9fa56ce37c6';