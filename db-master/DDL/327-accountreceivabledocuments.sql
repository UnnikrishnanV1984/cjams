DROP TABLE IF EXISTS cjams.accountreceivabledocuments;

CREATE TABLE cjams.accountreceivabledocuments (
	accountreceivabledocumentsid uuid NOT NULL DEFAULT gen_random_uuid(),	 
	providerid character varying  NULL,	 	 
	receivableid int8  NULL,
	receivabledetailid int8  NULL,	
	receivablebalance numeric(10,2) NULL,
	collectionstatus character varying,
	uploadedby uuid,
	uploadeddate timestamp(6) without time zone NOT NULL DEFAULT now() ,
	uploadpath json NULL,	 
	activeflag int4 NULL DEFAULT 1,
	filename character varying
);