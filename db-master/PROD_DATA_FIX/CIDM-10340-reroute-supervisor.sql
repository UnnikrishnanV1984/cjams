/*
   Issue Description: CIDM-10340
   Category/ Module  : Prod data fix to re route the supervisor
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing
 set tosecurityusersid  ='5cf2d751-bd69-4436-bc02-60ca01abb28c' ,
 updatedby ='C1DM-10340',
 updatedon =now()
where routingid  ='7e0e4bac-d2aa-41eb-a5a3-0c0bcfd79fff'