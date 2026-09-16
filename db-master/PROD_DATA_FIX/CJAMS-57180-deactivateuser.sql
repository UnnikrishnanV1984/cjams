/*
   Issue Description: CJAMS-57180
   Category/ Module  : Deactivate user role
   Root cause: user requeseted to remove user role. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--   please deactivate child welfare roles and child welfare teammember assignments for this user in cjams db for anita.duncan@maryland.gov, nicolel.griffin1@maryland.gov, rhonda.hall@maryland.gov, stevea.chapman@maryland.gov
-- michael.piercy@maryland.gov - please place the user under DHS Central county , team configuration Team name: DHS Central Teamnumber: 3824, and remove CJAMS_CWSUPERVISOR role and add CJAMS_CENTRAL_POLICY_STAFF to the user

update teammemberassignment
set activeflag = '0', updatedby = 'CJAMS-57180', updatedon = now()
where securityusersid in ('c05cef07-07bf-4966-8d27-0c7905f82169','2360b3b4-9867-4c8e-91a9-ded1212f3042','33dae786-e862-4511-87b6-28a2d36bd30f','830f9b58-51cd-48b4-80b4-91555dbee36c') and activeflag = 1;

update teammember
set activeflag = '0', updatedby = 'CJAMS-57180', updatedon = now()
where teammemberid in ('7315a67a-eb75-4581-afa7-13b43344c460','834835f3-ba0f-46f8-b926-839466abe777','ebf3335d-7e64-4609-9dec-83be3419d9aa','92fc2949-508f-4d38-97d4-ae0cd0743db7') and activeflag =1;

update rolemapping set activeflag = '0', updatedby = 'CJAMS-57180', updatedon = now()
where principalid in ('2922','7026','2773','7011') and activeflag = 1;

-- michael.piercy@maryland.gov
UPDATE cjams.rolemapping
SET activeflag=0, updatedby='CJAMS-57180', updatedon=now()
WHERE id=775628 and principalid='2964' and roleid=36 and activeflag = 1;

INSERT INTO cjams.rolemapping
(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES(154789764, 'USER', '2964', 3150, 1, 'CJAMS-57180', 'CJAMS-57180', now(), now(), NULL, 'CW') on conflict do nothing;

INSERT INTO cjams.teammember
(teammemberid, activeflag, teamid, loadnumber, roletypekey, positioncode, description, isoncall, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", linenumber, voidedby, voidedon, voidreasonid, rtfdate, coadate, old_id, isdefaultroute, supervisorid)
VALUES('a0a0e318-9787-4aaa-9234-1da259de6187'::uuid, 1, '11dc65f0-b116-45a9-a07a-8fbe171f0c9d'::uuid, '6004198', 'CWPS', '3824', 'Cental Policy Staff', true, 'CJAMS-57180', now(), 'CJAMS-57180', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, now(), now(), NULL, 1, NULL) on conflict do nothing;

UPDATE cjams.teammemberassignment
SET  teammemberid='a0a0e318-9787-4aaa-9234-1da259de6187'::uuid , updatedby='CJAMS-57180', updatedon=now()
WHERE teammemberassignmentid='082bb232-3f0d-4fb9-8705-925bb9d3762d'::uuid and securityusersid='1ec60956-363c-40c9-9428-5ec87b2a9133';

UPDATE cjams.userprofile
SET updatedby='CJAMS-57180', updatedon=now(), primarycountycd='3824'
WHERE securityusersid='1ec60956-363c-40c9-9428-5ec87b2a9133' and  email='michael.piercy@maryland.gov';

