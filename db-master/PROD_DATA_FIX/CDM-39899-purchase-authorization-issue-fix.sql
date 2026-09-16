/*
  Issue Description: CDM-39899 :Finance department does not have access to approve purchase authorization 3298737
  Category/ Module : Purchase Authorization
  Root cause: 202102805636:Finance department does not have access to approve purchase authorization 3298737 as it is not available in the routing records.
  Fix Provided: Data fix has been promoted to update the routing table to make the purchase authorization id #3298737 available in finance dashboard
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update routing
set activeflag = 1,
    updatedby = 'CDM-39899',
    updatedon  =  now()
where objectid = '3298737'
and routingid = 'b2c7b7ff-cdb9-4cab-bf87-f8a5ead7b23f';