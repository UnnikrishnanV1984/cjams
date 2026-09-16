--03-27/2023 Mounika Gudise- Addded isbioadoptedflag column to check whether the client is biocase or not (CIDM-6864)

ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS isbioadoptedflag int4 null;

comment on column person.isbioadoptedflag IS 'Flag to identify the adopted person';