DROP TABLE IF EXISTS cjams.tb_audit_householdmember;

CREATE TABLE cjams.tb_audit_householdmember (
	householdmemberid uuid NOT NULL,
	auditperiodid bigserial NOT NULL,
	unearnedincometype varchar(50) NULL,
	unearnedincomeamount numeric NULL,
	isincomedeemed varchar(50) NULL,
	supportexpenseamount numeric NULL,
	clientid varchar(50) NULL,
	inau varchar(50) NULL,
	earnedincomeamount numeric NULL,
	CONSTRAINT pk_audit_householdmember PRIMARY KEY (householdmemberid),
	CONSTRAINT fk_audit_periods FOREIGN KEY (auditperiodid) REFERENCES tb_ive_fostercare_audit(auditperiodid)
);

-- Permissions

ALTER TABLE cjams.tb_audit_householdmember OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_audit_householdmember TO welfareadmin;