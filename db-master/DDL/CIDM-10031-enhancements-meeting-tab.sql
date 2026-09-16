/*
 Issue Description: CIDM-10031
-- Category/ Module: Enhancement 
-- Root cause: NA
-- Fix Provided: adding new values to the requested dropdowns           
*/


-- select * from meetingtype m ;

DELETE FROM cjams.meetingtype WHERE meetingtypekey IN ('QRTP', 'YTPM', 'FFM');

INSERT INTO cjams.meetingtype
(meetingtypeid, meetingtypekey, typedescription, displayorder, activeflag, insertedon, updatedby, updatedon)
VALUES(cjams.gen_random_uuid(), 'QRTP', 'Qualified Residential Treatment Program (QRTP)', 9, 1, now(), 'CIDM-10031', now() );

INSERT INTO cjams.meetingtype
(meetingtypeid, meetingtypekey, typedescription, displayorder, activeflag, insertedon, updatedby, updatedon)
VALUES(cjams.gen_random_uuid(), 'YTPM', 'Youth Transition Planning Meeting (YTP)', 10, 1, now(), 'CIDM-10031', now() );

INSERT INTO cjams.meetingtype
(meetingtypeid, meetingtypekey, typedescription, displayorder, activeflag, insertedon, updatedby, updatedon)
VALUES(cjams.gen_random_uuid(), 'FFM', 'Facilitated Family Meeting (FFM)', 11, 1, now(), 'CIDM-10031', now() );


--We will handle filtering this on UI and still keep these for historical records
/*
update familymeetingtype 
set activeflag = 0, updatedby = 'CIDM-10031', updatedon = now() 
where familymeetingtypekey in ('Case Planning FIM', 'Change in Permanency Plan FIM', 'Change in Placement FIM', 'Removal FIM');
*/

DELETE FROM cjams.familymeetingtype WHERE familymeetingtypekey IN ( 'SOCSCF', 'PSF', 'PPF', 'VPAF');

INSERT INTO cjams.familymeetingtype
(familymeetingtypeid, familymeetingtypekey, typedescription, displayorder, activeflag, insertedon, updatedby, updatedon)
VALUES(cjams.gen_random_uuid(), 'SOCSCF', 
'Separation or Considered Separation of Child(ren)', 7, 1, now(), 'CIDM-10031', now());

INSERT INTO cjams.familymeetingtype
(familymeetingtypeid, familymeetingtypekey, typedescription, displayorder, activeflag, insertedon, updatedby, updatedon)
VALUES(cjams.gen_random_uuid(), 'PSF', 'Placement Stability', 8, 1, now(), 'CIDM-10031', now());

INSERT INTO cjams.familymeetingtype
(familymeetingtypeid, familymeetingtypekey, typedescription, displayorder, activeflag, insertedon, updatedby, updatedon)
VALUES(cjams.gen_random_uuid(), 'PPF', 'Permanency Planning', 9, 1, now(), 'CIDM-10031', now());

INSERT INTO cjams.familymeetingtype
(familymeetingtypeid, familymeetingtypekey, typedescription, displayorder, activeflag, insertedon, updatedby, updatedon)
VALUES(cjams.gen_random_uuid(), 'VPAF', 'Voluntary Placement Agreement', 10, 1, now(), 'CIDM-10031', now());