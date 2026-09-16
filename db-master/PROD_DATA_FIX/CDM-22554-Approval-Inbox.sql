/*
   Issue Description: CDM-22554
   Category/ Module  : Approval Inbox 
   Root cause: user wants to remove approved records from case pending tab
   Pull request# for code fix: 7455
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing set activeflag = 0, updatedby = 'CDM-22554', updatedon = now()
where routingid in ('82e742dd-6d3b-4dbc-91c5-12f56db3dd2d', '915c168f-c6c6-4db3-bf49-16ed3e59b24e');
