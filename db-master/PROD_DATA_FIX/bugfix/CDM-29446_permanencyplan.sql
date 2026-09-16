/*
- Category/ Module: Permanency Plan
-- Root cause: Data fix for update the intakeservicerequestactorid as its missing from ui.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- UPDATE cjams.routing
-- SET activeflag=0, updatedon=now(), updatedby='CDM-29446'
-- WHERE routingid='3b32170b-4d43-4fb6-94b8-54720a7f478a' and eventcode='PPLR';

UPDATE cjams.permanencyplan
SET updatedon=now(), updatedby='CDM-29446', intakeservicerequestactorid='608a875e-ee68-41b1-abe8-561c056e8575'
WHERE permanencyplanid='236677b4-387c-46ec-af47-eb3912e83e4e' and servicecaseid='dd4aa729-5051-416d-b7bd-d2d1e23247db';

UPDATE cjams.permanencyplan
SET updatedon=now(), updatedby='CDM-29446', intakeservicerequestactorid='402f39f4-9e61-4804-a538-7faa120e51aa'
WHERE permanencyplanid='5f631490-76bf-40b5-8b8c-d9920410b212' and servicecaseid='dd4aa729-5051-416d-b7bd-d2d1e23247db';


