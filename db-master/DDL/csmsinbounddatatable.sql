CREATE TABLE IF NOT exists ivecsmsinbounddata (

ivecsmsinboundid uuid NOT NULL DEFAULT gen_random_uuid(),
cisclientid varchar(12) NOT NULL,
inputjson json NULL,	
mdm_id varchar(50) NOT NULL,
member_id  varchar(10) NULL,
socounty varchar(50) NOT NULL,
sostate varchar(12) NOT NULL,
sonumber varchar(50)  NOT NULL,
sodate timestamp NULL,
sostatusdate timestamp NULL,
sostatustypekey varchar(50) NULL,
sopaymentamount int4 null,
sopaymentfreqtypekey varchar(50) NULL,
sodatasource varchar(10) null,
insertedon timestamp NULL DEFAULT now(),
updatedon timestamp NULL DEFAULT now(),
CONSTRAINT ivecsesinbounddata_pkey PRIMARY KEY (ivecsmsinboundid)
);