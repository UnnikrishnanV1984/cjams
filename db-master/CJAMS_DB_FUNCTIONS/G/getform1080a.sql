DROP FUNCTION IF EXISTS cjams.getform1080a(jsonb);
CREATE OR REPLACE FUNCTION cjams.getform1080a(v_objectids jsonb)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------------------------------------------------
-- 07-01-2025 - Naveenkumar Chemutu - CIDM-10473 1080 Form A-Get all the form 1080A
-- 07-02-2025 - Simar Singh - CIDM-10473 Change function signature to varchar for handling intake
-- 07-11-2025 - Naveenkumar Chemutu - CIDM-10473 Adding logic load all form1080 list including intake related records.
------------------------------------------------------------------------------------------------------

DECLARE
    _form1080alist JSON;
    _objectids TEXT[];
    
BEGIN
        
    IF v_objectids ? 'objectid' THEN
        SELECT array_agg(value::TEXT)
        INTO _objectids
        FROM jsonb_array_elements_text(
        CASE
            WHEN jsonb_typeof(v_objectids -> 'objectid') = 'array'
            THEN v_objectids -> 'objectid'
            ELSE jsonb_build_array(v_objectids -> 'objectid')
        END);
    END IF;    
        
    SELECT json_agg(e) INTO _form1080alist FROM (
        SELECT 
            cast((SELECT concat_ws(' ', firstname, lastname) FROM cjams.person p WHERE p.personid = frm1080a.personid::uuid) as character varying) as person,
            (SELECT displayname FROM cjams.userprofile u WHERE u.securityusersid = frm1080a.updatedby) as updatedbyuser,
            CASE WHEN frm1080a.status = 'Approved' THEN (
                SELECT up.firstname || ' ' || up.lastname
                FROM cjams.userprofile up
                WHERE up.securityusersid = frm1080a.updatedby
                AND up.activeflag = 1 LIMIT 1
            ) ELSE null END as approvedby,
            
            -- Expanded columns from form1080a instead of *
            frm1080a.form1080aid,
            frm1080a.objectid,
            frm1080a.objecttype,
            frm1080a.casenumber,
            frm1080a.ischildfatality,
            frm1080a.isseriousphysicalinjury,
            frm1080a.ismaltreatment,
            frm1080a.justificationforchange,
            frm1080a.dateofthiscfspicriticalincidentreport,
            frm1080a.countyjurisdictionwheretheincidentoccurred,
            frm1080a.datewhentheincidentoccurred,
            frm1080a.dateldssbecameawareofincident,
            frm1080a.jurisdictionwithchildresponsibility,
            frm1080a.intakereferral,
            frm1080a.screen,
            frm1080a.providereason,
            frm1080a.personid,
            frm1080a.cjamspid,
            frm1080a.dob,
            frm1080a.dod,
            frm1080a.sex,
            frm1080a.race,
            frm1080a.enthnicity,
            frm1080a.submitforapproval,
            frm1080a.supervisorcomments,
            frm1080a.status,
            frm1080a.wasthereanyotheropencaseinvolvingthischildatthetimeofincident,
            frm1080a.wasthereacaseinvolvingthischildclosedwithin12monthsofincident,
            frm1080a.wasthechildeverplacedoutsideofhomebeforetheincident,
            frm1080a.didmostrecentoohplacementend12monthsofincident,
            frm1080a.wasthechilddiagnosedwithamentalorphysicaldisability,
            frm1080a.wasthechildbornsubstanceexposed,
            frm1080a.wasthechildrecordupdatedwiththedateofdeathincjams,
            frm1080a.locationtypewhereincidentoccurred,
            frm1080a.specifylocation,
            frm1080a.wasthechildinanoutofhomeplacementatthetimeoftheincident,
            frm1080a.placementprovideratthetimeoftheincident,
            frm1080a.allegedmaltreatername,
            frm1080a.isthisalsothecasehead,
            frm1080a.aliases,
            frm1080a.dob1,
            frm1080a.cjamspid1,
            frm1080a.relationshiptovictim,
            frm1080a.anychildwelfarehistoryinvolvingthisperson,
            frm1080a.narrativesummaryofhistory,
            frm1080a.isthislocationthechildprimaryresidence,
            frm1080a.releventinformation,
            frm1080a.parentname,
            frm1080a.parentrole,
            frm1080a.aliases1,
            frm1080a.dob2,
            frm1080a.cjamspid2,
            frm1080a.relationshiptovictim1,
            frm1080a.anychildwelfarehistoryinvolvingthisperson1,
            frm1080a.narrativesummaryofhistory1,
            frm1080a.didthechildresideprimarilyatthislocation,
            frm1080a.dateldssheldtherapidresponsereview,
            frm1080a.additionalrelevantinformation,
            frm1080a.whatistheextentofanycurrentorpotentialmediainvolvementrelease,
            frm1080a.signatureofpersoncompletingthisreport,
            frm1080a.datecompleted,
            frm1080a.activeflag,
            frm1080a.insertedby,
            frm1080a.insertedon,
            frm1080a.updatedby,
            frm1080a.updatedon,
            frm1080a.copyofform1080a
            
        FROM cjams.form1080a frm1080a
        WHERE 
            frm1080a.objectid = ANY(_objectids) AND frm1080a.activeflag = 1 
        ORDER BY frm1080a.insertedon DESC
    ) e;
    
    RETURN _form1080alist;
    
END;
$function$;