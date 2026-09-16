
/*
   Issue Description: CDM-18876
   Category/ Module  : Updating the correct intakeserviceactorid
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

	-- 7c7456df-1a6a-4797-bd86-5c9944062906
	update placement set intakeservicerequestactorid = 'b203a684-9d2e-408a-9fad-898ad5180223',updatedby = 'CDM-18876', updatedon = now() where placementid in ('e0fa72ba-d4a9-4786-bb31-6cc59bbd3150','ae2ac2b7-5483-4a73-938f-9859b19d3c5a');