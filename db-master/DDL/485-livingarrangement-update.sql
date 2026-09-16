update cjams.livingarrangement set caregiverclientid = primarycaregiverid ::uuid where primarycaregiverid is not null;
update cjams.livingarrangement set partnerid = secondarycaregiverid ::uuid where secondarycaregiverid is not null;


ALTER TABLE cjams.livingarrangement DROP COLUMN IF EXISTS primarycaregiverid;
ALTER TABLE cjams.livingarrangement DROP COLUMN IF EXISTS secondarycaregiverid;
