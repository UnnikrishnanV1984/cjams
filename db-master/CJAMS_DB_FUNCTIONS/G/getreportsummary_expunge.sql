DROP FUNCTION IF EXISTS cjams.getreportsummary_expunge(character varying);
CREATE OR REPLACE FUNCTION cjams.getreportsummary_expunge(v_intakeserviceid character varying)
 RETURNS TABLE(intakeserviceid uuid, countyid uuid, servicerequestnumber character varying, narrative text,description character varying,
 reporteddate timestamp,reportedtime timestamp, reporterfirstname character varying,reporterlastname character varying , requesterphone character varying,
 insertedon timestamp, insertedby character varying,suspiciousdeath boolean,missingpersons boolean, intakeservreqtypeid uuid, intakeservicerequestclassid uuid,
 servicerequestincidenttypekey character varying,intakeservreqinputtypeid uuid,monumber character varying,intakeservreqinputsourceid uuid,isanonymousreporter boolean,
 isunknownreporter boolean,intakeservreqpurposeid uuid,reportermiddlename character varying,reporterphonenumber character varying,reporterroletypekey character varying,
 reporterzipcode character varying,reporteremail character varying,reporterincidentlocation character varying,reporterisapproximate boolean,reporterorganization character varying,
 reportertitle character varying,reporterincidentdate timestamp,reporterisAnonymousReporter boolean,reporterisUnknownReporter boolean,reporternarrative character varying,
 reporterrefuseToShareZip character varying,reporterisacknowledgementletter integer,reporteraddress1 character varying,reporteraddress2 character varying,reportercity character varying,
 reporterstate character varying,offenselocation character varying,reporterphonenumberext character varying,intakenumber character varying,intakeservicerequesttype json,
 county json,servicerequestsubtype json,servicerequestincidenttype json,intakeservicerequestinputtype json,intakeservicerequestinputsource json,intakeservicerequestpurpose json,
 userprofile json,intakeservicerequestillegalactivity json,intakeservicerequestactor json,supervisorname character varying, jsondata jsonb)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 12/05/2025 Manasa Kasula - CIDM-10890: Expungement changes
------------------------------------------------------------------------------------------------------------
DECLARE	
BEGIN

   Return Query 
   select 
    isr.intakeserviceid,
    isr.countyid,
    isr.servicerequestnumber, 
    isr.narrative,
    isr.description,
    isr.reporteddate,
    isr.reportedtime, 
    isr.reporterfirstname, 
    isr.reporterlastname, 
    isr.requesterphone, 
    isr.insertedon,
    isr.insertedby,
    isr.suspiciousdeath,
    isr.missingpersons,
    isr.intakeservreqtypeid,
    isr.intakeservicerequestclassid,
    isr.servicerequestincidenttypekey,
    isr.intakeservreqinputtypeid,
    isr.monumber,
    isr.intakeservreqinputsourceid,
    isr.isanonymousreporter,
    isr.isunknownreporter,
    isr.intakeservreqpurposeid,
    isr.reportermiddlename,
    isr.reporterphonenumber,
    isr.reporterroletypekey,
    isr.reporterzipcode,
    isr.reporteremail,
    isr.reporterincidentlocation::character varying,
    isr.reporterisapproximate,
    isr.reporterorganization,
    isr.reportertitle,
    isr.reporterincidentdate,
    isr.reporterisAnonymousReporter,
    isr.reporterisUnknownReporter,
    isr.reporternarrative::character varying,
    isr.reporterrefuseToShareZip,
    isr.reporterisacknowledgementletter,
    isr.reporteraddress1,
    isr.reporteraddress2,
    isr.reportercity,
    isr.reporterstate,
    isr.offenselocation,
    isr.reporterphonenumberext,
    isr.intakenumber,
    (SELECT json_build_object(
            'intakeservreqtypeid', isrt.intakeservreqtypeid,
            'description',	isrt.description) intakeservicerequesttype 
            from intakeservicerequesttype isrt 
            where isrt.intakeservreqtypeid = isr.intakeservreqtypeid and isrt.activeflag = 1),
    (SELECT json_build_object(
            'countyid', c.countyid,
            'countyname', c.countyname,
            'statecountycode',c.statecountycode) county 
            from county c 
            where c.countyid = isr.countyid and c.activeflag = 1),
 (SELECT json_build_object(
           'servicerequestsubtypeid', srst.servicerequestsubtypeid,
           'classkey', srst.classkey,
           'description',srst.description) servicerequestsubtype 
           from servicerequestsubtype srst
           where srst.intakeservreqtypeid = isr.intakeservreqtypeid and 
           srst.servicerequestsubtypeid = isr.intakeservicerequestclassid and srst.activeflag = 1),
    (SELECT json_build_object(
            'servicerequestincidenttypekey', srit.servicerequestincidenttypekey,
            'typedescription', srit.typedescription) servicerequestincidenttype 
            from servicerequestincidenttype srit
            where srit.servicerequestincidenttypekey = isr.servicerequestincidenttypekey and srit.activeflag = 1),
    (SELECT json_build_object(
            'intakeservreqinputtypeid', isrit.intakeservreqinputtypeid,
            'intakeservreqinputtypekey', isrit.intakeservreqinputtypekey,
            'description', isrit.description) intakeservicerequestinputtype 
            from intakeservicerequestinputtype isrit
            where isrit.intakeservreqinputtypeid = isr.intakeservreqinputtypeid and isrit.activeflag = 1),
     (SELECT json_build_object(
            'intakeservreqinputsourceid', isris.intakeservreqinputsourceid,
            'intakeservreqinputsourcekey', isris.intakeservreqinputsourcekey,
            'description', isris.description) intakeservicerequestinputsource 
            from intakeservicerequestinputsource isris
            where isris.intakeservreqinputsourceid = isr.intakeservreqinputsourceid and isris.activeflag = 1),
    (SELECT json_build_object(
            'intakeservreqpurposeid', isrp.intakeservreqpurposeid,
            'intakeservreqpurposekey', isrp.intakeservreqpurposekey,
            'description', isrp.description) intakeservicerequestpurpose 
            from intakeservicerequestpurpose isrp
            where isrp.intakeservreqpurposeid = isr.intakeservreqpurposeid and isrp.activeflag = 1),
    (SELECT json_build_object(
            'securityuserid', up.securityusersid,
            'firstname', up.firstname,
            'lastname', up.lastname,
            'displayname',up.displayname,
            'fullname',up.fullname
            ) userprofile 
            from userprofile up
            where up.securityusersid::varchar = isr.insertedby and up.activeflag = 1),
    (SELECT json_build_object(
            'intakeservicerequestillegalactivityid', isria.intakeservicerequestillegalactivityid,
            'intakeservicerequestillegalactivitytypekey', isria.intakeservicerequestillegalactivitytypekey,
            'intakeservicerequestid', isria.intakeservicerequestid,
            'activeflag',isria.activeflag
            ) intakeservicerequestillegalactivity 
            from intakeservicerequestillegalactivity isria
            where isria.intakeservicerequestid = isr.intakeserviceid and isria.activeflag = 1),
    (SELECT json_agg(json_build_object(
            'intakeservicerequestactorid', isra.intakeservicerequestactorid,
            'actorid', isra.actorid,
            'intakeservicerequestpersontypekey', isra.intakeservicerequestpersontypekey,
            'rapersontypekey',isra.rapersontypekey,
            'intakeserviceid',isra.intakeserviceid,
            'isheadofhousehold',isra.isheadofhousehold,
            'actor', (SELECT json_build_object(
                'actorid', aexpunge.actorid,
                'activeflag', aexpunge.activeflag,
                'personid', aexpunge.personid,
                'actortype',aexpunge.actortype,
                'Person', (SELECT json_build_object(
                    'activeflag', pr.activeflag,
                    'firstname', pr.firstname,
                    'lastname', pr.lastname,
                    'dangerlevel',pr.dangerlevel,
                    'dangerreason',pr.dangerreason,
                    'dob',pr.dob,
                    'middlename',pr.middlename,
                    'suffix',pr.suffix,
                    'personaddress', (SELECT json_agg(json_build_object(
                        'personaddressid', pa.personaddressid,
                        'personid', pa.personid,
                        'activeflag', pa.activeflag,
                        'personaddresstypekey',pa.personaddresstypekey,
                        'address',pa.address,
                        'zipcode',pa.zipcode,
                        'city',pa.city,
                        'state',pa.state,
                        'country',pa.country,
                        'county',pa.county,
                        'address2',pa.address2,
                        'danger',pa.danger,
                        'dangerreason',pa.dangerreason
                        )) personaddress 
                        from personaddress pa
                        where pa.personid = pr.personid and pa.activeflag = 1)
                    ) Person 
                    from Person pr
                    where aexpunge.personid = pr.personid and pr.activeflag = 1)
                ) actor 
                from expunge.actor_expunge aexpunge
                where aexpunge.actorid = isra.actorid and aexpunge.activeflag = 1)
            )) intakeservicerequestactor 
            from expunge.intakeservicerequestactor_expunge isra
            where isra.intakeserviceid = isr.intakeserviceid and isra.activeflag = 1),
    (select fullname as supervisorname from userprofile where securityusersid in 
        (select tosecurityusersid from routing where objectid=isr.intakenumber and activeflag = 1)),
    (select isd.jsondata::jsonb 
        from expunge.intakedastaging_expunge isd where isd.intakenumber=isr.intakenumber and isd.activeflag=1)
    from 
        expunge.intakeservicerequest_expunge isr
    where isr.intakeserviceid = v_intakeserviceid::uuid;   

END;

$function$
;
