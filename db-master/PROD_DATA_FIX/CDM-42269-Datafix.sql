/*
  Issue Description:  CDM-42269
   Category/ Module  : Contact Notes
   Root cause: User request data fix to change the Reopen action from 'Enter a Contact Note' to 
            'Reopen a Service Case closed in error for the latest record in decision tab.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update servicecasedisposition set reopenreasonkey='RSIE', updatedby = 'CDM-42269', updatedon = now() 
where servicecasedispositionid='ecaf5310-b551-4b41-82b2-4577af171043' 
and servicecaseid='310a7a02-15ba-4164-bfee-9e4a8c176a82' and activeflag=1;