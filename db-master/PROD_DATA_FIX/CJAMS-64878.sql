-- CJAMS-64878 Duplicate POSC and unable to delete duplicate
/*
-- Issue Description: 
   User request to delete the duplicate in-progress Plan of Safe Care (POSC) records for the case 2020011801159.
   
-- Case ID: 2020011801159

-- Category/ Module: Plan of Safe Care (POSC) (Case Management) 
-- Root cause: User request to delete the duplicate in-progress Plan of Safe Care (POSC) records.
-- Fix Provided: Datafix has been provided to soft delete the duplicate in-progress Plan of Safe Care (POSC) records. 
-- Regression Impacts: N/A
-- Is Code fix Required?: (Yes/No) No
-- Code fix ticket#: (If Yes) N/A
-- Reason why no related code fix: (If No) User error
*/

/*
-- safecareplan data

INSERT INTO cjams.safecareplan
(safecareplanid, objectid, objecttypekey, safecaredate, persondetails, planparticipants, healthneedsdetails, otherservices, planreviewdetails, "comments", justification, consentform, recommendedforclosure, insufficientevidencetocourt, familypreservationtransfer, referredtocps, shelterorder, signatures, activeflag, insertedby, insertedon, updatedby, updatedon, approvalstatus)
VALUES('c618d4a5-d98a-42ca-9662-11ad1b709a02', '087a918d-72ca-4e81-98c8-28dcde653db9', 'servicecase', NULL, '{}', '{}', '{"memberform":[{"id":1,"familymember":"Parent","familymembervalue":"Parent","personname":" KURSTI ANGEL NELSON ","personid":"b6acda26-6bb3-407e-bf85-09dd5de7d92d","persondob":"07-14-1996","declinemember":"Household","data":{"personname":" KURSTI ANGEL NELSON ","personpid":"200007375","persondob":"07-14-1996","personid":"b6acda26-6bb3-407e-bf85-09dd5de7d92d","aodassessment":true,"aodconsentobtained":true,"aodreferral":null,"refertoaod":null,"aodrefdate":null,"aodapptattend":null,"aodreasnforattnd":null,"aodcomments":null,"subuseassessment":null,"subuseconsentobtained":null,"subusereferral":null,"subuserefferedto":null,"subusedateofref":null,"subuseapptattend":null,"subusereasnforattnd":null,"subusecomments":null,"rcpmassessment":null,"rcpmconsentobtained":null,"rcpmreferral":null,"rcpmrefferedto":null,"rcpmdateofref":null,"rcpmapptattend":null,"rcpmreasnforattnd":null,"rcpmcomments":null,"mhsassessment":true,"mhsconsentobtained":true,"mhsreferral":"Yes","mhsrefferedto":"WCHDSB512","mhsdateofref":"2026-01-26T05:00:00.000Z","mhsapptattend":null,"mhsreasnforattnd":null,"mhscomments":null,"parskillassessment":null,"parskillconsentobtained":null,"parskillreferral":null,"parskillrefferedto":null,"parskilldateofref":null,"parskillapptattend":null,"parskillreasnforattnd":null,"parskillcomments":null,"noService":null,"noServiceReason":null}},{"familymember":"Newborn","familymembervalue":"Newborn","personname":" Kennedy Coraline Rey Sterling ","persondob":"12-28-2025","personid":"2283177c-51e1-48fd-a9f3-57b09a8fad87","data":{"personname":" Kennedy Coraline Rey Sterling ","personpid":"204515624","persondob":"12-28-2025","personid":"2283177c-51e1-48fd-a9f3-57b09a8fad87","newborndropdwn":null,"exposurewithdrawl":true,"exprefferal":"Yes","exprefferedto":"Birth to Five","exprefferraldate":"2026-01-26T05:00:00.000Z","expapptscheduled":null,"expdidnotattend":null,"expcomments":null,"developmental":null,"devrefferal":null,"devrefferedto":null,"devrefferraldate":null,"devapptscheduled":null,"devdidnotattend":null,"devcomments":null,"othermed":null,"othermedrefferal":null,"othermedrefferedto":null,"othermedrefferraldate":null,"othermedapptscheduled":null,"othermeddidnotattend":null,"othermedcomments":null,"othernewbneeds":null,"othnewbneedrefferal":null,"othnewbneedrefferedto":null,"othnewbneedrefferraldate":null,"othneedmedapptscheduled":null,"othbneedmeddidnotattend":null,"otherneedcomments":null,"noService":"","noServiceReason":""}}]}', '{"referralCurrentServices":{"breastfeedingReferral":false,"breastfeedingCurrent":false,"infantReferral":false,"infantCurrent":false,"childcareReferral":false,"childcareCurrent":false,"homeReferral":false,"homeCurrent":false,"homeNotes":"","pregnancyReferral":false,"pregnancyCurrent":false,"interventionReferral":false,"interventionCurrent":false,"birthReferral":true,"birthCurrent":false,"publicReferral":false,"publicCurrent":false,"parentingReferral":true,"parentingCurrent":false,"otherReferral":false,"otherCurrent":false,"otherNotes":"","noneIdentified":"","noneIdentifiedReason":""},"establishedServices":{"supportitemsFormArray":[],"unitedwayitemsFormArray":[],"housingitemsFormArray":[],"paroleitemsFormArray":[],"drugitemsFormArray":[],"additionalitemsFormArray":[]}}', '{}', '', '', '{}', false, false, false, false, false, '{}', 1, '476e6153-3f7e-4e6d-85fb-271e513ab5fd', '2026-01-28 14:43:40.596', '476e6153-3f7e-4e6d-85fb-271e513ab5fd', '2026-01-28 14:44:15.732', '');

-- history data
INSERT INTO cjams.safecareplan_history
(safecareplanhistoryid, safecareplanhistorytype, safecareplanid, objectid, objecttypekey, safecaredate, persondetails, planparticipants, healthneedsdetails, otherservices, planreviewdetails, "comments", justification, consentform, recommendedforclosure, insufficientevidencetocourt, familypreservationtransfer, referredtocps, shelterorder, signatures, activeflag, insertedby, insertedon, updatedby, updatedon, approvalstatus)
VALUES('e1132a47-704c-4b1e-ab7c-5cda47e4f49c', 'REVISION', 'c618d4a5-d98a-42ca-9662-11ad1b709a02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Plan of safe care has been saved as draft', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '476e6153-3f7e-4e6d-85fb-271e513ab5fd', '2026-01-28 14:43:40.596', '476e6153-3f7e-4e6d-85fb-271e513ab5fd', '2026-01-28 14:43:40.596', NULL);

INSERT INTO cjams.safecareplan_history
(safecareplanhistoryid, safecareplanhistorytype, safecareplanid, objectid, objecttypekey, safecaredate, persondetails, planparticipants, healthneedsdetails, otherservices, planreviewdetails, "comments", justification, consentform, recommendedforclosure, insufficientevidencetocourt, familypreservationtransfer, referredtocps, shelterorder, signatures, activeflag, insertedby, insertedon, updatedby, updatedon, approvalstatus)
VALUES('63213302-52c0-4c47-8806-2578fa8813fa', 'REVISION', 'c618d4a5-d98a-42ca-9662-11ad1b709a02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Plan of safe care has been saved as draft', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '476e6153-3f7e-4e6d-85fb-271e513ab5fd', '2026-01-28 14:44:15.732', '476e6153-3f7e-4e6d-85fb-271e513ab5fd', '2026-01-28 14:44:15.732', NULL);

*/

delete from cjams.safecareplan_history
where safecareplanid in ('c618d4a5-d98a-42ca-9662-11ad1b709a02')
	 and activeflag = 1 ;

delete from cjams.safecareplan
where safecareplanid in ('c618d4a5-d98a-42ca-9662-11ad1b709a02')
	 and activeflag = 1 ;
	 
-- No routing data  
/*
select * 
from cjams.routing
where eventcode = 'SENSCP' -- Plan of Safe Care
	and objectid in ('c618d4a5-d98a-42ca-9662-11ad1b709a02')
	 and activeflag = 1 ;
*/	 