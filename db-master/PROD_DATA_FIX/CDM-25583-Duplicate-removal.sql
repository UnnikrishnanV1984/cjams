/*
   Issue Description: CDM-25583
   Category/ Module  : Case assignment Removal 
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4718
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


--issue-1
update cpsresponsetimeractions set activeflag = 0, updatedon = now(), updatedby = 'CDM-25583' 
where cpsresponsetimeractionsid ='594aaab8-9c50-4ca3-95d4-17cb27191293';


--Issue-2
update routing set activeflag = 0, updatedby = 'CDM-25583', 
updatedon = now() where objectid = '594aaab8-9c50-4ca3-95d4-17cb27191293' and routingid ='f9863804-2d70-480f-90aa-67a8d81c4c47';
