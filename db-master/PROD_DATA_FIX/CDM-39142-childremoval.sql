/*
   Issue Description: CDM-39142- Placement Entry Issue
   Category/ Module  : Child removal and assignments
   Root cause: User error
   Fix Provided: Data fix to remove end date for removal and assignment
*/

UPDATE cjams.intakeservreqchildremoval
SET updatedby='CDM-39142', updatedon=now(), exitdate=null, removalexitreason=null
WHERE intakeservreqchildremovalid='6ca14ab3-8315-4681-b876-beb2c41c3b46'::uuid and removalid=253529;

update personprogramarea
set  updatedon=now(), enddate=null
where personprogramid = 'd219505c-8a88-4fac-aafc-df0d77f32e12' and personid = 'd7846312-f780-459c-89d6-9354b7345da2'
