/*
  Issue Description:CDM-39179 Need to reassign case closure
                    Diane is off for the remainder of the week and the case is over due. Please reassign or reset Conner Skinner under the case closer column
  IV-E Specialist: Diane WoodwardBrown (Assigned To)
  Category/ Module : Title IV-E
  Root cause:Diane is off for the remainder of the week and the case is over due.
             Need data fix to revert the Case# 231030098183 to 'To be assigned' status which has already been 
             assigned to IV-E Specialist (Diane WoodwardBrown) in the Case Closure Review (IV-E Supervisor Case closure Assignment dashboard).
  Fix Provided: data fix to revert the Case# 231030098183 to 'To be assigned' status which has already been assigned to IV-E Specialist (Diane WoodwardBrown) 
  in the Case Closure Review (IV-E Supervisor Case closure Assignment dashboard).
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

-- INSERT INTO cjams.routing
-- (objectid, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('cc4a8ea6-f912-42c7-b1de-2a9eb0361cd9', 'e0d03c29-f317-46bd-bb35-5c6a27285f67'::uuid, 'IVECCR', 'bd26ba51-e656-49f6-b9a6-3f5e6a38480e', '769bdaba-c2a0-4757-a294-9d0375dc5882', 'e0e508e0-021b-4bda-9b1a-68b415eb0787'::uuid, 'IVESV', 'IVESP', 'cc4a8ea6-f912-42c7-b1de-2a9eb0361cd9', 202, 1, 'bd26ba51-e656-49f6-b9a6-3f5e6a38480e', '2024-05-21 08:57:54.418', 'bd26ba51-e656-49f6-b9a6-3f5e6a38480e', '2024-05-21 08:57:54.418', true, 'Case Closure is assigned for Review', NULL, 'Case Closure is assigned for Review', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update cjams.routing
set tosecurityusersid = NULL,
    teamid = NULL,
    routingstatustypeid = 201,
    isreviewrequest = false,
    routeddescription = NULL,
    remarks = NULL,
    updatedby = 'CDM-39179',
    updatedon = now()
where objectid = 'cc4a8ea6-f912-42c7-b1de-2a9eb0361cd9'
and activeflag =1;

update ivecaseclosurereview
set ivereviewstatus = 'CCR_Review',
    updatedby = 'CDM-39179',
    updatedon = now()
where objectid = '88725554-e84c-4757-b685-42574b3b9a90'
and ivecaseclosurereviewid = 'cc4a8ea6-f912-42c7-b1de-2a9eb0361cd9';