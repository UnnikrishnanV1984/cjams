ALTER TABLE usernotification ADD COLUMN IF NOT EXISTS objecttype  varchar NULL;
ALTER TABLE usernotification ADD COLUMN IF NOT EXISTS objectcasenumber  varchar NULL;