
/*
Issue Description: CJAMS-67698 -correction on overdue reason for a case
Category/Module: Case Management
Root cause: 261023581173:Request correction of Over Due Reason. For alleged victim it should reflect: "Alleged victim unavailable > Attempted face to face > 1-2 attempts. For initial contact caregiver it should reflect: "Initial contact caregiver unavailable > Attempted face to face > 1-2 attempts.
Fix provided: Data fix has been promoted to update cpsresponsetimeractions table and also soft deleted the contacts which were attempted but failed from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F', updatedon = now(),
    updatedby = 'CJAMS-67698'
where cpsresponsetimeractionsid = 'f4efdc78-8930-42fc-a96e-1d43d7f7cfbe'
and intakeserviceid = 'ff082399-ec02-46a3-b13a-ea79e519cdba'
and activeflag = 1;