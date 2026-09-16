/*
   Issue Description: CDM-21610
   Category/ Module  : approved record in pending inbox
   Root cause: user wants remove theappoved record
   Pull request# for code fix: 5201
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21610' 
where routingid = 'b9c61868-2bce-46fd-aff6-fe4a01bb93be';