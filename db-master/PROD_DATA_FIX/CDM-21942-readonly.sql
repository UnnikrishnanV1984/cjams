 /*
  Issue Description: CDM-21942 Contact Notes
   Category/ Module  :  user manamgement
   Root cause: removed the readonly access
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


update	userresource set
		activeflag = 0,
		updatedby = 'CDM-21942',
		updatedon = now()
	where
		userid = 9643
		and activeflag = 1
		and permissiongroupid = '9f0a99a4-08ae-43ee-ba78-cb8e52a818da';