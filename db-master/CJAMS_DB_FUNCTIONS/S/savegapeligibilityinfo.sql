DROP FUNCTION IF EXISTS cjams.savegapeligibilityinfo(inserobj json);
CREATE OR REPLACE FUNCTION cjams.savegapeligibilityinfo(inserobj json)
RETURNS text
LANGUAGE plpgsql
AS $function$

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 09/25/2024 Kapila Mandhadi - Modifications to the relationshipid to get is relative details / updating the relationship value when user updates the dropdown value on both caseworker's and IVE dashboards (CIDM-9176)
-- 02/06/2025 - Veera CIDM-9958 - To deactivate records based on Guardian subsidy id
--01/10/2025 Veera/Sai Teja Chintha - Needed to show details based on Guardian subsidy Id (CIDM-9958)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

DECLARE 
    vs_Procedure        VARCHAR(100) DEFAULT 'savegapeligibilityinfo';	
    v_securityuserid    varchar;

BEGIN	
    v_securityuserid := inserobj ->> 'securityuserid';

UPDATE cjams.gapeligibilityinfo
SET activeflag=0, updatedon = now()
WHERE client_id = (inserobj ->> 'client_id')::bigint and guardian_subsidy_id = (inserobj ->> 'guardian_subsidy_id')::bigint and activeflag = 1;

		
INSERT INTO cjams.gapeligibilityinfo
(client_id, al_removal_id, childname, dateofbirth, gender, personid, childguardianid, childguardianname, childsecguardianid, childsecguardianname, guardianshipagreementsigneddate, secondaryguardianshipagreementsigneddate, dateofcourtorderguardianshipfinalization,
siblinginfo, casenumber, childjurisdiction, createdate, servicecaseid, guardianshipapplicationdate, primaryguardianisrelative, primaryguardianrelationshipid, primaryguardianrelationship, secondaryguardianisrelative, secondguardianrelationshipid, secondguardianrelationship, haapprovaldtjson, dateofhomeapproval,
latestfcplacementstartdatewithperpectiveguardian, fosterhomeapprover, secondguardianexists, successorguardianexists, successorguardianname, successorguardianid, dateofsuccessionaddendum, yesindicatetypeofremoval, nochildisnoteligibleforgap, removalcourtorderdate, removalvpadate, childremovedbyvpa, childremovedbycrt, 
isconsultationchildage, isguardianattach, ischildsecondguardianattach, isreunificationremoved, isadoptionremoved, iscgprovidesafe, secguardlivingwithpriguard, last6monthfiscalpaymentstatus, primaryguardian, primaryguardianhousehold, secondaryguardian, secondaryguardianhousehold, providerapprovalid, isasiblingofachildgappayments, 
isnotasiblingofachildgappayments, siblinginformationgrid, insertedby, insertedon, updatedby, updatedon, activeflag, guardian_subsidy_id)
VALUES((inserobj ->> 'client_id')::bigint, (inserobj ->> 'al_removal_id')::bigint, inserobj ->> 'childname', (inserobj ->> 'dateofbirth')::timestamp, inserobj ->> 'gender', (inserobj ->> 'personid')::uuid, (inserobj ->> 'childguardianid')::int, inserobj ->> 'childguardianname', (inserobj ->> 'childsecguardianid')::int, inserobj ->> 'childsecguardianname', 
(inserobj ->> 'guardianshipagreementsigneddate')::timestamp, (inserobj ->> 'secondaryguardianshipagreementsigneddate')::timestamp, (inserobj ->> 'dateofcourtorderguardianshipfinalization')::timestamp, (inserobj ->> 'siblinginfo')::json, inserobj ->> 'casenumber', inserobj ->> 'childjurisdiction', (inserobj ->> 'createdate')::timestamp, (inserobj ->> 'servicecaseid')::uuid, 
(inserobj ->> 'guardianshipapplicationdate')::timestamp, inserobj ->> 'primaryguardianisrelative', (inserobj ->> 'primaryguardianrelationshipid')::int, inserobj ->> 'primaryguardianrelationship', inserobj ->> 'secondaryguardianisrelative', (inserobj ->> 'secondguardianrelationshipid')::int, inserobj ->> 'secondguardianrelationship', (inserobj ->> 'haapprovaldtjson')::json, 
(inserobj ->> 'dateofhomeapproval')::timestamp, (inserobj ->> 'latestfcplacementstartdatewithperpectiveguardian')::timestamp, inserobj ->> 'fosterhomeapprover', (inserobj ->> 'secondguardianexists')::bool, (inserobj ->> 'successorguardianexists')::bool, inserobj ->> 'successorguardianname', (inserobj ->> 'successorguardianid')::int, (inserobj ->> 'dateofsuccessionaddendum')::timestamp, 
(inserobj ->> 'yesindicatetypeofremoval')::bool, (inserobj ->> 'nochildisnoteligibleforgap')::bool, (inserobj ->> 'removalcourtorderdate')::timestamp, (inserobj ->> 'removalvpadate')::timestamp, (inserobj ->> 'childremovedbyvpa')::bool, (inserobj ->> 'childremovedbycrt')::bool, inserobj ->> 'isconsultationchildage', inserobj ->> 'isguardianattach', inserobj ->> 'ischildsecondguardianattach', 
inserobj ->> 'isreunificationremoved', inserobj ->> 'isadoptionremoved', inserobj ->> 'iscgprovidesafe', inserobj ->> 'secguardlivingwithpriguard', inserobj ->> 'last6monthfiscalpaymentstatus', (inserobj ->> 'primaryguardian')::json, (inserobj ->> 'primaryguardianhousehold')::json, (inserobj ->> 'secondaryguardian')::json, (inserobj ->> 'secondaryguardianhousehold')::json, 
(inserobj ->> 'providerapprovalid')::int, (inserobj ->> 'isasiblingofachildgappayments')::bool, (inserobj ->> 'isnotasiblingofachildgappayments')::bool, (inserobj ->> 'siblinginformationgrid')::json, v_securityuserid, now(), v_securityuserid, now(), 1,(inserobj ->> 'guardian_subsidy_id')::int);

UPDATE cjams.guardianship set primaryrelationshipkey = inserobj ->> 'primaryguardianrelationship', secondaryrelationshipkey = inserobj ->> 'secondguardianrelationship', updatedby= v_securityuserid, updatedon=now() where servicecaseid = (inserobj ->> 'servicecaseid')::uuid;

return 'success';
end $function$
;