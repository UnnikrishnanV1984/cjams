-- CDM-21308 - Ticklers on client that does not exist
/*
-- Issue Description: 
   User is receiving education ticklers for the CJAMS client that does not exist.
   Angela Seri CJAMS ID 200800745, 

-- Category/ Module: User Notification (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Education BID user notifications for the persons with activefalg = 0
select usernotificationid, objectcasenumber, activeflag, updatedby, updatedon, old_id, subject 
from usernotification 
where old_id = 'edu-rm-bid'
	and activeflag = 1
	and ( body like '%200800745 %'
		  or
  		  body like '%3459465 %'
  		  or
  		  body like '%4489919 %'
  		  or
  		  body like '%4491220 %'
  		)  
order by objectid, insertedby desc 	; 

update usernotification
set activeflag = 0,	
	updatedby = 'CDM-21308',
	updatedon = now()
where old_id = 'edu-rm-bid'
	and activeflag = 1
	and ( body like '%200800745 %'
		  or
  		  body like '%3459465 %'
  		  or
  		  body like '%4489919 %'
  		  or
  		  body like '%4491220 %'
  		) ;  
