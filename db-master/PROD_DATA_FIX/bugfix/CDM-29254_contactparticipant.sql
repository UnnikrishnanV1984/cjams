/*
   Issue Description: CDM-29254
   Category/ Module  : Contact Notes 
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update progressnote set 
focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"24db5b3d-c1ca-4b19-a844-9745dfcd7585","participantid":"24db5b3d-c1ca-4b19-a844-9745dfcd7585","firstname":"OLIVIA","lastname":"KERILL","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"dc8982df-2d0f-4d2a-8db4-8887c3be52ed","participantid":"dc8982df-2d0f-4d2a-8db4-8887c3be52ed","firstname":"BROOKLYN","lastname":"KERILL","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
updatedon = now(),
updatedby = 'CDM-29254'
where progressnoteid = 'cfb49e00-2601-4a0d-8ca0-5facdd389acd';

INSERT INTO cjams.contactparticipant
(progressnoteid, participanttypekey, intakeservicerequestactorid, firstname, lastname, address1, address2, city, state, zipcode, email, phonenumber, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, participantid, etl_userid, etl_load_date)
VALUES('cfb49e00-2601-4a0d-8ca0-5facdd389acd', 'IP', '24db5b3d-c1ca-4b19-a844-9745dfcd7585', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, now(), '15178b6f-0e39-4a3e-89af-27724ace74e2', now(), 'CDM-29254', now(), NULL, '24db5b3d-c1ca-4b19-a844-9745dfcd7585', NULL, NULL);
