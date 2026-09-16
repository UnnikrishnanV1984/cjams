
/*
Issue Description: 3173518:ROA intake would not connect to service case. Was attempting to close service case and re-enter intake, but Service case will not re-open due to a pending SDM change from 2020. Case can not connect to proper intake (I261014091130) or close
Root cause: Need to connect Intake - I261014091130 with 3173518,  all Intake information to be in the service case 
Fix provided: DB queries  update personrole and createservicecase tables
Data/Code fix ticket#: CJAMS-68194
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
INSERT INTO personrole (
    personroleid, activeflag, personid, ishouseholdmember, 
    iscollateralcontact, drugexposednewbornflag, drugexposedtypekey, otherdrugs, 
    safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, 
    dangertoselfreason, isdangertoworker, dangertoworkerreason, ismentalillness, 
    mentalillnessdetail, ismentalimpair, mentalimpairdetail, insertedby, 
    insertedon, updatedby, updatedon, intakenumber, 
    intakeserviceid, servicecaseid, etl_userid, etl_load_date, 
    islivingalone, livingwithfocusperson, emergencycontact, initialresponse, 
    initialresponseupdatedby, initialresponseupdatedon
) VALUES (
    gen_random_uuid(), 1, '0864c33f-30b9-409a-ab2d-a9b7846a930b', 0, 
    0, 0, NULL, NULL, 
    0, 0, 0, 0, 
    ' ', 0, ' ', 0, 
    NULL, 0, ' ', 'CJAMS-68194', 
    now(), 'CJAMS-68194', now(), 3173518, 
    NULL, '8ac0ebd2-360d-44cc-9864-b5c696802007', NULL, NULL, 
    NULL, NULL, NULL, NULL, 
    NULL, NULL
);


INSERT INTO personrole (
    personroleid, activeflag, personid, ishouseholdmember, 
    iscollateralcontact, drugexposednewbornflag, drugexposedtypekey, 
    otherdrugs, safehavenbabyflag, probationsearchconductedflag, 
    sexoffenderregisteredflag, dangertoself, dangertoselfreason, 
    isdangertoworker, dangertoworkerreason, ismentalillness, 
    mentalillnessdetail, ismentalimpair, mentalimpairdetail, 
    insertedby, insertedon, updatedby, updatedon, intakenumber, 
    intakeserviceid, servicecaseid, etl_userid, etl_load_date, 
    islivingalone, livingwithfocusperson, emergencycontact, 
    initialresponse, initialresponseupdatedby, initialresponseupdatedon
) VALUES 
(
    gen_random_uuid(), 1, '3ba56495-6975-4616-84a7-00e77b4849e8', 0, 
    0, 0, NULL, NULL, 0, 0, 
    0, 0, ' ', 0, ' ', 0, 
    NULL, 0, ' ', 'CJAMS-68194', now(), 
    'CJAMS-68194', now(), 3173518, NULL, 
    '8ac0ebd2-360d-44cc-9864-b5c696802007', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL
),
(
    gen_random_uuid(), 1, 'b4ca8239-d3ee-4292-b7bb-f4515bf1cab5', 0, 
    0, 0, NULL, NULL, 0, 0, 
    0, 0, ' ', 0, ' ', 0, 
    NULL, 0, ' ', 'CJAMS-68194', now(), 
    'CJAMS-68194', now(), 3173518, NULL, 
    '8ac0ebd2-360d-44cc-9864-b5c696802007', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, NULL
);



select * from cjams.createservicecase(
  'bb95c043-1c2e-4f13-b3b9-fd3aedf0cd05'::uuid,
  '8ac0ebd2-360d-44cc-9864-b5c696802007'::character varying,
  0::integer,
  '6af7a326-0572-4e9c-9d19-e15e2949c5fe'::character varying,
  NULL::uuid[],
  ''::character varying,
  'intake'::character varying,
  false::boolean
);