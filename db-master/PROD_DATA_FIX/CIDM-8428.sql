/*
 * CIDM-8428 - CPS Case decision issue 
 * Screen name:CPS pathway
 * data fix for these cases.
 * 221020286854, 221020208880, 221020207178, 221020184292 
 * 
 */

UPDATE cjams.intakeservicerequestdispositioncode
SET updatedby='CIDM-8428', updatedon=now(), activeflag=0 
WHERE intakeservicerequestdispositioncodeid in (
'5dd8f2ab-23ae-4be8-ab65-cad7ac8c0625', 
'767609dd-bc8e-4be4-936a-91d7e33b2120', 
'3549356b-43df-47e1-9883-47eddb57a3fe',
'c52709a1-5858-41b6-a883-e8e94d522d2b',
'2278bfbe-c68b-4550-abc6-a56174817511',
'fd64b534-37e3-460d-ad62-30a2a2072634'
);

UPDATE cjams.routing
SET updatedby='CIDM-8428', updatedon=now(), activeflag=0 
WHERE objectid in (
'5dd8f2ab-23ae-4be8-ab65-cad7ac8c0625', 
'767609dd-bc8e-4be4-936a-91d7e33b2120', 
'3549356b-43df-47e1-9883-47eddb57a3fe',
'c52709a1-5858-41b6-a883-e8e94d522d2b',
'2278bfbe-c68b-4550-abc6-a56174817511',
'fd64b534-37e3-460d-ad62-30a2a2072634'
);