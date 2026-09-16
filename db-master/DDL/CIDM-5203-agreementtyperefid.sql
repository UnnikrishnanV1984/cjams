--CIDM-5203 adding new field (Assistance Agreement Type)

ALTER TABLE cjams.adoptioncaseagreement ADD COLUMN IF NOT EXISTS agreementtyperefid varchar(50) NULL;
comment on column cjams.adoptioncaseagreement.agreementtyperefid is 'to store agreementtyperefid data';


--CIDM-5203 adding new field (Assistance Agreement Type)

ALTER TABLE cjams.adoptioncaseagreementrevision ADD COLUMN IF NOT EXISTS agreementtyperefid varchar(50) NULL;
comment on column cjams.adoptioncaseagreementrevision.agreementtyperefid is 'to store agreementtyperefid data';



--CIDM-5203 adding new field (Assistance Agreement Type)

ALTER TABLE cjams.adoptionagreement ADD COLUMN IF NOT EXISTS agreementtyperefid varchar(50) NULL;
comment on column cjams.adoptionagreement.agreementtyperefid is 'to store agreementtyperefid data';



--CIDM-5203 adding new field (Assistance Agreement Type)

ALTER TABLE cjams.gapagreement ADD COLUMN IF NOT EXISTS agreementtyperefid varchar(50) NULL;
comment on column cjams.gapagreement.agreementtyperefid is 'to store agreementtyperefid data';



--CIDM-5203 adding new field (Assistance Agreement Type)

ALTER TABLE cjams.adoptionagreementrevision ADD COLUMN IF NOT EXISTS agreementtyperefid varchar(50) NULL;
comment on column cjams.adoptionagreementrevision.agreementtyperefid is 'to store agreementtyperefid data';