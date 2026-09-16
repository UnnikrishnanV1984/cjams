/*
Issue Description: Change subsidy rate
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect subsidy rate date abd agreement date   and request for data fix.
Fix provided:Data fix is done to update the subsidy dates as requested
Data/Code fix ticket#: CJAMS-68654
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreement set startdate = '2015-07-01 00:00:00.000',
 updatedon = now(), updatedby = 'CJAMS-68654'
 where gapagreementid in ('c309e0c5-8bbc-41f7-b99e-7a987cd2ab5f','5050c9ad-304f-4822-9bf6-e6a31f1f5cf8','faf87914-b281-4e6b-80ed-467b58fd9837','90808374-fb69-4133-9894-f8a89f9d5ca3');

update gapagreementrevision set startdate = '2015-07-01 00:00:00.000',
updatedon = now(), updatedby = 'CJAMS-68654'
where gapagreementid in ('c309e0c5-8bbc-41f7-b99e-7a987cd2ab5f','5050c9ad-304f-4822-9bf6-e6a31f1f5cf8','faf87914-b281-4e6b-80ed-467b58fd9837','90808374-fb69-4133-9894-f8a89f9d5ca3');

update gapagreementrate set startdate ='2015-07-01 00:00:00.000',
updatedby='CJAMS-68654',updatedon=now() where gapagreementrateid in ('871cd884-ea60-4f5b-8b52-6afbb78eea5c','7ed8570b-9caf-43f1-8ed8-d8fb59aaa6a3','6fa01856-0d3f-4cb7-8f11-bc1e55f56c68','cc5db44d-0ee0-4273-9a57-83a0104a9a69') and activeflag =1;

update gapratesrevision  set ratestartdate='2015-07-01 00:00:00.000',approvaldate = now(),
updatedby='CJAMS-68654',updatedon=now() where gaprateid in ('871cd884-ea60-4f5b-8b52-6afbb78eea5c','7ed8570b-9caf-43f1-8ed8-d8fb59aaa6a3','6fa01856-0d3f-4cb7-8f11-bc1e55f56c68','cc5db44d-0ee0-4273-9a57-83a0104a9a69') and activeflag =1;

--- If we are changing the first rate slab then we have to update the updatedon= now() for all the remaining payments and trigger batch for GAP And AFS to validate 
update gapagreementrate set  
updatedby='CJAMS-68654',updatedon=now() 
where gapagreementid in ('c309e0c5-8bbc-41f7-b99e-7a987cd2ab5f','5050c9ad-304f-4822-9bf6-e6a31f1f5cf8','faf87914-b281-4e6b-80ed-467b58fd9837','90808374-fb69-4133-9894-f8a89f9d5ca3') and activeflag=1;