--CIDM-5312 adding new field (leastrestrictiveplacement)


ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS leastrestrictiveplacement varchar NULL;
comment on column cjams.placement.leastrestrictiveplacement is 'to store Least Restrictive Placement for the child information';


ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS leastrestrictiveplacement varchar NULL;
comment on column cjams.placementrevision.leastrestrictiveplacement is 'to store Least Restrictive Placement for the child information';