ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS fostercarehome CHARACTER VARYING;
comment on column cjams.livingarrangement.fostercarehome is 'to store fostercare home picklist values in living arrangement';

ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS fostercarenonfoster CHARACTER VARYING;
comment on column cjams.livingarrangement.fostercarehome is 'to store fostercare nonfoster setting picklist value in living arrangement';

ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS fostercomments CHARACTER VARYING;
comment on column cjams.livingarrangement.fostercomments  is 'to store fostercare realted comments in Livingarrangement';

