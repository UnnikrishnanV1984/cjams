/*
   Issue Description: CDM-18960
   Category/ Module  :Approval stuck in queue
   Root cause: user wants toremove pending approvals
   Pull request# for code fix: 
  explanantion: user wants to delete the pending approvals which are already approved
*/

update routing set activeflag = '0', updatedon = now(), updatedby = 'CDM-18960'
where objectid = 'ea231eca-7666-4e5f-8008-47068ad31789'
and routingid = 'bfafea64-9690-4b80-b597-dfa220c709ee';