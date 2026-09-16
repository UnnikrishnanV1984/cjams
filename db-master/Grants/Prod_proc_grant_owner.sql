CREATE OR REPLACE FUNCTION cjams.proc_grant_owner()
 RETURNS text
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
--Revision(s)
-- Manasa Kasula/Vineet : CIDM-10890(Expungement Enhancement changes to add new schema encr)
-- Manasa Kasula/Vineet : CIDM-11118(Expungement Enhancement changes to add new schema expunge and remove encr)
--------------------------------------------------------------------------------------------

--DECLARE
--    r record;
--	v_schema varchar := 'cjams';
--	v_new_owner varchar := '"cjams_prod_admin"';
BEGIN
--    FOR r IN
        --select 'ALTER TABLE "' || table_schema || '"."' || table_name || '" OWNER TO ' || v_new_owner || ';' as a from information_schema.tables where table_schema = v_schema
        --union all
        --select 'ALTER TABLE "' || sequence_schema || '"."' || sequence_name || '" OWNER TO ' || v_new_owner || ';' as a from information_schema.sequences where sequence_schema = v_schema
        --union all
        --select 'ALTER TABLE "' || table_schema || '"."' || table_name || '" OWNER TO ' || v_new_owner || ';' as a from information_schema.views where table_schema = v_schema
        --union all
--        select 'ALTER FUNCTION "'||nsp.nspname||'"."'||p.proname||'"('||pg_get_function_identity_arguments(p.oid)||') OWNER TO ' || v_new_owner || ';' as a 
--		from pg_proc p join pg_namespace nsp ON p.pronamespace = nsp.oid 
--		where nsp.nspname = v_schema and p.proowner::regrole::text = current_user
--    LOOP
--        EXECUTE r.a;
--    END LOOP;
	
	grant all on all tables in schema cjams,prov,expunge TO aps_app_user,cjams_app_user,prov_app_user,cjams_batch_user,cjams_prod_admin;
	grant select,insert,update,delete on all tables in schema cjams,prov,expunge to cjams_prod_readwrite;
	grant select on all tables in schema cjams,prov,expunge to cjams_prod_readonly;
	grant all on all sequences in schema cjams,prov,expunge TO aps_app_user,cjams_app_user,prov_app_user,cjams_batch_user,cjams_prod_admin;
	grant select on all sequences in schema cjams,prov,expunge to cjams_prod_readwrite,cjams_prod_readonly;
	grant execute on all functions in schema cjams,expunge TO aps_app_user,cjams_app_user,prov_app_user,cjams_batch_user,cjams_prod_admin,cjams_prod_readwrite,cjams_prod_readonly;

	RETURN 'GRANTS SUCCESS';
END;

$function$
;
