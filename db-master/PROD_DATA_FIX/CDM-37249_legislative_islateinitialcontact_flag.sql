/*
   Issue Description: CDM-37249 - legislative response
   Case # CPS-AR : 231021437057. When I go to close the case, the response states required reporting. The legisltive response has been recorded and approved.
   Category/ Module  : Decision
   Root cause: Review Checklist flag 'Required Reporting: Late or Incomplete Initial Contact' not selected though the legislative response has been recorded and approved
   Customer Email: shelley.brown@maryland.gov
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: islateinitialcontact flag in Legislative response didn't set to true in database.
*/

update legislative
	set islateinitialcontact = true,
		updatedby ='CDM-37249',
		updatedon =now() 
	where legislativeid ='33c4d7c0-4a61-4ee6-83c5-16feac9492f7';