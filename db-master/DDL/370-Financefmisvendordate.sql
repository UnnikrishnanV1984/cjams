
ALTER TABLE cjams.tb_fmis_pmnt_vendor_dt ALTER COLUMN vendor_file_1_dt TYPE date USING vendor_file_1_dt::date;
ALTER TABLE cjams.tb_fmis_pmnt_vendor_dt ALTER COLUMN pay_file_1_dt TYPE date USING pay_file_1_dt::date;
ALTER TABLE cjams.tb_fmis_pmnt_vendor_dt ALTER COLUMN vendor_file_2_dt TYPE date USING vendor_file_2_dt::date;
ALTER TABLE cjams.tb_fmis_pmnt_vendor_dt ALTER COLUMN pay_file_2_dt TYPE date USING pay_file_2_dt::date;