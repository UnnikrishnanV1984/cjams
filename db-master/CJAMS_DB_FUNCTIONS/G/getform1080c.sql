DROP FUNCTION if exists getform1080c(jsonb);
CREATE OR REPLACE FUNCTION cjams.getform1080c(v_objectids jsonb)
 RETURNS TABLE(form1080cid uuid, objectid character varying, objecttype character varying, casenumber character varying, doesmaltreatmentappeartohavebeenacontributingfactor character varying, ifincidentoccurredinlicensedsettingindicateactiontaken character varying, specify character varying, legaloutcomeinthisincident character varying, wasthisincidentrelatedtosleeporanunsafesleepenvironment character varying, inthe72hoursbeforethefatalincidentwasthechildinjured character varying,personid uuid, person character varying, physicalabuse character varying, physicalabuseradio character varying, sexualabuse character varying, sexualabuseradio character varying, neglect character varying, neglectradio character varying, mentalinjuryabuse character varying, mentalinjuryabuseradio character varying, mentalinjuryneglect character varying, mentalinjuryneglectradio character varying, summaryoffactsandfindingincludingtheeventdateinthecase character varying, theallegedlymaltreatedchild character varying, siblingsoftheallegedlymaltreatedchild character varying, otherchildinhouseholdfamilyorincaseofallegedmaltreater character varying, substanceusechild character varying, substanceusefamily character varying, substanceusecaregiver character varying, mentalillnesschild character varying, mentalillnessfamily character varying, mentalillnesscaregiver character varying, domesticviolencechild character varying, domesticviolencefamily character varying, domesticviolencecaregiver character varying, prenatalexposurechild character varying, prenatalexposurefamily character varying, prenatalexposurecaregiver character varying, noprenatalcarechild character varying, noprenatalcarefamily character varying, noprenatalcarecaregiver character varying, childfatalitychild character varying, childfatalityfamily character varying, childfatalitycaregiver character varying, medicalconditionchild character varying, medicalconditionfamily character varying, medicalconditioncaregiver character varying, healthinsurancechild character varying, healthinsurancefamily character varying, healthinsurancecaregiver character varying, otherchild character varying, otherfamily character varying, othercaregiver character varying, otherriskfactors jsonb, describehowtheselectedriskfactorsfromchartaboveinfluencedtheinc character varying, signatureofpersoncompletingthisreport character varying, personcompletingthisreport character varying, supervisor character varying, phonenumber character varying, supervisorphonenumber character varying, email character varying, supervisoremail character varying, datecompleted timestamp with time zone, activeflag integer, insertedby character varying, insertedon timestamp without time zone, submitforapproval character varying, supervisorcomments character varying, status character varying, updatedby character varying,updatedbyuser character varying, updatedon timestamp without time zone, approvedby character varying)
 LANGUAGE plpgsql
AS $function$
---------------------------------------------------------------------------------------------------
-- 06-19-2025 - Anil Kumar Dharni - CIDM-10473 1080 Form C-Get all the form 1080c
-- 07-01-2025 - Simar Singh - CIDM-10473 Change function signature to varchar for handling intake
-- 07-11-2025 - Naveenkumar Chemutu - CIDM-10473 Adding logic load all form1080 list including intake related records. 
-- 07-23-2025 - Simar Singh - CIDM-10473 Support for other risk factors
---------------------------------------------------------------------------------------------------
DECLARE
    _form1080blist JSON;
     _objectids TEXT[];
   
begin
	
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

    RETURN QUERY
    SELECT 
        f.form1080cid,
        f.objectid,
        f.objecttype,
        f.casenumber,
        f.doesmaltreatmentappeartohavebeenacontributingfactor,
        f.ifincidentoccurredinlicensedsettingindicateactiontaken,
        f.specify,
        f.legaloutcomeinthisincident,
        f.wasthisincidentrelatedtosleeporanunsafesleepenvironment,
        f.inthe72hoursbeforethefatalincidentwasthechildinjured,
        f.personid,
        cast((select concat_ws(' ', firstname, lastname) FROM person p WHERE p.personid = f.personid) as character varying) as person,
        f.physicalabuse,
        f.physicalabuseradio,
        f.sexualabuse,
        f.sexualabuseradio,
        f.neglect,
        f.neglectradio,
        f.mentalinjuryabuse,
        f.mentalinjuryabuseradio,
        f.mentalinjuryneglect,
        f.mentalinjuryneglectradio,
        f.summaryoffactsandfindingincludingtheeventdateinthecase,
        f.theallegedlymaltreatedchild,
        f.siblingsoftheallegedlymaltreatedchild,
        f.otherchildinhouseholdfamilyorincaseofallegedmaltreater,
        f.substanceusechild,
        f.substanceusefamily,
        f.substanceusecaregiver,
        f.mentalillnesschild,
        f.mentalillnessfamily,
        f.mentalillnesscaregiver,
        f.domesticviolencechild,
        f.domesticviolencefamily,
        f.domesticviolencecaregiver,
        f.prenatalexposurechild,
        f.prenatalexposurefamily,
        f.prenatalexposurecaregiver,
        f.noprenatalcarechild,
        f.noprenatalcarefamily,
        f.noprenatalcarecaregiver,
        f.childfatalitychild,
        f.childfatalityfamily,
        f.childfatalitycaregiver,
        f.medicalconditionchild,
        f.medicalconditionfamily,
        f.medicalconditioncaregiver,
        f.healthinsurancechild,
        f.healthinsurancefamily,
        f.healthinsurancecaregiver,
        f.otherchild,
        f.otherfamily,
        f.othercaregiver,
        f.otherriskfactors,
        f.describehowtheselectedriskfactorsfromchartaboveinfluencedtheinc,
        f.signatureofpersoncompletingthisreport,
        f.personcompletingthisreport,
        f.supervisor,
        f.phonenumber,
        f.supervisorphonenumber,
        f.email,
        f.supervisoremail,
        f.datecompleted,
        f.activeflag,
        f.insertedby,
        f.insertedon,
        f.submitforapproval,
		f.supervisorcomments,
		f.status,
        COALESCE(up.fullname, f.updatedby) as updatedby,
        (select displayname from userprofile u where u.securityusersid = f.updatedby) as updatedbyuser,
        f.updatedon,
        case when f.status = 'Approved' then up.fullname else null end as approvedby
    FROM cjams.form1080c f
    LEFT JOIN userprofile up ON f.updatedby = up.securityusersid::character varying
    WHERE f.objectid =  ANY(_objectids) 
      AND f.activeflag = 1
    ORDER BY f.insertedon DESC;
END;
$function$
;
