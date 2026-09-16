
/*
   Issue Description: CDM-26088
   Category/ Module  : Approval Inbox
   Root cause: User requested to delete approved YTP from Approval Inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--enable existing approved record with approved status
/*No need to change the status for Approved*/
-- update 	routing 
-- set		activeflag = 1,
-- 		routingstatustypeid = 16,
-- 		updatedby = 'CDM-26088',
-- 		updatedon = now()
-- where 	routingid = '148c6b33-b0df-45e4-a95c-4e436c3708a5';

--delete Review record
update 	routing 
set		activeflag = 0,
		updatedby = 'CDM-26088',
		updatedon = now()
where 	routingid = 'aea6ee39-571a-478c-9296-273a632e47c4';
