--CIDM-5329 adding new field (gap case)

ALTER TABLE cjams.gapsuspension DROP justification IF EXISTS ;

ALTER TABLE cjams.gapsuspension DROP ssaapprovaloverridedate IF EXISTS ;

ALTER TABLE cjams.gapsuspensionrevision DROP justification IF EXISTS ;

ALTER TABLE cjams.gapsuspensionrevision DROP ssaapprovaloverridedate IF EXISTS ;

-- ALTER TABLE cjams.gapsuspension ADD justification character varying NULL;
-- comment on column cjams.gapsuspension.justification is 'to store justification comments';

-- ALTER TABLE cjams.gapsuspension ADD ssaapprovaloverridedate TIMESTAMP NULL;
-- comment on column cjams.gapsuspension.ssaapprovaloverridedate is 'to store ssaapprovaloverride date';

-- ALTER TABLE cjams.gapsuspensionrevision ADD justification character varying NULL;
-- comment on column cjams.gapsuspensionrevision.justification is 'to store justification comments';

-- ALTER TABLE cjams.gapsuspensionrevision ADD ssaapprovaloverridedate TIMESTAMP NULL;
-- comment on column cjams.gapsuspensionrevision.ssaapprovaloverridedate is 'to store ssaapprovaloverride date';