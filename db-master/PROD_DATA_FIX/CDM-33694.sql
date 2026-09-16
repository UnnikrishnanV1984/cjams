/*
 * CDM-33694 - Removal of incorrect child
 * Customer Email ID:renee.little@maryland.gov
 * Customer Name:Renee Little
 * Focus Area:Court: Legal Custody
 * Had a call with worker, please delete the draft child removal record for the following
 * Case ID - 3299948, Cjams PID -3280393
 */

select activeflag ,* from intakeservreqchildremoval where intakeservreqchildremovalid = '71a655e6-681f-48a3-9be5-8906175ae11a' and intakeservicerequestactorid = '86b2519b-1268-4d55-a00a-b133ccaf7b5c';
UPDATE cjams.intakeservreqchildremoval
SET activeflag=0, updatedby='CDM-33694', updatedon=now() 
WHERE intakeservreqchildremovalid = '71a655e6-681f-48a3-9be5-8906175ae11a' and intakeservicerequestactorid = '86b2519b-1268-4d55-a00a-b133ccaf7b5c'; 