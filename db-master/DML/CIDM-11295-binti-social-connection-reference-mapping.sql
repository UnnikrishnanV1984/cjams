------------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 06/02/2026 - CIDM-11295 - Seed Binti social connection mapping in reference tables.
-- 06/10/2026 - CIDM-11295 - Delete scripts correction for reference values.
------------------------------------------------------------------------------------------------------------------

DELETE FROM cjams.referencetype
WHERE referencetypeid = 91001;

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
SELECT
    91001,
    'Binti Social Connection Mapping',
    'binti_social_connection_mapping',
    1,
    'CIDM-11295',
    now(),
    'CIDM-11295',
    now(),
    NULL
WHERE NOT EXISTS (
    SELECT 1
    FROM cjams.referencetype rt
    WHERE rt.referencetypeid = 91001
);

DELETE FROM cjams.referencetype
WHERE referencetypeid = 91002;

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
SELECT
    91002,
    'Binti Gender Mapping',
    'binti_gender_mapping',
    1,
    'CIDM-11295',
    now(),
    'CIDM-11295',
    now(),
    NULL
WHERE NOT EXISTS (
    SELECT 1
    FROM cjams.referencetype rt
    WHERE rt.referencetypeid = 91002
);

DELETE FROM cjams.referencevalues
WHERE referencetypeid = 91001;

WITH mapping_rows(ref_key, kinship_relationship, lineage_type, role_label, displayorder, parentkey) AS (
    VALUES
    ('MOTHER', 'mother', 'biological', 'Mother (Biological)', 10, 'BINTI_ROLE'),
    ('BGMTHR', 'mother', 'biological', 'Mother (Biological)', 11, 'BINTI_ROLE'),
    ('BIOLOGICALMOTHER', 'mother', 'biological', 'Mother (Biological)', 12, 'BINTI_ROLE'),
    ('FATHER', 'father', 'biological', 'Father (Biological)', 20, 'BINTI_ROLE'),
    ('BGFTHR', 'father', 'biological', 'Father (Biological)', 21, 'BINTI_ROLE'),
    ('BIOLOGICALFATHER', 'father', 'biological', 'Father (Biological)', 22, 'BINTI_ROLE'),
    ('PRNT', 'parent', NULL, 'Parent', 30, 'BINTI_ROLE'),
    ('PARENT', 'parent', NULL, 'Parent', 31, 'BINTI_ROLE'),
    ('NCUSPRNT', 'parent', NULL, 'Parent', 32, 'BINTI_ROLE'),
    ('STMTHR', 'mother', 'step', 'Step Mother', 40, 'BINTI_ROLE'),
    ('STPFTHR', 'father', 'step', 'Step Father', 41, 'BINTI_ROLE'),
    ('STEPPARENT', 'parent', 'step', 'Step Parent', 42, 'BINTI_ROLE'),
    ('AUNTUNCLE', 'aunt', NULL, 'Aunt / Uncle', 50, 'BINTI_ROLE'),
    ('MATNLUE', 'uncle', NULL, 'Uncle', 51, 'BINTI_ROLE'),
    ('COUSIN', 'cousin', NULL, 'Cousin', 52, 'BINTI_ROLE'),
    ('MATERNALCOUSIN', 'cousin', NULL, 'Maternal Cousin', 521, 'BINTI_ROLE'),
    ('FIRSTCOUSIN', 'first_cousin', NULL, 'First Cousin', 53, 'BINTI_ROLE'),
    ('SECONDCOUSIN', 'second_cousin', NULL, 'Second Cousin', 54, 'BINTI_ROLE'),
    ('NIECENEPHEW', 'niece', NULL, 'Niece', 55, 'BINTI_ROLE'),
    ('MATNLNPW', 'nephew', NULL, 'Nephew', 56, 'BINTI_ROLE'),
    ('GRANDCHILD', 'grandchild', NULL, 'Grandchild', 60, 'BINTI_ROLE'),
    ('GRANDPARENT', 'grandparent', NULL, 'Grandparent', 61, 'BINTI_ROLE'),
    ('PATERNALGRANDPARENT', 'grandparent', NULL, 'Paternal Grandparent', 611, 'BINTI_ROLE'),
    ('GRANDPARENTADP', 'grandparent', 'adopted', 'Grandparent (Adoptive)', 62, 'BINTI_ROLE'),
    ('HALFSIBLING', 'sibling', 'half', 'Half Sibling', 70, 'BINTI_ROLE'),
    ('NATURALSIBLING', 'sibling', 'biological', 'Sibling (Biological)', 71, 'BINTI_ROLE'),
    ('STEPSIBLING', 'sibling', 'step', 'Sibling (Step)', 72, 'BINTI_ROLE'),
    ('SIBLINGADP', 'sibling', 'adopted', 'Sibling (Adoptive)', 73, 'BINTI_ROLE'),
    ('FOSTERSIBLING', 'sibling', NULL, 'Sibling (Foster)', 74, 'BINTI_ROLE'),
    ('NATURALCHILD', 'child', 'biological', 'Child (Biological)', 80, 'BINTI_ROLE'),
    ('LEGALCHILD', 'child', NULL, 'Child (Legal)', 81, 'BINTI_ROLE'),
    ('ADOPTEDCHILD', 'child', 'adopted', 'Child (Adoptive)', 82, 'BINTI_ROLE'),
    ('STEPCHILD', 'child', 'step', 'Child (Step)', 83, 'BINTI_ROLE'),
    ('FOSTERCHILD', 'child', NULL, 'Child (Foster)', 84, 'BINTI_ROLE'),
    ('PUTCHLD', 'child', 'alleged', 'Child (Putative)', 85, 'BINTI_ROLE'),
    ('ADOPTIVEPARENT', 'parent', 'adopted', 'Parent (Adoptive)', 90, 'BINTI_ROLE'),
    ('ADPMTHR', 'mother', 'adopted', 'Mother (Adoptive)', 91, 'BINTI_ROLE'),
    ('ADPFTHR', 'father', 'adopted', 'Father (Adoptive)', 92, 'BINTI_ROLE'),
    ('LGLMTHR', 'mother', NULL, 'Mother (Legal)', 93, 'BINTI_ROLE'),
    ('LGLFTHR', 'father', NULL, 'Father (Legal)', 94, 'BINTI_ROLE'),
    ('HSBND', 'partner', 'marriage', 'Spouse', 100, 'BINTI_ROLE'),
    ('WIFE', 'partner', 'marriage', 'Spouse', 101, 'BINTI_ROLE'),
    ('SPOUSE', 'partner', 'marriage', 'Spouse', 102, 'BINTI_ROLE'),
    ('HSBNDX', 'exes', 'marriage', 'Spouse (Ex)', 103, 'BINTI_ROLE'),
    ('WIFEX', 'exes', 'marriage', 'Spouse (Ex)', 104, 'BINTI_ROLE'),
    ('BFRND', 'dating', NULL, 'Dating Partner', 110, 'BINTI_ROLE'),
    ('GFRND', 'dating', NULL, 'Dating Partner', 111, 'BINTI_ROLE'),
    ('PARAMOUR', 'partner', NULL, 'Significant Other / Partner', 112, 'BINTI_ROLE'),
    ('MARRIED', 'married', 'marriage', 'Married', 113, 'BINTI_ROLE'),
    ('DIVORCED', 'divorced', 'marriage', 'Divorced', 114, 'BINTI_ROLE'),
    ('ENGAGED', 'engaged', NULL, 'Engaged', 115, 'BINTI_ROLE'),
    ('DATING', 'dating', NULL, 'Dating', 116, 'BINTI_ROLE'),
    ('COHABITATING', 'cohabitating', NULL, 'Cohabitating', 117, 'BINTI_ROLE'),
    ('OTHERPARTNERSTATUS', 'other_partner_status', NULL, 'Partner (Other)', 118, 'BINTI_ROLE'),
    ('GDNLGL', 'relative', NULL, 'Guardian / Custodian', 120, 'BINTI_ROLE'),
    ('GUARDIAN', 'relative', NULL, 'Guardian / Custodian', 121, 'BINTI_ROLE'),
    ('KIN', 'relative', NULL, 'Kin', 122, 'BINTI_ROLE'),
    ('RELATIVE', 'relative', NULL, 'Relative', 123, 'BINTI_ROLE'),
    ('FICTIVEKIN', 'fictive_kin', NULL, 'Fictive Kin', 124, 'BINTI_ROLE'),
    ('SELF', 'no_relationship', NULL, 'Self', 130, 'BINTI_ROLE'),
    ('FOSPARNT', 'parent', NULL, 'Foster Parent', 131, 'BINTI_ROLE'),
    ('DSSWORKER', 'no_relationship', NULL, 'No Relationship', 140, 'BINTI_ROLE'),
    ('SOWORKR', 'no_relationship', NULL, 'No Relationship', 141, 'BINTI_ROLE'),
    ('OTHER', 'no_relationship', NULL, 'No Relationship', 142, 'BINTI_ROLE'),
    ('NORELATION', 'no_relationship', NULL, 'No Relationship', 143, 'BINTI_ROLE'),
    ('NORLTN', 'no_relationship', NULL, 'No Relationship', 144, 'BINTI_ROLE'),
    ('NORELTVE', 'no_relationship', NULL, 'No Relationship', 145, 'BINTI_ROLE'),
    ('PUTFATHR', 'father', 'alleged', 'Father (Putative)', 150, 'BINTI_ROLE'),
    ('PTMTHR', 'mother', 'alleged', 'Mother (Putative)', 151, 'BINTI_ROLE'),
    ('UKNFTHR', 'father', 'unknown', 'Father (Unknown)', 152, 'BINTI_ROLE'),
    ('UKMTHR', 'mother', 'unknown', 'Mother (Unknown)', 153, 'BINTI_ROLE'),
    ('UNKNWN', 'unknown', NULL, 'Unknown', 154, 'BINTI_ROLE'),
    ('UNKNOWN', 'unknown', NULL, 'Unknown', 155, 'BINTI_ROLE'),
    ('INFORMALCARETAKER', 'relative', NULL, 'Informal Caretaker', 160, 'BINTI_ROLE'),
    ('INFORMALDEPENDENT', 'child', NULL, 'Informal Dependent', 161, 'BINTI_ROLE'),
    ('WARD', 'child', NULL, 'Ward', 162, 'BINTI_ROLE'),
    ('BIOLOGICALCHILD', 'child', 'biological', 'Biological Child', 163, 'BINTI_ROLE'),
    ('HALFBROTHER', 'sibling', 'half', 'Half Brother', 164, 'BINTI_ROLE'),
    ('HALFSISTER', 'sibling', 'half', 'Half Sister', 165, 'BINTI_ROLE'),
    ('MATERNALAUNT', 'aunt', NULL, 'Maternal Aunt', 166, 'BINTI_ROLE'),
    ('PATERNALAUNT', 'aunt', NULL, 'Paternal Aunt', 167, 'BINTI_ROLE'),
    ('BIOLOGICALSISTER', 'sibling', 'biological', 'Biological Sister', 168, 'BINTI_ROLE'),
    ('BIOLOGICALBROTHER', 'sibling', 'biological', 'Biological Brother', 169, 'BINTI_ROLE'),
    ('FATHERINLAW', 'relative', NULL, 'Father-in-law', 170, 'BINTI_ROLE'),
    ('MOTHERINLAW', 'relative', NULL, 'Mother-in-law', 171, 'BINTI_ROLE'),
    ('SISTERINLAW', 'relative', NULL, 'Sister-in-law', 172, 'BINTI_ROLE'),
    ('BROTHERINLAW', 'relative', NULL, 'Brother-in-law', 173, 'BINTI_ROLE'),
    ('DAUGHTERINLAW', 'relative', NULL, 'Daughter in Law', 174, 'BINTI_ROLE'),
    ('SONINLAW', 'relative', NULL, 'Son in Law', 175, 'BINTI_ROLE'),
    ('LEGALSISTER', 'sibling', NULL, 'Legal Sister', 176, 'BINTI_ROLE'),
    ('LEGALBROTHER', 'sibling', NULL, 'Legal Brother', 177, 'BINTI_ROLE'),
    ('LEGALMOTHER', 'mother', NULL, 'Legal Mother', 178, 'BINTI_ROLE'),
    ('LEGALFATHER', 'father', NULL, 'Legal Father', 179, 'BINTI_ROLE'),
    ('MATERNALGRANDCHILD', 'grandchild', NULL, 'Maternal GrandChild', 180, 'BINTI_ROLE'),
    ('PATERNALGRANDCHILD', 'grandchild', NULL, 'Paternal GrandChild', 181, 'BINTI_ROLE'),
    ('MATERNALGRANDPARENT', 'grandparent', NULL, 'Maternal Grandparent', 182, 'BINTI_ROLE'),
    ('MATERNALGREATAUNT', 'great_aunt', NULL, 'Maternal Great Aunt', 183, 'BINTI_ROLE'),
    ('PATERNALGREATAUNT', 'great_aunt', NULL, 'Paternal Great Aunt', 184, 'BINTI_ROLE'),
    ('MATERNALGREATUNCLE', 'great_uncle', NULL, 'Maternal Great Uncle', 185, 'BINTI_ROLE'),
    ('PATERNALGREATUNCLE', 'great_uncle', NULL, 'Paternal Great Uncle', 186, 'BINTI_ROLE'),
    ('MATERNALGREATGRANDCHILD', 'great_grandchild', NULL, 'Maternal Great GrandChild', 187, 'BINTI_ROLE'),
    ('PATERNALGREATGRANDCHILD', 'great_grandchild', NULL, 'Paternal Great GrandChild', 188, 'BINTI_ROLE'),
    ('MATERNALGREATGRANDPARENT', 'great_grandparent', NULL, 'Maternal Great Grandparent', 189, 'BINTI_ROLE'),
    ('PATERNALGREATGRANDPARENT', 'great_grandparent', NULL, 'Paternal Great Grandparent', 190, 'BINTI_ROLE'),
    ('MATERNALNEPHEW', 'nephew', NULL, 'Maternal Nephew', 191, 'BINTI_ROLE'),
    ('PATERNALNEPHEW', 'nephew', NULL, 'Paternal Nephew', 192, 'BINTI_ROLE'),
    ('MATERNALNIECE', 'niece', NULL, 'Maternal Niece', 193, 'BINTI_ROLE'),
    ('PATERNALNIECE', 'niece', NULL, 'Paternal Niece', 194, 'BINTI_ROLE'),
    ('MATERNALSTEPGRANDCHILD', 'grandchild', 'step', 'Maternal Step GrandChild', 195, 'BINTI_ROLE'),
    ('PATERNALSTEPGRANDCHILD', 'grandchild', 'step', 'Paternal Step GrandChild', 196, 'BINTI_ROLE'),
    ('STEPGRANDCHILD', 'grandchild', 'step', 'Step Grandchild', 197, 'BINTI_ROLE'),
    ('STEPGRANDPARENT', 'grandparent', 'step', 'Step Grandparent', 198, 'BINTI_ROLE'),
    ('STEPMATERNALGRANDPARENT', 'grandparent', 'step', 'Step-Maternal Grandparent', 199, 'BINTI_ROLE'),
    ('STEPPATERNALGRANDPARENT', 'grandparent', 'step', 'Step-Paternal Grandparent', 200, 'BINTI_ROLE'),
    ('PATERNALCOUSIN', 'cousin', NULL, 'Paternal Cousin', 201, 'BINTI_ROLE'),
    ('MATERNALUNCLE', 'uncle', NULL, 'Maternal Uncle', 202, 'BINTI_ROLE'),
    ('PATERNALUNCLE', 'uncle', NULL, 'Paternal Uncle', 203, 'BINTI_ROLE'),
    ('RELATIVEOTHER', 'relative', NULL, 'Relative(Other)', 204, 'BINTI_ROLE'),
    ('SPOUSEEX', 'exes', 'marriage', 'Spouse- Ex', 205, 'BINTI_ROLE'),
    ('HUSBANDEX', 'exes', 'marriage', 'Husband-Ex', 206, 'BINTI_ROLE'),
    ('WIFEEX', 'exes', 'marriage', 'Wife-Ex', 207, 'BINTI_ROLE'),
    ('BOYFRIENDEX', 'exes', NULL, 'Boyfriend-Ex', 208, 'BINTI_ROLE'),
    ('GIRLFRIENDEX', 'exes', NULL, 'Girlfriend-EX', 209, 'BINTI_ROLE'),
    ('ADOPTIVECHILD', 'child', 'adopted', 'Adoptive Child', 210, 'BINTI_ROLE'),
    ('GRANDPARENTADOPTIVE', 'grandparent', 'adopted', 'Grandparent Adoptive', 211, 'BINTI_ROLE'),
    ('FOSTERPARENT', 'parent', NULL, 'Foster-Parent', 212, 'BINTI_ROLE'),
    ('FOSTERFATHER', 'father', NULL, 'Foster Father', 213, 'BINTI_ROLE'),
    ('FOSTERMOTHER', 'mother', NULL, 'Foster Mother', 214, 'BINTI_ROLE'),
    ('FATHERTHERAPEUTICFOSTER', 'father', NULL, 'Father Therapeutic Foster', 215, 'BINTI_ROLE'),
    ('MOTHERTHERAPEUTICFOSTER', 'mother', NULL, 'Mother Therapeutic Foster', 216, 'BINTI_ROLE'),
    ('CHILDTHERAPEUTICFOSTER', 'child', NULL, 'Child Therapeutic Foster', 217, 'BINTI_ROLE'),
    ('NONCUSTODIALPARENT', 'parent', NULL, 'Non-Custodial parent', 218, 'BINTI_ROLE'),
    ('NONRELATIVE', 'no_relationship', NULL, 'Non-Relative', 219, 'BINTI_ROLE'),
    ('NORELATIONSHIP', 'no_relationship', NULL, 'No Relationship', 220, 'BINTI_ROLE'),
    ('DAYCAREASSISTANT', 'no_relationship', NULL, 'Daycare Assistant', 221, 'BINTI_ROLE'),
    ('FAMILYCHILDCAREDAYCARESUBSTITUTE', 'no_relationship', NULL, 'Family Child Care / Daycare - Substitute', 222, 'BINTI_ROLE'),
    ('CHILDCARECENTREEMPLOYEE', 'no_relationship', NULL, 'Child care centre employee', 223, 'BINTI_ROLE'),
    ('CHILDCAREHOMEPROVIDER', 'no_relationship', NULL, 'Child care home provider', 224, 'BINTI_ROLE'),
    ('CHILDCAREWORKER', 'no_relationship', NULL, 'Child care worker', 225, 'BINTI_ROLE'),
    ('DAYCARECHILD', 'child', NULL, 'Daycare Child', 226, 'BINTI_ROLE'),
    ('SCHOOLCOUNSELOR', 'no_relationship', NULL, 'School Counselor', 227, 'BINTI_ROLE'),
    ('RESIDENTIALFACILITYSTAFF', 'no_relationship', NULL, 'Residential Facility Staff', 228, 'BINTI_ROLE'),
    ('SUPPORTSTAFF', 'no_relationship', NULL, 'Support Staff', 229, 'BINTI_ROLE'),
    ('TEACHER', 'no_relationship', NULL, 'Teacher', 230, 'BINTI_ROLE'),
    ('STUDENT', 'no_relationship', NULL, 'Student', 231, 'BINTI_ROLE'),
    ('COWORKER', 'no_relationship', NULL, 'Co-Worker', 232, 'BINTI_ROLE'),
    ('FRIEND', 'no_relationship', NULL, 'Friend', 233, 'BINTI_ROLE'),
    ('NEIGHBOR', 'no_relationship', NULL, 'Neighbor', 234, 'BINTI_ROLE'),
    ('RESIDENT', 'no_relationship', NULL, 'Resident', 235, 'BINTI_ROLE'),
    ('GODFATHER', 'fictive_kin', NULL, 'GodFather', 236, 'BINTI_ROLE'),
    ('GODMOTHER', 'fictive_kin', NULL, 'GodMother', 237, 'BINTI_ROLE'),
    ('CUSTODIANLEGAL', 'relative', NULL, 'Custodian(Legal)', 238, 'BINTI_ROLE'),
    ('GUARDIANLEGAL', 'relative', NULL, 'Guardian(Legal)', 239, 'BINTI_ROLE'),
    ('SOCIALWORKER', 'no_relationship', NULL, 'Social Worker', 240, 'BINTI_ROLE'),
    ('SIGNIFICANTOTHERPARTNER', 'partner', NULL, 'Significant Other/Partner', 241, 'BINTI_ROLE')
)
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
SELECT
    m.ref_key,
    91001,
    m.kinship_relationship,
    m.role_label,
    'CW',
    1,
    m.displayorder,
    'CIDM-11295',
    now(),
    'CIDM-11295',
    now(),
    NULL,
    m.parentkey,
    m.lineage_type,
    gen_random_uuid()
FROM mapping_rows m
WHERE NOT EXISTS (
    SELECT 1
    FROM cjams.referencevalues rv
    WHERE rv.referencetypeid = 91001
      AND upper(trim(coalesce(rv.parentkey, ''))) = upper(trim(m.parentkey))
      AND upper(trim(rv.ref_key)) = upper(trim(m.ref_key))
);

DELETE FROM cjams.referencevalues
WHERE referencetypeid = 91002;

WITH gender_rows(ref_key, binti_gender, role_label, displayorder, parentkey) AS (
    VALUES
    ('MALE', 'Male', 'Male', 1000, 'BINTI_GENDER'),
    ('M', 'Male', 'Male (Alias)', 1001, 'BINTI_GENDER'),
    ('FEMALE', 'Female', 'Female', 1002, 'BINTI_GENDER'),
    ('F', 'Female', 'Female (Alias)', 1003, 'BINTI_GENDER'),
    ('TRANSGENDER', 'Transgender', 'Transgender', 1004, 'BINTI_GENDER'),
    ('TG', 'Transgender', 'Transgender (Alias)', 1005, 'BINTI_GENDER'),
    ('TGIM', 'Transgender', 'Transgender (Alias)', 1006, 'BINTI_GENDER'),
    ('TGIF', 'Transgender', 'Transgender (Alias)', 1007, 'BINTI_GENDER'),
    ('NONBINARY', 'Non-binary', 'Non-binary', 1008, 'BINTI_GENDER'),
    ('NB', 'Non-binary', 'Non-binary (Alias)', 1009, 'BINTI_GENDER'),
    ('OTHER', 'Not listed above', 'Not listed above', 1010, 'BINTI_GENDER'),
    ('O', 'Not listed above', 'Not listed above (Alias)', 1011, 'BINTI_GENDER'),
    ('NOTLISTEDABOVE', 'Not listed above', 'Not listed above (Alias)', 1012, 'BINTI_GENDER'),
    ('PREFERNOTTOANSWER', 'Prefer not to answer', 'Prefer not to answer', 1013, 'BINTI_GENDER'),
    ('UNKNOWN', 'Prefer not to answer', 'Prefer not to answer (Alias)', 1014, 'BINTI_GENDER'),
    ('UNK', 'Prefer not to answer', 'Prefer not to answer (Alias)', 1015, 'BINTI_GENDER'),
    ('U', 'Prefer not to answer', 'Prefer not to answer (Alias)', 1016, 'BINTI_GENDER'),
    ('NA', 'Prefer not to answer', 'Prefer not to answer (Alias)', 1017, 'BINTI_GENDER'),
    ('N/A', 'Prefer not to answer', 'Prefer not to answer (Alias)', 1018, 'BINTI_GENDER'),
    ('N', 'Prefer not to answer', 'Prefer not to answer (Alias)', 1019, 'BINTI_GENDER')
)
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
SELECT
    g.ref_key,
    91002,
    g.binti_gender,
    g.role_label,
    'CW',
    1,
    g.displayorder,
    'CIDM-11295',
    now(),
    'CIDM-11295',
    now(),
    NULL,
    g.parentkey,
    NULL,
    gen_random_uuid()
FROM gender_rows g
WHERE NOT EXISTS (
    SELECT 1
    FROM cjams.referencevalues rv
    WHERE rv.referencetypeid = 91002
      AND upper(trim(coalesce(rv.parentkey, ''))) = upper(trim(g.parentkey))
      AND upper(trim(rv.ref_key)) = upper(trim(g.ref_key))
);
