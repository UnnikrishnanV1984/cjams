/* 
   Issue Description: CDM-34726
   Category/ Module  : Service case disposition
   Root cause: user wants to delete duplicate case closure disposition from the decision screen. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update servicecasedisposition 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-34726'
where servicecasedispositionid = '3bc29279-890e-48c9-9fa4-409edd418614';

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-34726'
where objectid = '3bc29279-890e-48c9-9fa4-409edd418614' and routingid = 'b47b2eca-72c8-475c-b8de-4d2a9e138812'
