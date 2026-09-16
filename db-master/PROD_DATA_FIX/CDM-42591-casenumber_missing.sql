/* 
   Issue Description: CDM-42591 Case Number Missing
   Category/ Module  : Title IVE GAP
   Root cause: The GAP case is not linked with case number due as it is chessie data and it has not been mapped correctly in gapeligibilityinfo table.
   Fix Provided : Data fix has been provided to link the servicecaseid and casenumber for the particular 
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update gapeligibilityinfo 
set casenumber = '3228721',
	updatedby = 'CDM-42591', 
	servicecaseid = '1e3fc4e0-8785-4819-80c1-cc1ea8ceb367',
	haapprovaldtjson = '[{"text":"2023-03-10","value":128766},{"text":"2023-02-10","value":123323}]',
	updatedon = now()
where client_id = '4306659' and activeflag =1;