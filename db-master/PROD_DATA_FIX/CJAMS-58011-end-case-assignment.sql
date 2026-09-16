/*
   Issue Description: CJAMS-58011 Family worker assigned to closed case
   Category/ Module  : Assignments
   Root cause: The open worker assignment is not ended after the case closure approved by the supervisor and it was resolved as the part of CIDM-9999. 
   Fix Provided: Data fix has been done to endate the case assignment.Code fix was already done as the part of CIDM-9999 and user tried closing this ticket before this code fix. 
   Data/Code fix ticket#: CJAMS-58011
   Regression Impacts: N/A
   Is Code fix Required?: Yes
   Code fix ticket#: CIDM-9999
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update caseassignment
set enddate='2024-01-10 00:00:00', updatedby='CJAMS-58011', updatedon=now()
where caseassignmentid='5060ec9a-e7d0-4085-9f86-4172767a1a2b' and activeflag=1;