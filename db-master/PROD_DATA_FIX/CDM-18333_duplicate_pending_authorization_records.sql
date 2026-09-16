
/*
   Issue Description: CDM-18333
   Category/ Module  : Pending authorization  
   Root cause: User reported duplicate pending authorization records created
   Pull request# for code fix: 4226
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


select * from routing where objectid = 1803570 and routingid in ('62dbb62a-b219-4cef-91e7-b13067fbfc4d', '6cc6b173-7cba-45ce-811b-9d8d3dc9f323');
delete from routing where objectid = 1803570 and routingid in ('62dbb62a-b219-4cef-91e7-b13067fbfc4d', '6cc6b173-7cba-45ce-811b-9d8d3dc9f323');