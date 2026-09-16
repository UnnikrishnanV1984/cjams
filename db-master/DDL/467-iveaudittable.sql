 
ALTER TABLE cjams.tb_ive_fostercare_audit
ADD COLUMN supervisorsignature text;
 

ALTER TABLE cjams.tb_ive_fostercare_audit
ADD COLUMN specialistsignature text;


ALTER TABLE cjams.tb_ive_fostercare_audit
ADD COLUMN supervisorname character varying;
 

ALTER TABLE cjams.tb_ive_fostercare_audit
ADD COLUMN specialistname character varying;


ALTER TABLE cjams.tb_ive_fostercare_audit
ADD COLUMN supervisorsubmissiondate timestamp without time zone;
 

ALTER TABLE cjams.tb_ive_fostercare_audit
ADD COLUMN specialistsubmissiondate timestamp without time zone;

