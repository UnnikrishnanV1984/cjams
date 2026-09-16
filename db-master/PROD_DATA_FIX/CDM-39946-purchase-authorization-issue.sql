/*
  Issue Description: 3299449:Purchase authorization is not being seen/sent to finance office for approval
                     Client ID: 200771687 (Nevaeh Short)
                     Provider ID: 6018638 (Stephanie Hauck)
                     Service: Adoption Attorney Fees (Paid)
                     Purchase Auth ID: 3109252
  Category/ Module : Purchase Authorization
  Root cause: 3299449:Finance department does not have access to approve purchase authorization 3109252 as it is not available in the routing records.
  Fix Provided: Data fix has been promoted to update the routing table to make the purchase authorization id #3109252 available in finance dashboard
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update routing
set activeflag = 1,
    updatedby = 'CDM-39946',
    updatedon  =  now()
where objectid = '3109252'
and routingid = '5f963c16-27b1-4802-ac05-daa6031989bd';