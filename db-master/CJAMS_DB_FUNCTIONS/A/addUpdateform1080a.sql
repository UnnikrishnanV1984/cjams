DROP FUNCTION IF EXISTS cjams.addupdateform1080a(formdata json, v_userid uuid);
CREATE OR REPLACE FUNCTION cjams.addupdateform1080a(formdata json, v_userid uuid)
 RETURNS TABLE(message text, formid uuid)
 LANGUAGE plpgsql
AS $function$
DECLARE
 v_formId uuid;
 v_existingId uuid;
 result TEXT;
BEGIN
 -- Safely extract UUID only if it's valid
 BEGIN
 IF nullif(trim(formData ->> 'form1080aid'), '') IS NOT NULL THEN
 v_formId := (formData ->> 'form1080aid')::uuid;
 END IF;
 EXCEPTION WHEN others THEN
 v_formId := NULL;
 END;

 -- Check if the ID exists in DB
 IF v_formId IS NOT NULL THEN
 SELECT form1080aid INTO v_existingId FROM form1080a WHERE form1080aid = v_formId;
 END IF;

 IF v_existingId IS NULL THEN
 -- Insert into form1080a
 v_formId := gen_random_uuid();

 INSERT INTO form1080a (
 form1080aid, objectid, objecttype,casenumber, ischildfatality, isseriousphysicalinjury,
 ismaltreatment, justificationforchange,
 dateofthiscfspicriticalincidentreport, countyjurisdictionwheretheincidentoccurred,
 datewhentheincidentoccurred, dateldssbecameawareofincident,
 jurisdictionwithchildresponsibility, intakereferral, screen, providereason,
 personid, cjamspid, dob, dod, sex, race, enthnicity,submitforapproval,
supervisorcomments,status,
 wasthereanyotheropencaseinvolvingthischildatthetimeofincident,
 wasthereacaseinvolvingthischildclosedwithin12monthsofincident,
 wasthechildeverplacedoutsideofhomebeforetheincident,
 didmostrecentoohplacementend12monthsofincident,
 wasthechilddiagnosedwithamentalorphysicaldisability,
 wasthechildbornsubstanceexposed, wasthechildrecordupdatedwiththedateofdeathincjams,
 locationtypewhereincidentoccurred, specifylocation,
 wasthechildinanoutofhomeplacementatthetimeoftheincident,
 placementprovideratthetimeoftheincident, narrativesummaryofhistory,
 isthislocationthechildprimaryresidence, releventinformation,
 narrativesummaryofhistory1, didthechildresideprimarilyatthislocation, dateldssheldtherapidresponsereview,
 additionalrelevantinformation,
 whatistheextentofanycurrentorpotentialmediainvolvementrelease,
 signatureofpersoncompletingthisreport, datecompleted,
 activeflag, insertedby, insertedon, updatedby, updatedon,copyofform1080a
 ) VALUES (
 v_formId,
 (formData ->> 'objectid'),
 (formData ->> 'objecttype'),
 (formData ->> 'casenumber'),
 (formData ->> 'ischildfatality')::boolean,
 (formData ->> 'isseriousphysicalinjury')::boolean,
 (formData ->> 'ismaltreatment')::boolean,
 (formData ->> 'justificationforchange'),
 (formData ->> 'dateofthiscfspicriticalincidentreport')::timestamp,
 (formData ->> 'countyjurisdictionwheretheincidentoccurred'),
 (formData ->> 'datewhentheincidentoccurred')::timestamp,
 (formData ->> 'dateldssbecameawareofincident')::timestamp,
 (formData ->> 'jurisdictionwithchildresponsibility'),
 (formData ->> 'intakereferral'),
 (formData ->> 'screen'),
 (formData ->> 'providereason'),
 (formData ->> 'personid')::uuid,
 (formData ->> 'cjamspid'),
 (formData ->> 'dob')::timestamp,
 (formData ->> 'dod')::timestamp,
 (formData ->> 'sex'),
 (formData ->> 'race'),
 (formData ->> 'enthnicity'),
 (formData ->> 'submitforapproval'),
 (formData ->> 'supervisorcomments'),
 (formData ->> 'status'),
 (formData ->> 'wasthereanyotheropencaseinvolvingthischildatthetimeofincident')::boolean,
 (formData ->> 'wasthereacaseinvolvingthischildclosedwithin12monthsofincident')::boolean,
 (formData ->> 'wasthechildeverplacedoutsideofhomebeforetheincident')::boolean,
 (formData ->> 'didmostrecentoohplacementend12monthsofincident')::boolean,
 (formData ->> 'wasthechilddiagnosedwithamentalorphysicaldisability')::boolean,
 (formData ->> 'wasthechildbornsubstanceexposed')::boolean,
 (formData ->> 'wasthechildrecordupdatedwiththedateofdeathincjams')::boolean,
 (formData ->> 'locationtypewhereincidentoccurred'),
 (formData ->> 'specifylocation'),
 (formData ->> 'wasthechildinanoutofhomeplacementatthetimeoftheincident')::boolean,
 (formData ->> 'placementprovideratthetimeoftheincident'),
 (formData ->> 'narrativesummaryofhistory'),
 (formData ->> 'isthislocationthechildprimaryresidence')::boolean,
 (formData ->> 'releventinformation'),
 (formData ->> 'narrativesummaryofhistory1'),
 (formData ->> 'didthechildresideprimarilyatthislocation')::boolean,
 (formData ->> 'dateldssheldtherapidresponsereview')::timestamp,
 (formData ->> 'additionalrelevantinformation'),
 (formData ->> 'whatistheextentofanycurrentorpotentialmediainvolvementrelease'),
 (formData ->> 'signatureofpersoncompletingthisreport'),
 (formData ->> 'datecompleted')::timestamp,
 1, v_userid, now(), v_userid, now(),
(formData ->> 'copyofform1080a')::jsonb  
 );

 ELSE
 -- Update form1080a
 UPDATE form1080a SET
 objectid = (formData ->> 'objectid'),
 objecttype = (formData ->> 'objecttype'),
 casenumber = (formData ->> 'casenumber'),
 ischildfatality = (formData ->> 'ischildfatality')::boolean,
 isseriousphysicalinjury = (formData ->> 'isseriousphysicalinjury')::boolean,
 ismaltreatment = (formData ->> 'ismaltreatment')::boolean,
 justificationforchange = (formData ->> 'justificationforchange'),
 dateofthiscfspicriticalincidentreport = (formData ->> 'dateofthiscfspicriticalincidentreport')::timestamp,
 countyjurisdictionwheretheincidentoccurred = (formData ->> 'countyjurisdictionwheretheincidentoccurred'),
 datewhentheincidentoccurred = (formData ->> 'datewhentheincidentoccurred')::timestamp,
 dateldssbecameawareofincident = (formData ->> 'dateldssbecameawareofincident')::timestamp,
 jurisdictionwithchildresponsibility = (formData ->> 'jurisdictionwithchildresponsibility'),
 intakereferral = (formData ->> 'intakereferral'),
 screen = (formData ->> 'screen'),
 providereason = (formData ->> 'providereason'),
 personid = (formData ->> 'personid')::uuid,
 cjamspid = (formData ->> 'cjamspid'),
 dob = (formData ->> 'dob')::timestamp,
 dod = (formData ->> 'dod')::timestamp,
 sex = (formData ->> 'sex'),
 race = (formData ->> 'race'),
 enthnicity = (formData ->> 'enthnicity'),
 submitforapproval = (formData ->> 'submitforapproval'),
 supervisorcomments = (formData ->> 'supervisorcomments'),
 status = (formData ->> 'status'),
 wasthereanyotheropencaseinvolvingthischildatthetimeofincident = (formData ->> 'wasthereanyotheropencaseinvolvingthischildatthetimeofincident')::boolean,
 wasthereacaseinvolvingthischildclosedwithin12monthsofincident = (formData ->> 'wasthereacaseinvolvingthischildclosedwithin12monthsofincident')::boolean,
 wasthechildeverplacedoutsideofhomebeforetheincident = (formData ->> 'wasthechildeverplacedoutsideofhomebeforetheincident')::boolean,
 didmostrecentoohplacementend12monthsofincident = (formData ->> 'didmostrecentoohplacementend12monthsofincident')::boolean,
 wasthechilddiagnosedwithamentalorphysicaldisability = (formData ->> 'wasthechilddiagnosedwithamentalorphysicaldisability')::boolean,
 wasthechildbornsubstanceexposed = (formData ->> 'wasthechildbornsubstanceexposed')::boolean,
 wasthechildrecordupdatedwiththedateofdeathincjams = (formData ->> 'wasthechildrecordupdatedwiththedateofdeathincjams')::boolean,
 locationtypewhereincidentoccurred = (formData ->> 'locationtypewhereincidentoccurred'),
 specifylocation = (formData ->> 'specifylocation'),
 wasthechildinanoutofhomeplacementatthetimeoftheincident = (formData ->> 'wasthechildinanoutofhomeplacementatthetimeoftheincident')::boolean,
 placementprovideratthetimeoftheincident = (formData ->> 'placementprovideratthetimeoftheincident'),
 narrativesummaryofhistory = (formData ->> 'narrativesummaryofhistory'),
 isthislocationthechildprimaryresidence = (formData ->> 'isthislocationthechildprimaryresidence')::boolean,
 releventinformation = (formData ->> 'releventinformation'),
 narrativesummaryofhistory1 = (formData ->> 'narrativesummaryofhistory1'),
 didthechildresideprimarilyatthislocation = (formData ->> 'didthechildresideprimarilyatthislocation')::boolean,
 dateldssheldtherapidresponsereview = (formData ->> 'dateldssheldtherapidresponsereview')::timestamp,
 additionalrelevantinformation = (formData ->> 'additionalrelevantinformation'),
 whatistheextentofanycurrentorpotentialmediainvolvementrelease = (formData ->> 'whatistheextentofanycurrentorpotentialmediainvolvementrelease'),
 signatureofpersoncompletingthisreport = (formData ->> 'signatureofpersoncompletingthisreport'),
 datecompleted = (formData ->> 'datecompleted')::timestamp,
 updatedby = v_userid,
 updatedon = now()
 WHERE form1080aid = v_formId;
 END IF;

 -- Insert/update logic for normalized tables (using helper functions)
	IF formData -> 'maltreators' IS NOT NULL THEN
	 	PERFORM cjams.handlemaltreators1080forma(formData -> 'maltreators', v_formId, v_userid);
	END IF;
 	IF formData -> 'parents' IS NOT NULL THEN
 		PERFORM cjams.handleparents1080forma(formData -> 'parents', v_formId, v_userid);
	END IF;
 	IF formData -> 'listotherchildren' IS NOT NULL THEN
 		PERFORM cjams.handlelistotherchildren1080forma(formData -> 'listotherchildren', v_formId, v_userid);
 	END IF;
	IF formData -> 'listotherchildrenhousehold' IS NOT NULL THEN
		PERFORM cjams.handlelistotherchildrenhousehold1080forma(formData -> 'listotherchildrenhousehold', v_formId, v_userid);
 	END IF;

 RETURN QUERY
 SELECT 
 CASE 
WHEN ( formdata  ->> 'copyofform1080a') IS NOT NULL THEN 'Form 1080A Copied Successfully'
 WHEN v_existingId IS NULL THEN 'Form 1080A Saved Successfully'
 ELSE 'Form 1080A Updated Successfully'
 END,
 v_formId;
END;
$function$;
