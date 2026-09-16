--CIDM-5301 adding new field (adoption suspension)

ALTER TABLE cjams.adoptioncasesuspension DROP justification IF EXISTS ;

ALTER TABLE cjams.adoptioncasesuspension DROP ssaapprovaloverridedate IF EXISTS;

ALTER TABLE cjams.adoptioncasesuspensionrevision DROP justification IF EXISTS ;

ALTER TABLE cjams.adoptioncasesuspensionrevision DROP ssaapprovaloverridedate IF EXISTS ;


-- ALTER TABLE cjams.adoptioncasesuspension ADD justification character varying NULL;
-- comment on column cjams.adoptioncasesuspension.justification is 'to store justification comments';

-- ALTER TABLE cjams.adoptioncasesuspension ADD ssaapprovaloverridedate TIMESTAMP NULL;
-- comment on column cjams.adoptioncasesuspension.ssaapprovaloverridedate is 'to store ssaapprovaloverride date';

-- ALTER TABLE cjams.adoptioncasesuspensionrevision ADD justification character varying NULL;
-- comment on column cjams.adoptioncasesuspensionrevision.justification is 'to store justification comments';

-- ALTER TABLE cjams.adoptioncasesuspensionrevision ADD ssaapprovaloverridedate TIMESTAMP NULL;
-- comment on column cjams.adoptioncasesuspensionrevision.ssaapprovaloverridedate is 'to store ssaapprovaloverride date';

