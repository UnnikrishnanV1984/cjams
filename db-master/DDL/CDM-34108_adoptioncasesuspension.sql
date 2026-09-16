ALTER TABLE cjams.adoptioncasesuspensionrevision ALTER COLUMN suspensionremarks TYPE text USING suspensionremarks::text;
ALTER TABLE cjams.adoptioncasesuspension ALTER COLUMN suspensionremarks TYPE text USING suspensionremarks::text;
