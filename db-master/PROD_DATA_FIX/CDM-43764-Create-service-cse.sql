/*
   Issue Description: CDM-43764
   Category/ Module  : Create Service case for Intake.
   Root cause: User requested to create a service case linked to existing intake request.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from cjams.createservicecase
('9fd603f6-14c7-4bd5-b761-c488ba375061', null, 1, 'b2a9bdd3-f60a-436c-91a5-adc3fdcd4d35','intake');


INSERT INTO cjams.caseassignment
(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate)
VALUES('b2a9bdd3-f60a-436c-91a5-adc3fdcd4d35', '4a289f1e-4a4d-439e-9388-27d233418800', 'b2a9bdd3-f60a-436c-91a5-adc3fdcd4d35', 'b2a9bdd3-f60a-436c-91a5-adc3fdcd4d35', now(), now(), 'servicecase', (select servicecaseid from intakeservicerequest where intakeserviceid='9fd603f6-14c7-4bd5-b761-c488ba375061'), 'family', 1, now(), NULL, '47eeefb4-c221-43ce-aee3-e7d958dc5dfb', '47eeefb4-c221-43ce-aee3-e7d958dc5dfb', NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c', '7665ca54-5374-4174-be07-a687b811a82c', 'W', NULL, now());