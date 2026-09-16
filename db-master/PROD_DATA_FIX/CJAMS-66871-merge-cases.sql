/*
Issue: Case connect with new service case
Category/Module: Case connect
Root cause: 1. Remove the CPS IR # 261023725522 connection with service case # 261030669795, and remove the service case.
2. Connect the CPS IR # 261023725522 with Service case # 231030239461.
3. All Contact Notes, Assessments, and Documents need to be moved from Case #261030669795 to Case # 231030239461
Fix provided: Data fix provided 
1. Removed the CPS IR # 261023725522 connection with service case # 261030669795, and remove the service case.
2. Connected the CPS IR # 261023725522 with Service case # 231030239461.
3. All Contact Notes, Assessments, and Documents moved from Case #261030669795 to Case # 231030239461
Data/Code fix ticket#: CJAMS-66871
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error, data fix should resolve the issue.
*/

select * from createservicecase('69561588-1bfb-4e71-ba1b-cd5de18f6709', 'b8e71910-5aeb-480e-b59a-23ab8875e49f',0,'a559b92f-9553-41ea-bc3c-37d1ab92f872',null,'ASSGN','intake',null);
