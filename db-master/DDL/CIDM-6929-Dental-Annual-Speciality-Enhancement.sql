alter table personexamination add column if not exists isannualhealthvisit boolean;
COMMENT ON COLUMN cjams.personexamination.isannualhealthvisit IS 'Flag to know whether health exam is for Annual Health Visit';

alter table personexamination add column if not exists issemiannualdentalvisit boolean;
COMMENT ON COLUMN cjams.personexamination.issemiannualdentalvisit IS 'Flag to know whether health exam is for Semi-Annual Dental Visit';