--New tables for the stories B-120023,B-120024- quick add person card

ALTER TABLE cjams.quickpersonsubstconfig ADD COLUMN IF NOT EXISTS substanceclasskey varchar(50) NULL;
ALTER TABLE cjams.quickpersonsubstconfig drop column substanceexposednewbornsourcetypekey;
ALTER TABLE cjams.quickpersonsubstconfig ADD COLUMN IF NOT EXISTS substanceexposednewbornsourcetypekey varchar(50) NULL;
