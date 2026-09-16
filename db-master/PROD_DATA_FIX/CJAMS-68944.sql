/*
Issue: HIGH
Category/Module: Case connect
Root cause: User requested to connect the newly created intake with the existing case.
Fix provided: Data fix has been done to connect intake I261014125830 with case 241030408959
Data/Code fix ticket#: CJAMS-68944
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:data fix should resolve the issue.
*/

select * from createservicecase('2dfb1505-d9e7-42fc-b2ae-0c9eafa4099a', '3b278152-2cd5-4070-b658-5971472add3f',0,'c132839a-76e5-498d-a8bd-306591287fc4',null,'ASSGN','intake',null);