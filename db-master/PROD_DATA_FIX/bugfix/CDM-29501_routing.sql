/*
   Issue Description: CDM-29501
   Category/ Module  : Intake Module
   Root cause: Event code updated to XXXX on update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing 
set eventcode = 'INTR', routingstatustypeid = 2, activeflag = 1, updatedon = now(), updatedby = 'CDM-29501'--'5b6f8fab-f495-494a-ada8-675474160b17'
where objectid in ('I231010526404','I231010528995','I231010523578') and eventcode = 'XXXX'