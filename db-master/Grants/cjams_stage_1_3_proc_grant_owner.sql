-- DROP FUNCTION cjams.proc_grant_owner();

CREATE OR REPLACE FUNCTION cjams.proc_grant_owner()
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE

v_databasename varchar;

BEGIN

select  current_database()  into v_databasename;

If v_databasename='mdtcjamsdbs_stage3' then

grant all on all tables in schema defecttracking, cjams, prov, integration, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage3_admin, cjams_stage3_readwrite;
grant all on all sequences in schema defecttracking, cjams, prov, integration, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage3_admin, cjams_stage3_readwrite;
grant execute on all functions in schema defecttracking, cjams, prov, integration, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage3_admin, cjams_stage3_readwrite, cjams_stage3_readonly;

grant select on all tables in schema defecttracking, cjams, prov, integration, expunge TO cjams_stage3_readonly;
grant select on all sequences in schema defecttracking, cjams, prov, integration, expunge TO cjams_stage3_readonly;

End if;

If v_databasename='mdtcjamsdbs_stage1'
Then

grant all on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage1_admin, cjams_stage1_readwrite;
grant all on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage1_admin, cjams_stage1_readwrite;
grant execute on all functions in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage1_admin, cjams_stage1_readwrite, cjams_stage1_readonly;

grant select on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO cjams_stage1_readonly;
grant select on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO cjams_stage1_readonly;

End if;

If v_databasename='mdtcjamsdbs_developers'
Then

grant all on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_developer_admin,cjams_developer_readwrite;
grant all on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_developer_admin,cjams_developer_readwrite;
grant execute on all functions in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_developer_admin,cjams_developer_readwrite, cjams_developer_readonly;

grant select on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO cjams_developer_readonly;
grant select on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO cjams_developer_readonly;

End if;

If v_databasename='mdtcjamsdbs_stage4'
Then

grant all on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage4_admin, cjams_stage4_readwrite;
grant all on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage4_admin, cjams_stage4_readwrite;
grant execute on all functions in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stage4_admin, cjams_stage4_readwrite, cjams_stage4_readonly;

grant select on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO cjams_stage4_readonly;
grant select on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO cjams_stage4_readonly;

End if;

If v_databasename='mdtcjamsdbs_stage2'
Then

grant all on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, svc_cjams_stg2_admin,svc_cjams_stg2_rwx_role,usr_cjams_stg2_rwx_role;
grant all on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, svc_cjams_stg2_admin,svc_cjams_stg2_rwx_role,usr_cjams_stg2_rwx_role;
grant execute on all functions in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, svc_cjams_stg2_admin,svc_cjams_stg2_rwx_role,usr_cjams_stg2_rwx_role, svc_cjams_stg2_read_role,usr_cjams_stg2_read_role;

grant select on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO svc_cjams_stg2_read_role,usr_cjams_stg2_read_role;
grant select on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO svc_cjams_stg2_read_role,usr_cjams_stg2_read_role;

End if;

If v_databasename='mdtcjamsdbs_qa'
Then

grant all on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, svc_cjams_qa_admin,svc_cjams_qa_rwx_role,usr_cjams_qa_rwx_role;
grant all on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, svc_cjams_qa_admin,svc_cjams_qa_rwx_role,usr_cjams_qa_rwx_role;
grant execute on all functions in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, svc_cjams_qa_admin,svc_cjams_qa_rwx_role,usr_cjams_qa_rwx_role, svc_cjams_qa_read_role,usr_cjams_qa_read_role;

grant select on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO svc_cjams_qa_read_role,usr_cjams_qa_read_role;
grant select on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO svc_cjams_qa_read_role,usr_cjams_qa_read_role;

End if;

If v_databasename='mdtcjamsdbs_training'
Then

grant all on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stgtrn_admin,usr_cjams_stgtrn_rw_role,svc_cjams_stgtrn_rw_role;
grant all on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stgtrn_admin,usr_cjams_stgtrn_rw_role,svc_cjams_stgtrn_rw_role;
grant execute on all functions in schema defecttracking, cjams, prov, integration, encr, expunge TO aps_app_user, cjams_app_user, prov_app_user, cjams_batch_user, cjams_stgtrn_admin,usr_cjams_stgtrn_rw_role,svc_cjams_stgtrn_rw_role, svc_cjams_stgtrn_ro_role,usr_cjams_stgtrn_ro_role;

grant select on all tables in schema defecttracking, cjams, prov, integration, encr, expunge TO svc_cjams_stgtrn_ro_role,usr_cjams_stgtrn_ro_role;
grant select on all sequences in schema defecttracking, cjams, prov, integration, encr, expunge TO svc_cjams_stgtrn_ro_role,usr_cjams_stgtrn_ro_role;

End if;

RETURN 'GRANTS SUCCESS';
END;

$function$
;

