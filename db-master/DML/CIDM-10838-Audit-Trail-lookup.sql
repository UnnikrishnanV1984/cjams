
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 12/03/2025 Veera Nadimpalli - adding audit log look up for YTP changes B-186271_CIDM-10838_stg2_YTPChecklist
------------------------------------------------------------------------------------------------------------	


DELETE FROM cjams.audittraillukup
WHERE typekey = 'youthtransitionplan';


INSERT INTO cjams.audittraillukup (
    typekey,
    historytablename,
    primarykeyname,
    fieldjson,
    activeflag,
    insertedby,
    insertedon,
    updatedby,
    updatedon
)
VALUES (
    'youthtransitionplan',
    'youthtransitionplan_history',
    'youthtransitionplanid',
    $json$
[
  {
    "displayname": "Will the youth need a guardian past 18th birthday?",
    "key": "newfcgschecklistjson",
    "alias": "istransitionpast18th",
    "query": "SELECT newfcgschecklistjson->>'isTransitionpast18th' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Q1 – Internal meeting with legal date",
    "key": "newfcgschecklistjson",
    "alias": "restictivealternative",
    "query": "SELECT newfcgschecklistjson->>'restictiveAlternative' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Youth will remain in foster care till 21",
    "key": "newfcgschecklistjson",
    "alias": "willremaintill21",
    "query": "SELECT newfcgschecklistjson->>'willRemaintill21' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Youth does not need transition to APG",
    "key": "newfcgschecklistjson",
    "alias": "needtransition",
    "query": "SELECT newfcgschecklistjson->>'needTransition' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "DDA Services Status",
    "key": "newfcgschecklistjson",
    "alias": "ddaservices",
    "query": "SELECT newfcgschecklistjson->>'ddaServices' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Is the youth eligible for DDA services",
    "key": "newfcgschecklistjson",
    "alias": "isddaservices",
    "query": "SELECT newfcgschecklistjson->>'isDdaServices' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "DDA Enrollment Date",
    "key": "newfcgschecklistjson",
    "alias": "enrollmentdate",
    "query": "SELECT newfcgschecklistjson->>'enrollmentDate' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "DDA Narrative",
    "key": "newfcgschecklistjson",
    "alias": "narrative",
    "query": "SELECT newfcgschecklistjson->>'narrative' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "DDA Comments",
    "key": "newfcgschecklistjson",
    "alias": "comments",
    "query": "SELECT newfcgschecklistjson->>'comments' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "SSI Status",
    "key": "newfcgschecklistjson",
    "alias": "ssi",
    "query": "SELECT newfcgschecklistjson->>'ssi' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "SSI Enrollment Date",
    "key": "newfcgschecklistjson",
    "alias": "ssienrollmentdate",
    "query": "SELECT newfcgschecklistjson->>'ssienrollmentDate' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "SSI Narrative",
    "key": "newfcgschecklistjson",
    "alias": "ssinarrative",
    "query": "SELECT newfcgschecklistjson->>'ssinarrative' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Does youth have Trust / ABLE account?",
    "key": "newfcgschecklistjson",
    "alias": "ableacc",
    "query": "SELECT newfcgschecklistjson->>'ableAcc' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "ABLE/Trust Established Date",
    "key": "newfcgschecklistjson",
    "alias": "ableaccestablishdate",
    "query": "SELECT newfcgschecklistjson->>'ableAccEstablishDate' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "ABLE/Trust Institution Narrative",
    "key": "newfcgschecklistjson",
    "alias": "ableaccnarrative",
    "query": "SELECT newfcgschecklistjson->>'ableAccNarrative' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Need ABLE Account to protect eligibility",
    "key": "newfcgschecklistjson",
    "alias": "ableeligibility",
    "query": "SELECT newfcgschecklistjson->>'ableEligibility' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "ABLE/Trust Type",
    "key": "newfcgschecklistjson",
    "alias": "ableeliginstitution",
    "query": "SELECT newfcgschecklistjson->>'ableEligInstitution' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "ABLE/Trust Institution – Where held",
    "key": "newfcgschecklistjson",
    "alias": "ableaccelignarrative",
    "query": "SELECT newfcgschecklistjson->>'ableAccEligNarrative' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Receiving jurisdiction meeting – enrollment date",
    "key": "newfcgschecklistjson",
    "alias": "ddareceivingjurisdiction",
    "query": "SELECT newfcgschecklistjson->>'ddaReceivingJurisdiction' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Receiving jurisdiction comments",
    "key": "newfcgschecklistjson",
    "alias": "ddajurisdicationcomments",
    "query": "SELECT newfcgschecklistjson->>'ddaJurisdicationComments' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Receiving jurisdiction Not Applicable",
    "key": "newfcgschecklistjson",
    "alias": "isddareceiving",
    "query": "SELECT newfcgschecklistjson->>'isDdaReceiving' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Type of Placement",
    "key": "newfcgschecklistjson",
    "alias": "typeofplacement",
    "query": "SELECT newfcgschecklistjson->>'typeOfPlacement' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Name of Placement",
    "key": "newfcgschecklistjson",
    "alias": "placementname",
    "query": "SELECT newfcgschecklistjson->>'placementName' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Other – Narrative (Q6)",
    "key": "newfcgschecklistjson",
    "alias": "oasnarrative",
    "query": "SELECT newfcgschecklistjson->>'oasNarrative' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Address TBD",
    "key": "newfcgschecklistjson",
    "alias": "isaddresstbd",
    "query": "SELECT newfcgschecklistjson->>'isAddressTbd' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Guardian willing to provide care",
    "key": "newfcgschecklistjson",
    "alias": "willguardianprovidecare",
    "query": "SELECT newfcgschecklistjson->>'willGuardianProvideCare' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Guardian Person Id",
    "key": "newfcgschecklistjson",
    "alias": "personid",
    "query": "SELECT newfcgschecklistjson->>'personid' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Adult guardianship petition filing date",
    "key": "newfcgschecklistjson",
    "alias": "petitionfillingdate",
    "query": "SELECT newfcgschecklistjson->>'petitionFillingDate' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Transition meeting with adult guardianship caseworker",
    "key": "newfcgschecklistjson",
    "alias": "transistionmeeting",
    "query": "SELECT newfcgschecklistjson->>'transistionMeeting' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },

  {
    "displayname": "Placement Address 1",
    "key": "newfcgschecklistjson",
    "alias": "address1",
    "query": "SELECT newfcgschecklistjson->'address'->>'address1' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Placement Address 2",
    "key": "newfcgschecklistjson",
    "alias": "address2",
    "query": "SELECT newfcgschecklistjson->'address'->>'address2' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Placement City",
    "key": "newfcgschecklistjson",
    "alias": "city",
    "query": "SELECT newfcgschecklistjson->'address'->>'city' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Placement State",
    "key": "newfcgschecklistjson",
    "alias": "state",
    "query": "SELECT newfcgschecklistjson->'address'->>'state' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Placement Zipcode",
    "key": "newfcgschecklistjson",
    "alias": "zipcode",
    "query": "SELECT newfcgschecklistjson->'address'->>'zipcode' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Placement County",
    "key": "newfcgschecklistjson",
    "alias": "county",
    "query": "SELECT newfcgschecklistjson->'address'->>'county' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Petition Sent to DSS Attorney on",
    "key": "newfcgschecklistjson",
    "alias": "petitionsenttodssattorneyon",
    "query": "SELECT newfcgschecklistjson->>'petitionSentToDssAttorneyOn' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },  
  {
    "displayname": "Petition Skip",
    "key": "newfcgschecklistjson",
    "alias": "petitionskip",
    "query": "SELECT newfcgschecklistjson->>'petitionSkip' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },
  {
    "displayname": "Petition Skip Comment",
    "key": "newfcgschecklistjson",
    "alias": "petitionskipcomment",
    "query": "SELECT newfcgschecklistjson->>'petitionSkipComment' FROM youthtransitionplan WHERE youthtransitionplanid = "
  },

  {
    "displayname": "Updated By",
    "key": "updatedby",
    "alias": "updatedby",
    "query": "SELECT coalesce(u.fullname,ytp.updatedby) FROM youthtransitionplan ytp LEFT JOIN userprofile u ON u.securityusersid = ytp.updatedby WHERE ytp.youthtransitionplanid = ",
    "query2": " order by ytp.updatedon desc limit 1"
  },
  {
    "displayname": "Updated Date and Time",
    "key": "updatedon",
    "alias": "updatedon"
  }
]
$json$,
    1,
    'CIDM-10838',
    now(),
    'CIDM-10838',
    now()
);