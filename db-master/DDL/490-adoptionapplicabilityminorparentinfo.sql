ALTER TABLE cjams.adoptionapplicabilityminorparentinfo ADD COLUMN IF NOT EXISTS minorparentclientid bigint NULL;
ALTER TABLE cjams.adoptionapplicabilityminorparentinfo ADD COLUMN IF NOT EXISTS istheminorparentreceivingivefc varchar NULL;
ALTER TABLE cjams.adoptionapplicabilityminorparentinfo ADD COLUMN IF NOT EXISTS minorparentivefostercarestatus varchar NULL;
ALTER TABLE cjams.adoptionapplicabilityminorparentinfo ADD COLUMN IF NOT EXISTS minorparentivefostercarestartdate timestamp NULL;
ALTER TABLE cjams.adoptionapplicabilityminorparentinfo ADD COLUMN IF NOT EXISTS dateoflatestpaymentofminorparentivefostercare timestamp NULL;
