/*
 * CDM-35016 - Date to be corrected
 * Customer Email ID:ronda.lewis@maryland.gov
 * Customer Name:Ronda Lewis
 * Focus Area:Assessments: CANS
 * Description - 231030179375:Supervisor approved the CANS-F with the wrong date, the worker completed the initial CANS-F on 10/5/2023, 
 * this one should be dated for 10/18/2023 at 1:00pm. Wrong date was entered in error. Please correct date or un approve the CANS-F so supervisor/worker 
 * can fix date and re approve. Thanks Case M. Galvez-Velasquez case number 231030179375 
 * remove the CANS-F assessment approved status to Review so the caseworker can resubmitted for supervisor approval after fixed the date.
*/

select assessmentstatustypekey, updatedon, * from assessment where assessmentid = '3e78c93c-19b6-4f1f-8805-d38120adaf50';
UPDATE cjams.assessment
SET assessmentstatustypekey='Review', updatedby='CDM-35016', updatedon='2023-10-18 13:00:00.000' 
WHERE assessmentid='3e78c93c-19b6-4f1f-8805-d38120adaf50'::uuid;
