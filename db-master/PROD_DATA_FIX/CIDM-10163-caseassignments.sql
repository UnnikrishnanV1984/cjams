/*
  Issue Description:CIDM-10163 Duplicate family assignment issue 
  Category/ Module : Case Assignments
  Root cause:  B-202849 story changes had data fix which introduced duplicate family assignments.
  Fix Provided: Data fix has been promoted to Remove dupliacte family assignment
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/
-- 3284221, 3119104, 3161204, 251022990051, 231030100975, 251022984500, 251022990027, 251022989208,251022987959 

-- 3284221
update caseassignment
set enddate = '2025-01-22 16:31:12.963', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('883671ff-a4e4-437c-9f31-038d68c4eb2f') and activeflag = 1;
-- 3119104
update caseassignment
set enddate = '2025-01-23 15:30:45.835', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('43f48c07-f05e-451e-86f2-58c9053817f8') and activeflag = 1;
-- 3161204
update caseassignment
set enddate = '2025-02-04 13:23:28.303', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('38050bf5-4a7b-41d8-b6a9-051b66e77b0c') and activeflag = 1;
-- 251022990051
update caseassignment
set enddate = '2025-01-30 12:34:06.351', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('8a987bb1-21fc-426e-9269-459f554e1b27') and activeflag = 1;
-- 231030100975
update caseassignment
set enddate = '2025-01-27 13:21:46.123', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('a53065cd-05c6-4450-984c-f8a70c5b47a4') and activeflag = 1;
-- 251022984500
update caseassignment
set enddate = '2025-01-21 09:04:07.216', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('384409c0-5903-4760-a9b1-cd03177d44ba') and activeflag = 1;
-- 251022990027
update caseassignment
set enddate = '2025-01-30 12:51:01.884', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('4923de61-3b07-4e2f-9958-bfaebca71476') and activeflag = 1;
-- 251022989208
update caseassignment
set enddate = '2025-01-29 18:43:30.000', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('41cfb4a4-7605-40f7-9580-54b413bafaaf') and activeflag = 1;
-- 251022987959
update caseassignment
set enddate = '2025-01-27 08:15:33.326', updatedon = now(), updatedby = 'CIDM-10163'
where caseassignmentid in ('bc3ba4b7-c2ca-46ef-9f2f-52ec8db7347f') and activeflag = 1;