CREATE OR REPLACE FUNCTION cjams.proc_grant_owner()
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

BEGIN

grant all on all tables in schema defecttracking, cjams, prov TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_dev2_admin, cjams_dev2_readwrite;
grant all on all sequences in schema defecttracking, cjams, prov TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_dev2_admin, cjams_dev2_readwrite;
grant execute on all functions in schema defecttracking, cjams, prov TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_dev2_admin, cjams_dev2_readwrite, cjams_dev2_readonly;

grant select on all tables in schema defecttracking, cjams, prov TO cjams_dev2_readonly;
grant select on all sequences in schema defecttracking, cjams, prov TO cjams_dev2_readonly;

RETURN 'GRANTS SUCCESS';
END;
$BODY$;

