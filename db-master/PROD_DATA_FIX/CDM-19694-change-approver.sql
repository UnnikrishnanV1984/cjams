/*
   Issue Description: CDM-19694
   Category/ Module  : change approver 
   Root cause: user requeseted to change approver name
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/ 
 
 update snapshothist ss set ss.updatedby  = 'ffaff6c5-0784-47e8-b29e-a04373e6cc89',updatedon = now() where ss.id  = 'f593f72b-65e8-4565-b76b-c89d6fdcb665';