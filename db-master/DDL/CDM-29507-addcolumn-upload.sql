alter table cjams.personmedicpshychotropic add column uploadedFiles json null;
COMMENT ON COLUMN cjams.personmedicpshychotropic.uploadedFiles IS 'to store document upload details';