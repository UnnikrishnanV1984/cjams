alter table investigationallegation ADD column if not exists fatalitycomments varchar;

COMMENT ON COLUMN cjams.investigationallegation.fatalitycomments IS 'Updtaed comments by appeal worker if any changes were made in the dropdown values';