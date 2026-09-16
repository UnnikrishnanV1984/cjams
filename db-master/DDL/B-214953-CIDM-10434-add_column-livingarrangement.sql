ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS hotelorother CHARACTER VARYING;
ALTER TABLE cjams.livingarrangement ADD column if not exists agency1to1 boolean;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS agency1to1desc CHARACTER VARYING;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS agency1to1explaination CHARACTER VARYING;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS dailyrate NUMERIC(10,2);

ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS ratetype CHARACTER VARYING;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS agency1to1rate NUMERIC(10,2);


comment on column cjams.livingarrangement.hotelorother is 'To store Hotel/LDSS/Shelter/Other Name values in living arrangement';
comment on column cjams.livingarrangement.agency1to1 is 'Question to identify if there a 1 to 1 Agency assigned to this child';
comment on column cjams.livingarrangement.agency1to1desc is 'name of the 1 to 1 agency';
comment on column cjams.livingarrangement.agency1to1explaination is 'Reason why there is no 1 to 1 agency';
comment on column cjams.livingarrangement.dailyrate is 'To store the daily rate of living arrangement';

comment on column cjams.livingarrangement.ratetype is 'Picklist value to save agency rate type';
comment on column cjams.livingarrangement.agency1to1rate is 'To store the agency 1 to 1 rate of living arrangement';