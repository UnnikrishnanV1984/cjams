
/*
Issue: Intake Referal CJAMS-62176
Root Cause: Intake was screened out, but does not appear in Cynthia Hightower's Screened Out dashboard.
Fix Provided: Update the event code, routing status, intake recommendation and supervisor decision for the referral to reflect that it was screened out. 
Data/Code fix ticket#: CDM-44702
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue, not a code defect
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
select * from intakeservreqchildremoval where intakeservreqchildremovalid in ('d43f512b-aa5d-43ec-bb7b-444c45d60b01','225a4ee0-85aa-4345-891c-49818838c7b2') and activeflag=1;
*/
update intakedastaging 
SET status = 'Closed', updatedby = 'CJAMS-62176', updatedon = now(),
jsondata = jsonb_set(jsondata, '{DAType, DATypeDetail, 0, supDisposition}', '"ScreenOUT"')
WHERE intakenumber = 'I251013342526' AND activeflag=1;


update routing
    set activeflag=1,
        eventcode = 'INTR', 
        routingstatustypeid = 8, 
        intakerecommendation = 'ScreenOUT', 
        supervisordecision = 'screenout',
        updatedon = '2026-04-14 08:46:13.867', 
        updatedby = '0ae86a6f-5365-4bb2-b079-f85eb391a2ae'
    where routingid = 'd8dba76e-852d-4ae1-8f1b-45b29b9b32c3';
   
   
   update intakedastatus 
   set status =3, updatedby = 'CJAMS-62176', updatedon = now()
   WHERE intakenumber = 'I251013342526' AND activeflag=1;
  
  update routing 
  set fromsecurityusersid ='0ae86a6f-5365-4bb2-b079-f85eb391a2ae',activeflag =0
  where routingid = 'd8dba76e-852d-4ae1-8f1b-45b29b9b32c3';

    WITH created AS (
    INSERT INTO intakeservicerequest (
    intakeserviceid, activeflag, servicerequestnumber, servicerequestincidenttypekey, narrative,
    title, description, reporteddate, reportedtime, reportedarea, reportedtypekey, reportedbyself, 
    sourcearea, intakeservreqinputtypeid, intakeservreqtypeid, inputtypevalue, intakeserreqstatustypeid, 
    intakeservicerequestclassid, crossreferencewith, priorityid, statuschangedate, statuschangedescription, 
    dangerlevel, dangerreason, accesslevel, 
    updatedby, updatedon, insertedby, insertedon,
    archiveon, archiveby, "timestamp", old_id, effectivedate, expirationdate, suspiciousdeath, 
    missingpersons, sharedcaretaxcredit, sharedcaretaxcredityear, agencyname, notes, externalagencyphone, 
    externalagencyfax, externalagencyemail, investigatable, visitinfo, illegalactivity, 
    intakeservicerequestillegalactivitytypekey, targetcompletedate, supervisorreview, rarejectedmedicaidstatus, 
    moneyfollowsperson, im54adate, hcb, adverseactiondate, applicationhearingreceiveddate, 
    reversaladverseactiondate, monumber, intakeservreqinputsourceid, isanonymousreporter, 
    intakeservreqpurposeid, isrouted, routedusersid, intakenumber, routedon, teamtypekey, 
    isotheragency, isunknownreporter, reporterfirstname, reporterlastname, isappealed, actiontype, 
    offenselocation, requesterphone, requesterzipcode, iszipcoderefuse, iscps, isaccepted, 
    accepteddate, isdraft, foldertypekey, folderreasontypekey, folderopendatetime, foldernotes, 
    responsibilitytypekey, exitdate, islocalreferal, referalcomments, nonreferalreason, screeningname, 
    screenintypeflag, contacttypekey, screenerid, recorddate, recordtime, scnapprovalstatustypekey, 
    scnapprovaldate, screeningnmsoundex, formattedreferralname, expungementflag, lastexpungementdate, 
    demoscreeningcompleteflag, narratvscreeningcompleteflag, rnmsoundex, caseid, 
    communicationastncrqrdflag, jurisdictionofincidenttypekey, historyclearanceinfo, 
    histclearanceenteredby, histclearanceenteredtimestamp, histclearanceeditedby, 
    histclearanceeditedtimestamp, receivedtime, fk1_id, requesteraddress1, requesteraddress2, 
    requestercity, requesterstate, requestercounty, isacknowledgementletter, isrestitution, 
    servicecaseid, countyid, constentreceiveddate, searchworkername, isnoticedthirdparty, 
    isnoticedindividual, isclosecpshistory, clearancereasontypekey, fk_source, status_indc, 
    reportermiddlename, reporterphonenumber, reporterroletypekey, reporterzipcode, 
    reporterincidentlocation, reporteremail, reporterisapproximate, reporterorganization, 
    reportertitle, reporterincidentdate, reporterisanonymousreporter, reporterisunknownreporter, 
    reporternarrative, reporterrefusetosharezip, reporterisacknowledgementletter, reporteraddress1, 
    reporteraddress2, reportercity, reporterstate, narrativeupdateddate, reporterphonenumberext, 
    isscreening, intakedaterecieved, hascisdata, etl_userid, etl_load_date, responsetimer, 
    intakestatus, cissuid, responsetimerdetails, addendum
) VALUES (
    gen_random_uuid(), 1, NULL, NULL, NULL, NULL, NULL, '2024-04-25 09:10:54.697', '2024-04-25 13:11:04.673',
    NULL, NULL, NULL, NULL, '0bdda2ab-b74f-4d74-ba17-3b9b37a9ca19', '247a8b26-cdee-4ce8-b36e-b37e49fd0103', NULL,
    '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '00000000-0000-0000-0000-000000000000', NULL, NULL, NULL, NULL, NULL, NULL, false,
    'CJAMS-62176', '2024-04-25 09:11:05.042886', 'CJAMS-62176', '2024-04-25 09:11:05.042886',
    NULL, NULL, NULL, NULL, '2024-04-25 09:11:05.042886', NULL, NULL, NULL, false, NULL, NULL, NULL, false, false, false, false, NULL, NULL, NULL,
    NULL, NULL, false, false, NULL, false, NULL, NULL, NULL, NULL, NULL, false, '247a8b26-cdee-4ce8-b36e-b37e49fd0103', false, NULL,
    'I251013342526', NULL, 'CW', NULL, false, 'Emily ', 'Hall', false, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL,
    NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, '', '4104644097', 'EP', '', '67 Linden Place 21286', '', true, NULL, 'SC', '2024-03-25 04:00:00', NULL, NULL, NULL,
    NULL, NULL, '', '', '', '', '2024-04-25 09:10:54.697', '', NULL, '2024-04-23 16:24:07', false, NULL, NULL, NULL, NULL, NULL, NULL, NULL
)
RETURNING intakeserviceid
)





INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate,
 description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid,
 dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, 
 servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, 
 additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey,
 requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, 
 clientmergeid, etl_userid, etl_load_date)
SELECT gen_random_uuid(), created.intakeserviceid, 'CJAMS-62176', now(), 'CJAMS-62176', now(), null, '2015-07-14 00:00:00', 
    null, null, now(), 1, '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', '87b0728a-2614-4a98-980c-20dc96b6d193', 
    null, '', null, null, now(), 'Closing Case as per CJAMS-62176 request', '', '', '',
    null, '', null, '', '',
    '', null, null, null, null, null, '', '', 
    '', '', '', '', null, null, null, 
    null, '', null
FROM created;
