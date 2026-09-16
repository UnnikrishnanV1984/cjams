/*
  Issue Description:  CDM-42709
   Category/ Module  :  Case profile Decision
   Root cause: The case connect is reflected on the CPS side but the service case was not re-opened. Supervisor then did a manual re-open and chose Enter Contact note as the reason.
   Fix Provided: Datafix has been promoted to update the Reopen Action.
    Pull request# N/A 
    Is Code fix Required?: No
    Code fix ticket#: N/A
    Reason why no related code fix: TBD
    Regression Impacts: N/A
*/

update servicecasedisposition 
set 
    reopenreasonkey='RSIE', 
    updatedby = 'CDM-42709', 
    updatedon = now() 
where 
    servicecasedispositionid='ecaf5310-b551-4b41-82b2-4577af171043'  
    and servicecaseid='310a7a02-15ba-4164-bfee-9e4a8c176a82' 
    and activeflag=1;