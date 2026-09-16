/*
 * CDM-33667 - Assessment Must Be Deleted
 * Customer Email ID:stacie.parker@maryland.gov
 * Customer Name:Stacie Parker
 * Focus Area:Assessments: SAFE-C OHP
 * 231020595073:The Safe C OHP in investigation 231020595073 for child Lyla Lamonica was entered in error (wrong child was selected). This assessment must be deleted.
 * CJAMS PID: 200911592
 * api/admin/assessment/getassessmentform/5b7ae9ede881f068be283ef5/submission/6495a569deb302001bd6e8f0
 * 
 * */

	
select * from assessment where objectid  = 'b7c4947d-026f-47c6-a98b-d6bdf8575253' and submissionid = '6495a569deb302001bd6e8f0';
UPDATE cjams.assessment
SET activeflag=0, updatedby='CDM-33667', updatedon=Now()  
WHERE objectid  = 'b7c4947d-026f-47c6-a98b-d6bdf8575253' and 
submissionid = '6495a569deb302001bd6e8f0'; 