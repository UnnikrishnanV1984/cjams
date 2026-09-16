ALTER TABLE cjams.personbehavioralhealth ALTER COLUMN clinicianname TYPE character varying;
ALTER TABLE cjams.personbehavioralhealth ALTER COLUMN currentdiagnoses TYPE character varying;
ALTER TABLE cjams.personbehavioralhealth ALTER COLUMN reportname TYPE character varying;
ALTER TABLE cjams.personbehavioralhealth ALTER COLUMN email TYPE character varying;
ALTER TABLE cjams.personbehavioralhealth ALTER COLUMN evaluationby TYPE character varying;
ALTER TABLE cjams.personbehavioralhealth ALTER COLUMN phobiacomments TYPE character varying;


ALTER TABLE cjams.personhlthelimination ALTER COLUMN comments TYPE character varying;
ALTER TABLE cjams.personhlthelimination ALTER COLUMN specialcomments TYPE character varying;
ALTER TABLE cjams.personhlthelimination ALTER COLUMN otherspecify TYPE character varying;


ALTER TABLE cjams.personfmlymdclhstry ALTER COLUMN othernotes TYPE character varying;
ALTER TABLE cjams.personfmlymdclhstry ALTER COLUMN providedbynotes TYPE character varying;
ALTER TABLE cjams.personfmlymdclhstry ALTER COLUMN famhistclientnotes TYPE character varying;
ALTER TABLE cjams.personfmlymdclhstry ALTER COLUMN comments TYPE character varying;


ALTER TABLE cjams.personhlthfeeding ALTER COLUMN comments TYPE character varying;


ALTER TABLE cjams.personhospitalization ALTER COLUMN diagnosistx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN commentstx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN adrdirectiontx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN adrforeigntx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN infocommentstx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN infoprovidedbytx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN typekey TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN reasontypekey TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN adrunitnotx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN adremailtx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN adrurltx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN adrothercontacttx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN adrstreettx TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN hospital_address1 TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN hospital_address2 TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN hospitalnm TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN hospitalization_type TYPE character varying;
ALTER TABLE cjams.personhospitalization ALTER COLUMN hospitalization_reason TYPE character varying;


ALTER TABLE cjams.Personmedicalcondition ALTER COLUMN recordedby TYPE character varying;
ALTER TABLE cjams.Personmedicalcondition ALTER COLUMN medicalconditiontext TYPE character varying;
ALTER TABLE cjams.Personmedicalcondition ALTER COLUMN medicalconditiontypekey TYPE character varying;
ALTER TABLE cjams.Personmedicalcondition ALTER COLUMN severitysymptomkey TYPE character varying;
ALTER TABLE cjams.Personmedicalcondition ALTER COLUMN wrkrtemplatecode TYPE character varying;
ALTER TABLE cjams.Personmedicalcondition ALTER COLUMN medicalconditionstatindc TYPE character varying;


ALTER TABLE cjams.Personmedicpshychotropic ALTER COLUMN medicationcomments TYPE character varying;
ALTER TABLE cjams.Personmedicpshychotropic ALTER COLUMN monitoring TYPE character varying;
ALTER TABLE cjams.Personmedicpshychotropic ALTER COLUMN dosage TYPE character varying;
ALTER TABLE cjams.Personmedicpshychotropic ALTER COLUMN frequency TYPE character varying;
ALTER TABLE cjams.Personmedicpshychotropic ALTER COLUMN prescribingdoctor TYPE character varying;
ALTER TABLE cjams.Personmedicpshychotropic ALTER COLUMN medicationname TYPE character varying;
ALTER TABLE cjams.Personmedicpshychotropic ALTER COLUMN prescriptionreasontypekey TYPE character varying;
ALTER TABLE cjams.Personmedicpshychotropic ALTER COLUMN informationsourcetypekey TYPE character varying;


ALTER TABLE cjams.personhlthmobilityspeech ALTER COLUMN comments TYPE character varying;


ALTER TABLE cjams.persondisability ALTER COLUMN hygienekey TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN specialkey TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN comments TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN diagnoiseddisabilitynotes TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN evaluatorname TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN disabilityconditiontypekey TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN disabilitytype TYPE character varying;
ALTER TABLE cjams.persondisability ALTER COLUMN disabilitytypekey TYPE character varying;


ALTER TABLE cjams.personphycisianinfo ALTER COLUMN othinscompanytext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN othinspolicyholdertext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN othphysicianname_text TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN othphysicianpracttext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN facility TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN address1 TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN address2 TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN otherspeciality TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN degreetype TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN psychrasesloctntext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN psychrhosploctntext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN psychlasesloctntext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN counselingloctntext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN addictionloctntext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN name TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN mcotext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN othinsmcotext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN othinspolicynumbtext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN phone TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN countyname TYPE character varying;


ALTER TABLE cjams.personphycisianinfo ALTER COLUMN marylandmamcocode TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN physicianfaxtext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN othphysicianphonetext TYPE character varying;
ALTER TABLE cjams.personphycisianinfo ALTER COLUMN othphysicianfaxtext TYPE character varying;


ALTER TABLE cjams.personsexualinfo ALTER COLUMN birthcontrol TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN sicomments TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN sextransdis TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN genderidentityspecify TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN sexualorientationcomments TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN specify TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN infoprovidedby TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN infoclientkey TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN sexualorientationkey TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN infoprovidedbyrelationkey TYPE character varying;
ALTER TABLE cjams.personsexualinfo ALTER COLUMN genderidentity TYPE character varying;


ALTER TABLE cjams.personhlthsleeping ALTER COLUMN comments TYPE character varying;































