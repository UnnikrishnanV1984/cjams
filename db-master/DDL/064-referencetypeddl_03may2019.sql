DELETE FROM referencetype
WHERE referencetypeid=142;

ALTER TABLE progressnote
ADD COLUMN IF NOT EXISTS "initiationindicator" boolean;
