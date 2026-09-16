/*
   Issue Description: CDM-23164
   Category/ Module  : Removal of CPS IR to service case and assigning OOH
   Root cause: user wants restore the goal which got deleted by mistake
   Pull request# for code fix: 5709
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



UPDATE splangoal set activeflag = 1,
    updatedby = 'CDM-23164',
	updatedon = now() where splangoalid = '7cbc2b78-59c1-454c-8c38-1035118eec31';