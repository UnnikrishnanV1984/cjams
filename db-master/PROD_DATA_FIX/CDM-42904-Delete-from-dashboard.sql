/*
   Issue Description: CDM-42904
   Category/ Module  :Dashboard 
   Root cause: User wants remove the records from approval dashboard.
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/


update routing 
 set activeflag=0, updatedby='CDM-42904', updatedon=now() 
 where routingid in (   '21164988-a326-411f-91fa-caf2ad9da531',
						'a25a0c34-6128-44f8-bf1e-7c4d67891cb8',
						'7ad9c117-0dfe-49c2-be27-4271fc3b7f08',
						'ad07c25c-0a90-4275-bb30-6bd217353ccb',
						'e111af39-f8c8-4bd9-ae91-652705532020',
						'bf3c2229-e937-4072-a344-53345dc47fc9',
						'a78ea888-136d-4592-8767-6c2c59cab1d4',
						'7bd9e5b2-08a2-47a0-8c68-94c0b06fd365') and activeflag =1;