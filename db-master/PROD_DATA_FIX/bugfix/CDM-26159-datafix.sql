-- CDM-26159 - Monthly Visit Participant
/*
-- Issue Description: 
   User requested to add the child Kendyl Peaks to the contact notes Dated:8/16/2022
   
-- Case ID: 3295487

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
select 	activeflag , effectivedate,intakeservicerequestactorid, participantid , * 
from 	contactparticipant c 
where 	progressnoteid = 'a2895ba5-c1ed-424b-9a42-69a9fe658bea'
		and intakeservicerequestactorid = '7ee3482b-55a7-4b42-a13b-ba161765d03d';

INSERT INTO contactparticipant
(progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES('a2895ba5-c1ed-424b-9a42-69a9fe658bea'::uuid, 'IP', '7ee3482b-55a7-4b42-a13b-ba161765d03d'::uuid, 'Kendyl', 'Peaks', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2022-08-19 15:41:01.163', 'CDM-26159', now(), 'CDM-26159', NOW(), NULL, '7ee3482b-55a7-4b42-a13b-ba161765d03d'::uuid, NULL, NULL);
