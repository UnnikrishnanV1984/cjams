/* 
    Issue Description: CDM-40958
    Category/ Module: CPS Case / Service Case
    Root cause: During case connection, a new service case # 241030380204 was created in error instead of reopening service case # 327164 
                The user is requesting to remove it, so they can redo and connect CPS IR # 241022731266 with service case # 3271644.
                SSA supervisor approval has been recieved to complete this data fix.
    Fix Provided: Data fix to deactivate the service case # 241030380204 and remove connection with CPS IR # 241022731266.
    Pull request# for code fix: N/A
    Reason why no related code fix: = As per system design there is not ability to unconnect and redo case connect.
                So, this is rare case user error scenario that needs SSA approval and will be handled with data fix.
*/

--6f44cd10-6d03-4a56-9f04-ed98c039f531 -- servicecaseid
-- SELECT activeflag, servicecaseid, * FROM cjams.servicecase s 
-- WHERE servicecasenumber = '241030380204';

-- cece04e0-c7ac-4d4b-bcdc-914dce79a1ab -- intakeserviceid
-- SELECT intakeserviceid, * FROM cjams.intakeservicerequest i 
-- WHERE servicerequestnumber = '241022731266' AND
-- servicecaseid = '6f44cd10-6d03-4a56-9f04-ed98c039f531';

-- SELECT * FROM cjams.servicecasedisposition 
-- WHERE servicecaseid = '6f44cd10-6d03-4a56-9f04-ed98c039f531';

-- SELECT * FROM cjams.caseassignment
-- WHERE objectid = '6f44cd10-6d03-4a56-9f04-ed98c039f531' AND activeflag = 1;

-- SELECT * FROM cjams.routing
-- WHERE objectid = '6f44cd10-6d03-4a56-9f04-ed98c039f531' and activeflag = 1;

----****----

--Updating servicecase
UPDATE cjams.servicecase 
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-40958'
WHERE servicecaseid = '6f44cd10-6d03-4a56-9f04-ed98c039f531'
AND servicecasenumber = '241030380204';

--Removing the link from service case to cps case
UPDATE cjams.intakeservicerequest
SET servicecaseid = NULL, updatedon = now(), updatedby = 'CDM-40958'
WHERE intakeserviceid = 'cece04e0-c7ac-4d4b-bcdc-914dce79a1ab'
AND servicerequestnumber = '241022731266';

--Updating servicecasedisposition
UPDATE cjams.servicecasedisposition
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-40958'
WHERE servicecaseid = '6f44cd10-6d03-4a56-9f04-ed98c039f531';

--Updating caseassignment
UPDATE cjams.caseassignment
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-40958'
WHERE objectid = '6f44cd10-6d03-4a56-9f04-ed98c039f531' AND activeflag = 1;

--Updating routing
UPDATE cjams.routing
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-40958'
WHERE objectid = '6f44cd10-6d03-4a56-9f04-ed98c039f531' and activeflag = 1;