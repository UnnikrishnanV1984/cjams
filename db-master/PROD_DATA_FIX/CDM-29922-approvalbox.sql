/*
   Issue Description: CDM-29922
   Category/ Module  : approval screen 
   Root cause: user requeseted to remove pending  apporval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing 
set activeflag =0, 
updatedby ='CDM-29922', 
updatedon =now() 
where routingid ='b0c194c1-4fad-47f6-b709-99a3ddce829f';