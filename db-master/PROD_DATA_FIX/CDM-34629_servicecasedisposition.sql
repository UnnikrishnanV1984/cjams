/* 
   Issue Description: CDM-34629
   Category/ Module  : Service case disposition
   Root cause: user wants to delete duplicate case closure disposition from the decision screen. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update servicecasedisposition 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-34629'
where servicecasedispositionid = '13f9b797-1480-4ae8-b4a2-325bfc853257';

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-34629'
where objectid = '13f9b797-1480-4ae8-b4a2-325bfc853257' and routingid = '49d92fef-f79e-4941-860b-7a68d0349820'
