/*
 Issue Description: CDM-36515
 Category/ Module : Intake
 Root cause: 3078226, servicecase is reopened but still showing as open in Persons Search -> Prior History.
 Fix: Datafix to update statustypekey,dispositioncode to Open status 
 Pull request# for code fix: 
 Reason why no related code fix:  validate reopenservicecase storedproc and it looks good to reset ths status on case reopens.
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */

select statustypekey, dispositioncode, enddate, * from servicecase where servicecasenumber  = '3078226';


UPDATE servicecase
  SET statustypekey ='Open',
	  dispositioncode = 'Open',
	  enddate = null,
	  updatedby = 'CDM-36515',
	  updatedon = now()
  WHERE servicecaseid = '018fec81-e119-4c66-820a-8cecce19d2ca';