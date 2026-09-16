/*
  Issue Description:CDM-38991 Adoption Case Adoption Case# 3293252,
  The 'Head of Household' name is not displayed on the worker's workload for this case, need technical investigation and fix to be provided to display the Head of Household (TAYLOR MASSILLON).
    Case worker: Katie Hitch (Assigned To)
    Supervisor: Lori Engle (Assigned By)
  Category/ Module : Supervisor Dashboard (Workload)
  Root cause: The 'Head of Household' name is not displayed on the worker's workload for the case as case was created with incorrect objecttype key i.e. servicerequest
  Fix Provided: Data fix has been provided to update the right objecttype key in case assement table
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

-- INSERT INTO cjams.caseassignment
-- (caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
-- VALUES('0a0c7901-5263-4cb6-a94f-f834a8cedd18'::uuid, '04429ea9-4de4-49e0-a6fe-106abf8127cc'::uuid, NULL, '7ca5718d-cc3f-4884-934c-6769a4d00eed', NULL, NULL, '0457f633-bbfa-4cd3-bff2-8f013193488f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '7ca5718d-cc3f-4884-934c-6769a4d00eed', '7ca5718d-cc3f-4884-934c-6769a4d00eed', '2023-06-21 18:15:13.965', '2023-06-21 18:15:13.965', 'servicerequest', '8fa412b3-18b9-419f-85a6-3c8ca92a93c8'::uuid, 'family', 1, '2023-06-21 18:15:13.965', NULL, '7b6d033b-d70a-4d20-82b0-25596eb2544a'::uuid, '9ce42709-1686-42be-bc39-76f5728a93c3'::uuid, '', NULL, '1e886503-ef0a-450c-8607-566c45fa75e4'::uuid, NULL, 'U', NULL, '2023-06-21 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update caseassignment
set objecttypekey='adoptioncase',
updatedby = 'CDM-38991',
updatedon = now()
where caseassignmentid = '0a0c7901-5263-4cb6-a94f-f834a8cedd18'
and   objectid = '8fa412b3-18b9-419f-85a6-3c8ca92a93c8';
