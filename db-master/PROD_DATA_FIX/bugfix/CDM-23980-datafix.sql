/*
   Issue Description: CDM-23980
   Category/ Module  : ChildRemoval
   Root cause: User has to create another placement with pre-adoptive home in order to get the provider details in the Break-the-line (adoption)
   In order to create another placement, need to remove the end date of removal.
*/

update 	intakeservreqchildremoval
set 	exitdate = null, 
		returndate = Null,
		returntime = Null,
		removalexitreason = NULL,
		updatedby = 'CDM-23980', 
		updatedon = now()
where 	removalid = '250364' and activeflag = 1;