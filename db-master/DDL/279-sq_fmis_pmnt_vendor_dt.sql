-- SEQUENCE: public.sq_fmis_pmnt_vendor_dt
DROP SEQUENCE if exists sq_fmis_pmnt_vendor_date;
CREATE SEQUENCE sq_fmis_pmnt_vendor_date start with 13 increment by 1;



ALTER TABLE cjams.tb_fmis_pmnt_vendor_dt ALTER COLUMN fmis_pmnt_vendor_dt_id SET DEFAULT nextval('sq_fmis_pmnt_vendor_date');
ALTER TABLE cjams.tb_fmis_pmnt_vendor_dt ALTER COLUMN create_user_id SET DEFAULT 'finance';
ALTER TABLE cjams.tb_fmis_pmnt_vendor_dt ALTER COLUMN update_user_id SET DEFAULT 'finance';

