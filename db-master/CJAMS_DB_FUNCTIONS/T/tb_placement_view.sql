DROP VIEW IF EXISTS cjams.tb_placement;
CREATE OR REPLACE VIEW cjams.tb_placement
AS SELECT DISTINCT pl.alternateid AS placement_id,
    pl.altproviderid AS provider_id,
    pl.providerorganizationid AS provider_organization_id,
    pl.contractprogramid AS contract_program_id,
    pl.startdatetime AS entry_dt,
    pl.service_id AS placement_structure_id,
        CASE
            WHEN (( SELECT count(*) AS count
               FROM routing
              WHERE routing.routingstatustypeid = 16 AND routing.eventcode::text = 'PLTR'::text AND routing.activeflag = 1 AND routing.objectid::text = pl.placementid::character varying::text)) > 0 THEN '3047'::character varying
            ELSE NULL::character varying
        END AS approval_status_cd,
        CASE COALESCE(pl.isvoided, 0)
            WHEN 1 THEN 'Y'::text
            ELSE NULL::text
        END::character varying AS void_sw,
    pl.enddatetime AS exit_dt,
    'N'::character varying AS delete_sw,
    NULL::character varying AS conversion_sw,
    pl.paymentheaderid AS payment_header_id,
    pr.cjamspid AS client_id,
    pl.service_id AS rate_structure_id,
    NULL::timestamp without time zone AS placement_change_dt,
    sc.servicecasenumber::bigint AS case_id,
    pl.intakeservicerequestactorid,
    pl.servicecaseid,
    irl.removalid AS removal_id,
    pl.tfcifcconversionflag AS tfc_ifc_conversion_sw,
    CASE COALESCE(pl.overunderflag, '0')
            WHEN '1' THEN 'Y'::text
            WHEN '0' THEN 'N'::text
            --ELSE NULL::text
        END::character varying AS over_under_sw,
    pl.voidapprovaldate AS void_approval_dt,
    pl.starttime AS entry_tm,
    pl.endtime AS exit_tm,
    pl.intakeserviceid,
    pl.voidreasontypekey AS void_reason_cd,
        CASE
            WHEN pl.courtorderedflag = 1 THEN 'Y'::character(1)
            WHEN pl.courtorderedflag = 0 THEN 'N'::character(1)
            ELSE NULL::character(1)
        END AS court_ordered_sw,
    pl.origplacementid AS orig_placement_id,
    pl.voidapprovalstatustypekey AS void_approval_status_cd,
    pl.exitreasontypekey AS exit_reason_cd,
    pl.insertedby AS create_user_id,
    pl.insertedon AS create_ts,
    pl.updatedby AS update_user_id,
    pl.updatedon AS update_ts,
    pl.caseid,
    pl.clientmergeid AS client_merge_id,
        CASE
            WHEN pl.datavalidflag = 1 THEN 'Y'::character(1)
            WHEN pl.datavalidflag = 0 THEN 'N'::character(1)
            ELSE NULL::character(1)
        END AS data_valid_sw,
    pl.exitreasontypekey AS exit_explanation_tx,
    pl.exittypekey AS exit_type_cd,
    pl.facilityid AS facility_id,
    pl.fiscalcategorytypekey AS fiscal_category_cd,
        CASE
            WHEN pl.icpcapprovedflag = 1 THEN 'Y'::character(1)
            WHEN pl.icpcapprovedflag = 0 THEN 'N'::character(1)
            ELSE NULL::character(1)
        END AS icpc_approved_sw,
        CASE
            WHEN pl.medicaidpaidflag = 1 THEN 'Y'::character(1)
            WHEN pl.medicaidpaidflag = 0 THEN 'N'::character(1)
            ELSE NULL::character(1)
        END AS medicaid_paid_sw,
    pl.otherservices AS other_services_tx,
    pl.personid,
    pl.placementid,
    pl.providerid,
    pl.shortlistid AS short_list_id
   FROM placement pl
     JOIN servicecase sc ON sc.servicecaseid = pl.servicecaseid AND sc.activeflag = 1
     JOIN person pr ON pr.personid = pl.personid AND pr.activeflag = 1
     JOIN intakeservreqchildremoval irl ON irl.intakeservreqchildremovalid = pl.intakeservreqchildremovalid AND irl.activeflag = 1
  WHERE pl.activeflag = 1;
