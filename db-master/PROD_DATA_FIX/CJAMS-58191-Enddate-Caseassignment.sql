/*
   Issue Description: CJAMS-58191 241022230459:assignment needs to be ended as appeal has been completed.
   Category/ Module  : Assignments
   Root cause:This is a known issue and Case assignment end date is not getting updated on adaption case closure. 
              Case #3165066 and we have a code fix for avoiding such issues in future.
              Code fix for this issue is deployed as the part of CIDM-9999 (It has already been deployed for this issue)
   Fix Provided: Data fix has been done to endate the case assignment  
   Data/Code fix ticket#: CJAMS-58191
   Regression Impacts: N/A
   Is Code fix Required?: Yes
   Code fix ticket#: CIDM-9999
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update caseassignment
set enddate='2025-02-10 00:00:00', updatedby='CJAMS-58191', updatedon=now()
where caseassignmentid='2da70105-13b0-4731-883c-cf5eab0a355c' and activeflag=1;