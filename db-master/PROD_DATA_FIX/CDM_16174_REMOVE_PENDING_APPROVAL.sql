/*
   Issue Description: CDM-16174
   Category/ Module  :  Approval Inbox 
   Root cause: user wants to remove the dupliate records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Note: Please execute this PR only in stage 3 due to data refresh happened we are still seeing the duplicate record in stage3. It not an issue just to remove the duplicate record.
*/




update servicecasedisposition set activeflag = 0, updatedby = 'CDM-16174', updatedon = now() where servicecasedispositionid = 'f3b625f9-a381-412b-962d-a711c3c5da70';