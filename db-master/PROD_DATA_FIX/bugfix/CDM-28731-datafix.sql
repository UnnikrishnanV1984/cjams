/*
   Issue Description: CDM-28731
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28731'
        where objectid  = 'a4618a6b-0379-4dba-88d1-c2d12e65c43c'
        and routingid = 'e6f53a44-5e7a-42c7-8d14-92e59c8a0d1b';

        

update intakeservreqchildremoval 
set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-28731'
where intakeservreqchildremovalid= 'a4618a6b-0379-4dba-88d1-c2d12e65c43c';