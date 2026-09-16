-- View: cjams.tb_placement
 DROP VIEW if exists cjams.tb_placement;
-------
DROP SEQUENCE IF EXISTS SQ_PLACEMENT_AUTO_VALIDATION_LOG CASCADE;	
CREATE SEQUENCE SQ_PLACEMENT_AUTO_VALIDATION_LOG
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 10000001
CACHE 1;
-----------------------------------------------------------------------------------------------
delete from TB_PLACEMENT_AUTO_VALIDATION_LOG;
alter table TB_PLACEMENT_AUTO_VALIDATION_LOG drop constraint if exists tb_placement_auto_validation_log_pkey;
ALTER TABLE TB_PLACEMENT_AUTO_VALIDATION_LOG ALTER COLUMN placement_auto_validation_log_id SET DEFAULT nextval('SQ_PLACEMENT_AUTO_VALIDATION_LOG');
ALTER TABLE TB_PLACEMENT_AUTO_VALIDATION_LOG ADD PRIMARY KEY (placement_auto_validation_log_id);
alter table placement alter column tfcifcconversionflag TYPE character(1);

--------

CREATE OR REPLACE VIEW cjams.tb_placement AS
 SELECT pl.alternateid AS placement_id,
    pl.altproviderid AS provider_id,
    NULL::integer AS provider_organization_id,
    tbpc.contract_id AS contract_program_id,
    pl.startdatetime AS entry_dt,
    pl.service_id AS placement_structure_id,
    3047 AS approval_status_cd,
        CASE COALESCE(pl.isvoided, 0)
            WHEN 1 THEN 'Y'::text
            ELSE NULL::text
        END::character varying AS void_sw,
    pl.enddatetime AS exit_dt,
    'N'::character varying AS delete_sw,
    NULL::character varying AS conversion_sw,
    NULL::integer AS payment_header_id,
    pr.cjamspid AS client_id,
    pl.service_id AS rate_structure_id,
    NULL::timestamp without time zone AS placement_change_dt,
    sc.servicecasenumber::bigint AS case_id,
    pl.intakeservicerequestactorid,
    pl.servicecaseid,
    irl.removalid,
    pl.updatedby AS update_user_id,
    pl.updatedon AS update_ts,
    pl.tfcifcconversionflag AS tfc_ifc_conversion_sw,
    pl.overunderflag AS over_under_sw,
    pl.voidapprovaldate AS void_approval_dt,
    pl.starttime AS entry_tm,
    pl.endtime AS exit_tm
   FROM placement pl
     JOIN ( SELECT routing.routingid,
            routing.eventcode,
            routing.fromsecurityusersid,
            routing.tosecurityusersid,
            routing.teamid,
            routing.fromroleid,
            routing.toroleid,
            routing.objectid,
            routing.routingstatustypeid,
            routing.activeflag,
            routing.insertedby,
            routing.insertedon,
            routing.updatedby,
            routing.updatedon,
            routing.isreviewrequest,
            routing.remarks,
            routing.old_id,
            routing.routeddescription,
            routing.servicerequestnumber,
            routing.objecttypekey,
            routing.old_from_id,
            routing.old_to_id,
            routing.principaltype
           FROM routing
          WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'PLTR'::text AND routing.activeflag = 1 AND routing.fromroleid::text = 'CWSP'::text AND routing.toroleid::text = 'CWCW'::text) r ON r.objectid::text = pl.placementid::character varying::text
     JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
     JOIN intakeservicerequestactor isra ON pl.intakeservicerequestactorid = isra.intakeservicerequestactorid AND isra.activeflag = 1
     JOIN person pr ON pr.personid = isra.personid AND pr.activeflag = 1
     JOIN intakeservreqchildremoval irl ON irl.intakeservreqchildremovalid = pl.intakeservreqchildremovalid AND irl.activeflag = 1
     LEFT JOIN tb_provider_contracts tbpc ON tbpc.provider_id = pl.altproviderid AND tbpc.delete_sw = 'N'::bpchar
  WHERE pl.activeflag = 1;


