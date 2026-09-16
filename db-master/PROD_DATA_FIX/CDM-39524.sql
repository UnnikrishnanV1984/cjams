/*
 * CDM-39524 - defective case
 * Customer Email ID:brenda.carr@maryland.gov
 * Description - 231020523436:This case continues to show up as an open CPS-AR case. However it was a CJAMS error - 
 * see ticket S2024057057249I have no ability to assign the case to anyone else, there is no maltreatment or disposition 
 * tab which renders the Department unable to close the case. This case is on the milestone and does impact complance. 
 * These allegations were assessed in another case, AR 231020563204 and this case can be deleted. 
 * CPS AR still displayed as a service case, and on the Intake SDM tab is not reflected to CPS AR case.
 * 
 */

--select isar , * from intakeservicerequestsdm where intakeserviceid = 'ea12c607-8928-4cc9-b0df-87657c709965';
UPDATE cjams.intakeservicerequestsdm
SET isar=true, updatedby='CDM-39524', updatedon=now() 
WHERE intakeservicerequestsdmid='3c40f88a-d127-4229-914f-9dc703a9cc2e'::uuid and intakeserviceid='ea12c607-8928-4cc9-b0df-87657c709965'::uuid;
