

DROP TABLE IF EXISTS cjams.userreference;

CREATE TABLE cjams.userreference (
userreferenceid uuid NOT NULL DEFAULT gen_random_uuid(),
securityusersid varchar(50) NULL,
objectid varchar(50) NOT NULL,
objecttypekey varchar(25) NULL,
casenumber varchar(25) NULL,
legalguardian varchar(100) NULL,
worker varchar(100) NULL,
receiveddate timestamp NOT NULL DEFAULT now(),
activeflag int4 NULL DEFAULT 1,
insertedby varchar(50) NULL,
insertedon timestamp NOT NULL DEFAULT now(),
updatedby varchar(50) NULL,
updatedon timestamp NULL,
effectivedate timestamp NOT NULL DEFAULT now(),
expirationdate timestamp NULL,
old_id varchar(50) NULL,
CONSTRAINT pk_userreference PRIMARY KEY (userreferenceid),
CONSTRAINT fk_userreference_userprofile FOREIGN KEY (securityusersid) REFERENCES userprofile(securityusersid)
);