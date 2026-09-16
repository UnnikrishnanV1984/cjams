DROP FUNCTION IF EXISTS cjams.releasenotesaccesscheck(character varying);
CREATE OR REPLACE FUNCTION cjams.releasenotesaccesscheck(v_securityusersid character varying)
 RETURNS TABLE(approver boolean, admin boolean)
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_approver boolean; 
	v_admin	 boolean;
BEGIN

	select case when count(*) > 0 then true else false end into v_approver
		from cjams.muser m
			join cjams.userresource ur on ur.userid = m.id and ur.activeflag = 1
			join cjams.permissiongroup pg on pg.permissiongroupid  = ur.permissiongroupid and pg.activeflag = 1
		where pg.permissiongroupname IN ('RELEASE_APPROVER', 'RELEASE_ADMIN')
			and m.securityusersid = v_securityusersid; 
			
	select case when count(*) > 0 then true else false end into v_admin
		from cjams.muser m
			join cjams.userresource ur on ur.userid = m.id and ur.activeflag = 1
			join cjams.permissiongroup pg on pg.permissiongroupid  = ur.permissiongroupid and pg.activeflag = 1
		where pg.permissiongroupname = 'RELEASE_ADMIN'
			and m.securityusersid = v_securityusersid; 
		
	RETURN QUERY
		SELECT v_approver, v_admin;
			
END;

$function$
;
