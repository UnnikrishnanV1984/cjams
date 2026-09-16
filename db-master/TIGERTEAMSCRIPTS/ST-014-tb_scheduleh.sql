CREATE TABLE cjams.tb_scheduleh (
	familysize numeric null,
	schedulehid uuid NOT NULL DEFAULT gen_random_uuid(),
	maximumallowablepayment numeric NULL,
	standardofneed numeric NULL,
	grossincomeoneeightyfive numeric NULL,
	basicneed numeric NULL,
	CONSTRAINT tb_scheduleh_pk PRIMARY KEY (schedulehid)
);
CREATE INDEX tb_scheduleh_schedulehid_idx ON cjams.tb_scheduleh (schedulehid);