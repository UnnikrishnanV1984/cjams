DROP FUNCTION IF EXISTS cjams.getform1080adetails(p_form1080aid uuid);
CREATE OR REPLACE FUNCTION cjams.getform1080adetails(p_form1080aid uuid)
 RETURNS json
 LANGUAGE sql
AS $function$
WITH form_with_person_name AS (
    SELECT
        f.form1080aid,
        f.objectid,
        f.objecttype,
        f.casenumber,
        f.ischildfatality,
        f.isseriousphysicalinjury,
        f.ismaltreatment,
        f.justificationforchange,
        f.dateofthiscfspicriticalincidentreport,
        f.countyjurisdictionwheretheincidentoccurred,
        f.datewhentheincidentoccurred,
        f.dateldssbecameawareofincident,
        f.jurisdictionwithchildresponsibility,
        f.intakereferral,
        f.screen,
        f.providereason,
        f.personid,
        f.cjamspid,
        f.dob,
        f.dod,
        f.sex,
        f.race,
        f.enthnicity,
        f.submitforapproval,
        f.supervisorcomments,
        f.status,
        f.wasthereanyotheropencaseinvolvingthischildatthetimeofincident,
        f.wasthereacaseinvolvingthischildclosedwithin12monthsofincident,
        f.wasthechildeverplacedoutsideofhomebeforetheincident,
        f.didmostrecentoohplacementend12monthsofincident,
        f.wasthechilddiagnosedwithamentalorphysicaldisability,
        f.wasthechildbornsubstanceexposed,
        f.wasthechildrecordupdatedwiththedateofdeathincjams,
        f.locationtypewhereincidentoccurred,
        f.specifylocation,
        f.wasthechildinanoutofhomeplacementatthetimeoftheincident,
        f.placementprovideratthetimeoftheincident,
        f.allegedmaltreatername,
        f.isthisalsothecasehead,
        f.aliases,
        f.dob1,
        f.cjamspid1,
        f.relationshiptovictim,
        f.anychildwelfarehistoryinvolvingthisperson,
        f.narrativesummaryofhistory,
        f.isthislocationthechildprimaryresidence,
        f.releventinformation,
        f.parentname,
        f.parentrole,
        f.aliases1,
        f.dob2,
        f.cjamspid2,
        f.relationshiptovictim1,
        f.anychildwelfarehistoryinvolvingthisperson1,
        f.narrativesummaryofhistory1,
        f.didthechildresideprimarilyatthislocation,
        f.dateldssheldtherapidresponsereview,
        f.additionalrelevantinformation,
        f.whatistheextentofanycurrentorpotentialmediainvolvementrelease,
        f.signatureofpersoncompletingthisreport,
        f.datecompleted,
        f.activeflag,
        f.insertedby,
        f.insertedon,
        f.updatedby,
        f.updatedon,
        (SELECT concat_ws(' ', p.firstname, p.lastname)
         FROM cjams.person p
         WHERE p.personid = f.personid::uuid) AS childsname,
         (select  countyname from county c where c.countyid::uuid = f.jurisdictionwithchildresponsibility::uuid and activeflag = 1 limit 1) as jurisdictionwithchildresponsibilityname,
          (SELECT 
    CONCAT(
        CASE
            WHEN (element->>'placementtypekey') = 'LA' THEN 
                COALESCE(element->>'livingarrangementtype', 'Default Value')  -- Handle NULL for livingarrangementtype
            ELSE 
                COALESCE(element->'providerdetails'->>'providername', 'Default Provider')  -- Handle NULL for providername
        END,
        ' - ',
        TO_CHAR(TO_TIMESTAMP(element->>'startdate', 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY'),  -- Format startdate (ISO 8601 to MM/DD/YYYY)
        CASE
            WHEN element->>'enddate' <> '' THEN 
                CONCAT(' to ', TO_CHAR(TO_TIMESTAMP(element->>'enddate', 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY'))  -- Format enddate (ISO 8601 to MM/DD/YYYY)
            ELSE 
                ''  -- If enddate is empty, add nothing
        END
    ) AS placementprovideratthetimeoftheincidentname
FROM (
    SELECT jsonb_array_elements(getplacementbyperson(f.personid::uuid)::jsonb) AS element
) AS subquery
WHERE element->>'placementid' = f.placementprovideratthetimeoftheincident) as placementprovideratthetimeoftheincidentname
    FROM cjams.form1080a f
    WHERE f.form1080aid = p_form1080aid
)
SELECT
    to_jsonb(f_with_name) || 
   	jsonb_build_object(
        'maltreators', (
            SELECT COALESCE(jsonb_agg(
                jsonb_build_object(
                    'parentmaltreatorform1080aid', pm.parentmaltreatorform1080aid,
                    'ismaltreator', pm.ismaltreator,
                    'isparent', pm.isparent,
                    'activeflag', pm.activeflag,
                    'fullname', pm.fullname,
                    'personid', pm.personid,
                    'cjamspid', pm.cjamspid,
                    'aliases', pm.aliases,
                    'dob', pm.dob,
                    'relationshiptovictim', pm.relationshiptovictim,
                    'anychildwelfarehistoryinvolvingthisperson', pm.anychildwelfarehistoryinvolvingthisperson,
                    'iscasehead', pm.iscasehead,
                    'isallegedmaltreator', pm.isallegedmaltreator,
                    'isthisalsothecasehead', pm.isthisalsothecasehead,
                    'processedDaDetails', (
                        SELECT COALESCE(jsonb_agg(
                            jsonb_build_object(
                                'maltreatorsclearancehistory1080formaid' , pch.maltreatorsclearancehistory1080formaid,
                                'personid' , pch.personid,
                                'casenumber' , pch.casenumber,
                                'intakedate' , TO_CHAR(pch.intakedate,'MM/DD/YYYY'),
                                'programarea' , pch.programarea,
                                'subprogramarea' , pch.subprogramarea,
                                'role' , pch.personrole,
                                'activeflag' , pch.activeflag,
                                'insertedby' , pch.insertedby,
                                'insertedon' , pch.insertedon,
                                'updatedby' , pch.updatedby,
                                'updatedon' , pch.updatedon,
                                'form1080aid', pch.form1080aid
                            )
                        ), '[]'::jsonb)
                        FROM (
                            SELECT pch.maltreatorsclearancehistory1080formaid, pch.form1080aid, pch.personid, pch.casenumber, pch.intakedate,pch.programarea,pch.subprogramarea, pch.personrole,pch.persontype, pch.activeflag, pch.insertedby,pch.insertedon, pch.updatedby,pch.updatedon
                            FROM cjams.listmaltreatorsclearancehistory1080forma pch
                            WHERE pch.form1080aid = pm.form1080aid AND pch.personid = pm.personid AND pch.activeflag = 1
                            AND pch.persontype = 'maltreators'
                            ORDER BY pch.personid, pch.updatedon DESC
                        ) AS pch
                    ),
                    'form1080aid', pm.form1080aid
                )
            ), '[]'::jsonb)
            FROM (
			    SELECT DISTINCT ON (pm.personid) pm.*
			    FROM cjams.parentmaltreator1080forma pm
			    WHERE pm.form1080aid = f_with_name.form1080aid AND pm.isMaltreator = 1 AND pm.activeflag = 1
			    ORDER BY pm.personid, pm.updatedon DESC
			) AS pm
        ),
        'parents', (
            SELECT COALESCE(jsonb_agg(
                jsonb_build_object(
                    'parentmaltreatorform1080aid', pm.parentmaltreatorform1080aid,
                    'ismaltreator', pm.ismaltreator,
                    'isparent', pm.isparent,
                    'activeflag', pm.activeflag,
                    'fullname', pm.fullname,
                    'personid', pm.personid,
                    'cjamspid', pm.cjamspid,
                    'aliases', pm.aliases,
                    'dob', pm.dob,
                    'relationshiptovictim', pm.relationshiptovictim,
                    'anychildwelfarehistoryinvolvingthisperson', pm.anychildwelfarehistoryinvolvingthisperson,
                    'iscasehead', pm.iscasehead,
                    'isthisalsothecasehead', pm.isthisalsothecasehead,
                    'isallegedmaltreator', pm.isallegedmaltreator,
                    'processedDaDetails', (
                        SELECT COALESCE(jsonb_agg(
                            jsonb_build_object(
                                'maltreatorsclearancehistory1080formaid' , pch.maltreatorsclearancehistory1080formaid,
                                'personid' , pch.personid,
                                'casenumber' , pch.casenumber,
                                'intakedate' , TO_CHAR(pch.intakedate,'MM/DD/YYYY'),
                                'programarea' , pch.programarea,
                                'subprogramarea' , pch.subprogramarea,
                                'role' , pch.personrole,
                                'activeflag' , pch.activeflag,
                                'insertedby' , pch.insertedby,
                                'insertedon' , pch.insertedon,
                                'updatedby' , pch.updatedby,
                                'updatedon' , pch.updatedon,
                                'form1080aid', pch.form1080aid
                            )
                        ), '[]'::jsonb)
                        FROM (
                            SELECT pch.maltreatorsclearancehistory1080formaid, pch.form1080aid, pch.personid, pch.casenumber, pch.intakedate,pch.programarea,pch.subprogramarea, pch.personrole,pch.persontype, pch.activeflag, pch.insertedby,pch.insertedon, pch.updatedby,pch.updatedon
                            FROM cjams.listmaltreatorsclearancehistory1080forma pch
                            WHERE pch.form1080aid = pm.form1080aid AND pch.personid = pm.personid AND pch.activeflag = 1
                            AND pch.persontype = 'parents'
                            ORDER BY pch.personid, pch.updatedon DESC
                        ) AS pch
                    ),
                    'form1080aid', pm.form1080aid
                )
            ), '[]'::jsonb)
            FROM (
			    SELECT DISTINCT ON (pm.personid) pm.*
			    FROM cjams.parentmaltreator1080forma pm
			    WHERE pm.form1080aid = f_with_name.form1080aid AND pm.isParent = 1 AND pm.activeflag = 1
			    ORDER BY pm.personid, pm.updatedon DESC
			) AS pm
        ),
        'otherChildren', (
            SELECT COALESCE(jsonb_agg(
                jsonb_build_object(
                    'otherchildrenform1080aid', loc.otherchildrenform1080aid,
                    'activeflag', loc.activeflag,
                    'cjamspid', loc.cjamspid,
                    'form1080aid', loc.form1080aid,
                    'fullname', loc.fullname,
                    'personid', loc.personid,
                    'dob' , TO_CHAR(loc.dob,'MM/DD/YYYY'),
                    'relationshiptovictim', 
                            COALESCE(
                                (
                                   SELECT elem->>'relation' as relationshiptovictim
                                    FROM json_array_elements(
                                        getallpersonrelationbyprovidedpersonid(
                                            f_with_name.objectid, 
                                            f_with_name.personid::character varying
                                        ) 
                                    ) AS elem
                                    WHERE elem->>'person2id'::character varying = loc.personid::character varying  -- Access the `person2id` field in the JSON object
             
                                ), 
                                NULL  
                            )
                )
            ), '[]'::jsonb)
            FROM cjams.listotherchildren1080forma loc
            WHERE loc.form1080aid = f_with_name.form1080aid AND loc.activeflag = 1
        ),
        'otherChildrenHouseHold', (
            SELECT COALESCE(jsonb_agg(
                jsonb_build_object(
                    'otherchildrenhouseholdform1080aid', loch.otherchildrenhouseholdform1080aid,
                    'activeflag', loch.activeflag,
                    'cjamspid', loch.cjamspid,
                    'form1080aid', loch.form1080aid,
                    'fullname', loch.fullname,
                    'personid', loch.personid,
                    'dob' , TO_CHAR(loch.dob,'MM/DD/YYYY'),
                    'relationshiptovictim', 
                            COALESCE(
                                (
                                   SELECT elem->>'relation' as relationshiptovictim
                                    FROM json_array_elements(
                                        getallpersonrelationbyprovidedpersonid(
                                            f_with_name.objectid, 
                                            f_with_name.personid::character varying 
                                        ) 
                                    ) AS elem
                                    WHERE elem->>'person2id'::character varying = loch.personid::character varying  -- Access the `person2id` field in the JSON object
             
                                ), 
                                NULL  
                            )
                )
            ), '[]'::jsonb)
            FROM cjams.listotherchildrenhousehold1080forma loch
            WHERE loch.form1080aid = f_with_name.form1080aid AND loch.activeflag = 1
        )
    )
FROM
    form_with_person_name f_with_name;
$function$
;
