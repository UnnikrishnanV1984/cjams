/*
 * 
 * 211030008649:Can you please delete the active POSC
 * Focus Area: POSC 
 * Identified As:User error, the user created a version copy and it is not required, so the user requested to delete it. The POSC delete option is not there in the application which requires a data fix.
 * Category/ Module: POSC
 * Root cause: User Error
 * Fix Provided: Datafix has been promoted to remove draft POSC
 Case ID: 211030008649
 Client ID: 204241199 (Jade Eilers-Boutwell)
*/

/*SP
 * SELECT *
FROM cjams.getsafecareplandetails(
    'eba90a9b-7102-4842-acc6-2678aa580b06',
    'servicecase',
    '{15ef32af-b21a-4abe-b087-72b6e9625895}'::varchar[]
);*/

--select * from safecareplan s where objectid = 'eba90a9b-7102-4842-acc6-2678aa580b06'
--order by insertedon desc;

/*
INSERT INTO cjams.safecareplan
(safecareplanid, objectid, objecttypekey, safecaredate, persondetails, planparticipants, healthneedsdetails, otherservices, planreviewdetails, "comments", justification, consentform, recommendedforclosure, insufficientevidencetocourt, familypreservationtransfer, referredtocps, shelterorder, signatures, activeflag, insertedby, insertedon, updatedby, updatedon, approvalstatus)
VALUES('a9964968-4674-4a6f-8032-4b89f4e5c484'::uuid, 'eba90a9b-7102-4842-acc6-2678aa580b06', 'servicecase', NULL, '{}'::json, '{"data":{"roleCollectionList":[{"id":1,"rolemember":"IAT","rolenameTitle":"Katie Klein, Liaison","rolephone":"4106511616","personid":"","personName":"Katie Klein, Liaison","roleemail":"kklein@somerset.k12.md.us","roledesc":"Infants and Toddlers"},{"id":2,"rolemember":"HSWN","rolenameTitle":"Audry Motlagh-Harvey, LCSW-C,MPH,TF-CBT","rolephone":"4105500288","personid":"","personName":"Audry Motlagh-Harvey, LCSW-C,MPH,TF-CBT","roleemail":"amotlag1@jhmi.edu","roledesc":"Hospital Social Worker/Nurse"}],"pcpDetails":[{"clientName":"Jade Eilers-Boutwell","isPCP":"Yes","primaryCareDoctor":"Vera Bennett-Brown","physicianType":"Pediatrics","email":null,"contact":"4105756611","personid":"15ef32af-b21a-4abe-b087-72b6e9625895"}],"notRequiredPCPDetails":[]}}'::json, '{}'::json, '{}'::json, '{}'::json, '', '', '{}'::json, false, false, false, false, false, '{}'::json, 1, 'b27af799-f683-4d73-9b51-108846e5257f'::uuid, '2025-11-19 14:09:42.544', 'b27af799-f683-4d73-9b51-108846e5257f'::uuid, '2025-11-19 14:10:22.143', '');
*/

DELETE FROM cjams.safecareplan
WHERE safecareplanid='a9964968-4674-4a6f-8032-4b89f4e5c484'::uuid;


--select * from safecareplan_history sh where safecareplanid  = 'a9964968-4674-4a6f-8032-4b89f4e5c484'
--and activeflag =1;

/*
INSERT INTO cjams.safecareplan_history
(safecareplanhistoryid, safecareplanhistorytype, safecareplanid, objectid, objecttypekey, safecaredate, persondetails, planparticipants, healthneedsdetails, otherservices, planreviewdetails, "comments", justification, consentform, recommendedforclosure, insufficientevidencetocourt, familypreservationtransfer, referredtocps, shelterorder, signatures, activeflag, insertedby, insertedon, updatedby, updatedon, approvalstatus)
VALUES('67442a76-8efa-4c0f-8ffc-50639fc65cbb'::uuid, 'REVISION', 'a9964968-4674-4a6f-8032-4b89f4e5c484'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Plan of safe care has been saved as draft', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'b27af799-f683-4d73-9b51-108846e5257f'::uuid, '2025-11-19 14:09:42.544', 'b27af799-f683-4d73-9b51-108846e5257f'::uuid, '2025-11-19 14:09:42.544', NULL);
INSERT INTO cjams.safecareplan_history
(safecareplanhistoryid, safecareplanhistorytype, safecareplanid, objectid, objecttypekey, safecaredate, persondetails, planparticipants, healthneedsdetails, otherservices, planreviewdetails, "comments", justification, consentform, recommendedforclosure, insufficientevidencetocourt, familypreservationtransfer, referredtocps, shelterorder, signatures, activeflag, insertedby, insertedon, updatedby, updatedon, approvalstatus)
VALUES('816d9038-7d61-45c0-a69d-4867604832fa'::uuid, 'REVISION', 'a9964968-4674-4a6f-8032-4b89f4e5c484'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Plan of safe care has been saved as draft', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'b27af799-f683-4d73-9b51-108846e5257f'::uuid, '2025-11-19 14:10:22.143', 'b27af799-f683-4d73-9b51-108846e5257f'::uuid, '2025-11-19 14:10:22.143', NULL);
*/

DELETE FROM cjams.safecareplan_history
WHERE safecareplanhistoryid='67442a76-8efa-4c0f-8ffc-50639fc65cbb'::uuid;

DELETE FROM cjams.safecareplan_history
WHERE safecareplanhistoryid='816d9038-7d61-45c0-a69d-4867604832fa'::uuid;