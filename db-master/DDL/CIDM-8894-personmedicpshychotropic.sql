ALTER TABLE personmedicpshychotropic ADD targetedsymptoms varchar;
ALTER TABLE personmedicpshychotropic ADD targetedother varchar;
ALTER TABLE personmedicpshychotropic ADD informedconsent varchar;
ALTER TABLE personmedicpshychotropic ADD renewal bool;
ALTER TABLE cjams.personmedicpshychotropic ADD specifyfrequencyhour varchar NULL;
ALTER TABLE cjams.personmedicpshychotropic ADD specifyduration varchar NULL;
ALTER TABLE cjams.personmedicpshychotropic ADD otherspecifyduration varchar NULL;
ALTER TABLE personmedicpshychotropic ADD otherreason varchar;
ALTER TABLE personmedicpshychotropic ADD  if not exists dateMedicationStarted timestamp;
ALTER TABLE personmedicpshychotropic ADD if not exists isPrescriberCheck bool;
ALTER TABLE cjams.personmedicpshychotropic ADD compliantcomments varchar NULL;
ALTER TABLE cjams.personmedicpshychotropic ADD dateofrefill date NULL;
ALTER TABLE cjams.personmedicpshychotropic ADD changeofdate date NULL;


COMMENT ON COLUMN cjams.personmedicpshychotropic.dateMedicationStarted IS 'Date Medication Start ';
COMMENT ON COLUMN cjams.personmedicpshychotropic.targetedsymptoms IS 'Medication Targeted symptoms ';
COMMENT ON COLUMN cjams.personmedicpshychotropic.targetedother IS 'Medication Targeted symptoms other';
COMMENT ON COLUMN cjams.personmedicpshychotropic.informedconsent IS 'Medication informed consent';
COMMENT ON COLUMN cjams.personmedicpshychotropic.uploadedfiles IS 'If medic pshychotropic is renewal then true';
COMMENT ON COLUMN cjams.personmedicpshychotropic.otherreason IS 'If medic pshychotropic is Other Frequency ';
COMMENT ON COLUMN cjams.personmedicpshychotropic.compliantcomments IS 'To store the compliant comments';
COMMENT ON COLUMN cjams.personmedicpshychotropic.dateofrefill IS 'To store date of refill date';
COMMENT ON COLUMN cjams.personmedicpshychotropic.changeofdate IS 'To store date of change of date';
COMMENT ON COLUMN cjams.personmedicpshychotropic.specifyfrequencyhour IS 'To store the specify frequency hour';
COMMENT ON COLUMN cjams.personmedicpshychotropic.specifyduration IS 'To store the specify frequency hour';
COMMENT ON COLUMN cjams.personmedicpshychotropic.otherspecifyduration IS 'To store the other specifyduration data';