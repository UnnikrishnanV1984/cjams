-- CIDM-10293 Add column v_addroles (array of character varying)
ALTER TABLE cjams.inputfromsailpoint
ADD COLUMN v_addroles character varying[];

COMMENT ON COLUMN cjams.inputfromsailpoint.v_addroles IS 'Array of role type keys to be added for the user.';

-- CIDM-10293 Add column v_removeroles (array of character varying)
ALTER TABLE cjams.inputfromsailpoint
ADD COLUMN v_removeroles character varying[];

COMMENT ON COLUMN cjams.inputfromsailpoint.v_removeroles IS 'Array of role type keys to be removed for the user.';
