/*
Issue:251023110387:Findings were changed to Indicated by Supervisor and Investigation Summary Report was edited to support the Indicated finding, however, finding changed back to Unsubstantiated. The investigation is now closed with the incorrect finding.
Root Cause:User request to change findings from unsubstantiated to Indicated, case was completed due to user do not have access to do that.
Fix Provided (Data Fix Only):Data fix was done by Updated investigationallegationmaltreators table and investigationfinding a record into routing table..
Data/Code fix ticket#: CJAMS-63020
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update investigationfinding
set investigationfindingtypekey = 'ID',updatedby ='CJAMS-63020', updatedon = now()
where investigationfindingid in ('03df70f5-fa56-49a6-a5a1-072c7e6c3e29',
'ba1dd604-9b45-4c75-bc7c-5e2c0955cd63') and activeflag=1;


update investigationallegationmaltreators 
set scdecisiontypekey ='ID',updatedby ='CJAMS-63020', updatedon = now()
where investigationallegationmaltreatorsid in ('4ed1e209-e895-45c8-9427-d17e21f9e033',
'c97d3af9-c4be-4a65-9b04-d6ab6b9bfa2a',
'55511bcc-341d-4178-af1c-6a24040b1f10',
'eee20e88-2d2b-44ee-a2b2-446c1492ce79',
'89edc193-8a9c-4377-9133-c11e2cc28326') and activeflag=1;