/*
   Issue Description: CDM-18492
   Category/ Module  : programm assignment
   Root cause: user requeseted to update end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement set enddatetime = '2021-10-07 00:00:00', updatedby = 'CDM-18492', updatedon = now()
	where placementid = 'ec136fe9-fd46-4a5a-934c-23ea3f4d0a21';

	update livingarrangement set livingenddate = '2021-10-07 00:00:00', updatedby = 'CDM-18492', updatedon = now()
	where placementid = 'ec136fe9-fd46-4a5a-934c-23ea3f4d0a21';