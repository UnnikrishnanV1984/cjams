ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS voidreasontypekey varchar(100) NULL;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS voidremarks varchar(1000) NULL;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS enddate timestamp null;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS endtime varchar(30) NULL;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS exittypekey varchar(100) NULL;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS remarks varchar(1000) NULL;