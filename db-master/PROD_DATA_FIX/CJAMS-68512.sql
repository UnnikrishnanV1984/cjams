
/*
Issue Description: There is No Submission History available in Decision tab.
Root cause: Please carry out data fix to update the routing table to populate the submission history against Intake# I261014108770 
Fix provided: DB queries to update the routing table to populate the submission history against Intake# I261014108770
Data/Code fix ticket#: CJAMS-68512
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix only, no code changes required
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
INSERT INTO routing (
    routingid,
    eventcode,
    fromsecurityusersid,
    tosecurityusersid,
    teamid,
    fromroleid,
    toroleid,
    objectid,
    routingstatustypeid,
    activeflag,
    insertedby,
    insertedon,
    updatedby,
    updatedon,
    isreviewrequest,
    intakerecommendation,
    approveddate
) VALUES (
    gen_random_uuid(),
    'INTR',
    '34c5221a-8299-49ff-bbd4-cc99a7f0afd6',
    '34c5221a-8299-49ff-bbd4-cc99a7f0afd6',
    'd667af13-8151-462b-aa2e-adab34dcb076',
    'CWCW',
    'CWCW',
    'I261014108770',
    8,
    0,
    '34c5221a-8299-49ff-bbd4-cc99a7f0afd6',
    '2026-06-24 13:46:31.047',
    '34c5221a-8299-49ff-bbd4-cc99a7f0afd6',
    '2026-06-24 13:46:31.047',
    FALSE,
    'Closed',
    '2026-06-24 13:46:31.047'
);



-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('5a25606f-8c01-492e-9288-455fd1ba839e', 'INTR', '34c5221a-8299-49ff-bbd4-cc99a7f0afd6', '34c5221a-8299-49ff-bbd4-cc99a7f0afd6', 'd667af13-8151-462b-aa2e-adab34dcb076', 'CWCW', 'CWCW', 'I261014108770', 8, 0, '34c5221a-8299-49ff-bbd4-cc99a7f0afd6', '2026-06-24 13:46:31.047', NULL, '2026-07-09 12:23:56.965', false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Closed', NULL, '2026-06-24 13:46:31.047');



DELETE FROM cjams.routing
WHERE routingid='5a25606f-8c01-492e-9288-455fd1ba839e';
