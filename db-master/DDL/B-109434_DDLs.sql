-- B-109434 - Service Log Category - Editing of Family First EBP Service Categories (FAMILY FIRST)

-- To alter the type of service_nm column of prov.tb_services table from varchar(50) to varchar(100)
-- View fm860r_view & fm805r_view are havining dependency of service_nm column

-- Drop Views
drop view if exists cjams.fm860r_view ;
drop view if exists cjams.fm805r_view ;

-- Alter Column
alter table prov.tb_services alter column service_nm type varchar(100) ;

-- Re-create Views
CREATE OR REPLACE VIEW cjams.fm860r_view
AS SELECT DISTINCT f_plvalue(d.county_cd, 104) AS ldss,
    h.payment_id,
    h.provider_id,
    rtrim(h.payee_nm::text) AS provider_nm,
    d.client_id AS child_id,
        CASE
            WHEN d.client_id > 0 THEN ( SELECT DISTINCT l.lastname
               FROM person l
              WHERE l.cjamspid = d.client_id)
            ELSE ''::character varying
        END AS last_nm,
        CASE
            WHEN d.client_id > 0 THEN ( SELECT DISTINCT l.firstname
               FROM person l
              WHERE l.cjamspid = d.client_id)
            ELSE ''::character varying
        END AS first_nm,
        CASE
            WHEN d.client_id > 0 THEN ( SELECT DISTINCT l.middlename
               FROM person l
              WHERE l.cjamspid = d.client_id)
            ELSE ''::character varying
        END AS middle_nm,
    COALESCE(( SELECT tbl_missing_info_view.v_missing_info
           FROM tbl_missing_info_view
          WHERE tbl_missing_info_view.v_provider_id = h.provider_id), ('RETURNED CHECK OF PRIOR MONTH'::text || '-'::text) || ((( SELECT f_plvalue(tb_payment_header.check_status_cd, 37) AS f_plvalue
           FROM tb_payment_header
          WHERE (tb_payment_header.payment_id IN ( SELECT max(tb_payment_header_1.payment_id) AS max
                   FROM tb_payment_header tb_payment_header_1
                  WHERE tb_payment_header_1.check_status_cd IS NOT NULL AND tb_payment_header_1.payment_dt < current_date AND tb_payment_header_1.check_status_dt < current_date AND tb_payment_header_1.delete_sw = 'N'::bpchar AND (tb_payment_header_1.check_status_cd::text = ANY (ARRAY['4849'::character varying::text, '4850'::character varying::text, '581'::character varying::text])) AND tb_payment_header_1.provider_id = h.provider_id))))::text), 'NOT RELEASED BY WORKER'::text) AS missing_info,
    COALESCE(d.final_amount_no, 0::numeric) AS subtotal,
    s.payment_status_cd,
    ( SELECT f_sname(userprofile.cjamspid::integer) AS f_sname
           FROM userprofile
          WHERE (userprofile.cjamspid IN ( SELECT tb_assignment.assign_to_staff_id
                   FROM tb_assignment,
                    assignmentclients
                  WHERE tb_assignment.assignment_id = assignmentclients.assignmentid AND tb_assignment.entity_key_id = d.case_id AND tb_assignment.responsibility_cd::text = 'S'::text AND tb_assignment.end_dt IS NULL
                  ORDER BY tb_assignment.end_dt DESC
                 LIMIT 1)) AND userprofile.activeflag = 1) AS child_wrk_nm,
    ( SELECT f_sname(f_supervisor(userprofile.cjamspid::character varying)) AS f_sname
           FROM userprofile
          WHERE (userprofile.cjamspid IN ( SELECT tb_assignment.assign_to_staff_id
                   FROM tb_assignment,
                    assignmentclients
                  WHERE tb_assignment.assignment_id = assignmentclients.assignmentid AND tb_assignment.entity_key_id = d.case_id AND tb_assignment.client_id::text = ((( SELECT pi.personidentifiervalue
                           FROM personidentifier pi,
                            person p_1
                          WHERE pi.personid = p_1.personid AND p_1.personid = assignmentclients.personid))::text) AND tb_assignment.responsibility_cd::text = 'S'::text AND tb_assignment.end_dt IS NULL
                  ORDER BY tb_assignment.end_dt DESC
                 LIMIT 1)) AND userprofile.activeflag = 1) AS child_sup_nm,
    ( SELECT f_sname(userprofile.cjamspid::integer) AS f_sname
           FROM userprofile
          WHERE (userprofile.cjamspid IN ( SELECT tb_assignment.assign_to_staff_id
                   FROM tb_assignment
                  WHERE tb_assignment.entity_key_id = d.case_id AND tb_assignment.responsibility_cd::text = 'P'::text AND tb_assignment.end_dt IS NULL
                  ORDER BY tb_assignment.end_dt DESC
                 LIMIT 1)) AND userprofile.activeflag = 1) AS fam_wrk_nm,
    ( SELECT f_sname(f_supervisor(userprofile.cjamspid::character varying)) AS f_sname
           FROM userprofile
          WHERE (userprofile.cjamspid IN ( SELECT tb_assignment.assign_to_staff_id
                   FROM tb_assignment
                  WHERE tb_assignment.entity_key_id = d.case_id AND tb_assignment.responsibility_cd::text = 'P'::text AND tb_assignment.end_dt IS NULL
                  ORDER BY tb_assignment.end_dt DESC
                 LIMIT 1)) AND userprofile.activeflag = 1) AS family_sup_nm,
    h.payment_start_dt,
    h.payment_end_dt,
    s.payment_status_dt,
    d.final_service_start_dt AS start_date,
    d.final_service_end_dt AS end_date,
    (((( SELECT s_1.service_nm
           FROM tb_services s_1
          WHERE s_1.service_id = d.final_service_id))::text) || ' - '::text) || f_plvalue(d.final_rate_type_cd, 82)::text AS service,
    d.final_fiscal_category_cd,
    f_sname(f_prim_worker(h.provider_id, '2953'::character varying)::integer) AS resource_worker,
    f_sname(f_supervisor(f_prim_worker(h.provider_id, '2953'::character varying))) AS resource_worker_supervisor
   FROM tb_payment_header h,
    tb_payment_detail d,
    tb_payment_status s,
    tb_provider p
  WHERE h.payment_id = d.payment_id AND h.payment_id = s.payment_id AND s.payment_status_cd::text = '1635'::text AND h.provider_id = p.provider_id AND h.delete_sw = 'N'::bpchar AND d.delete_sw = 'N'::bpchar AND s.delete_sw = 'N'::bpchar AND p.delete_sw = 'N'::bpchar
  ORDER BY (f_plvalue(d.county_cd, 104)), (rtrim(h.payee_nm::text)), (
        CASE
            WHEN d.client_id > 0 THEN ( SELECT DISTINCT l.firstname
               FROM person l
              WHERE l.cjamspid = d.client_id)
            ELSE ''::character varying
        END), (
        CASE
            WHEN d.client_id > 0 THEN ( SELECT DISTINCT l.lastname
               FROM person l
              WHERE l.cjamspid = d.client_id)
            ELSE ''::character varying
        END);


CREATE OR REPLACE VIEW cjams.fm805r_view
AS SELECT DISTINCT f_plvalue(d.county_cd, 104) AS ldss,
    d.county_cd,
    h.payment_id,
    h.provider_id,
    rtrim(h.payee_nm::text) AS provider_nm,
    d.client_id AS child_id,
        CASE
            WHEN d.client_id > 0 THEN ( SELECT l.lastname
               FROM person l
                 JOIN personidentifier pi ON l.personid = pi.personid
              WHERE pi.personidentifiervalue::text = ('CL'::text || d.client_id::text)
             LIMIT 1)
            ELSE ''::character varying
        END AS last_nm,
        CASE
            WHEN d.client_id > 0 THEN ( SELECT l.middlename
               FROM person l
                 JOIN personidentifier pi ON l.personid = pi.personid
              WHERE pi.personidentifiervalue::text = ('CL'::text || d.client_id::text)
             LIMIT 1)
            ELSE ''::character varying
        END AS middle_nm,
        CASE
            WHEN d.client_id > 0 THEN ( SELECT l.firstname
               FROM person l
                 JOIN personidentifier pi ON l.personid = pi.personid
              WHERE pi.personidentifiervalue::text = ('CL'::text || d.client_id::text)
             LIMIT 1)
            ELSE ''::character varying
        END AS first_nm,
        CASE
            WHEN d.client_id > 0 THEN ( SELECT f_plvalue(l.suffix, 214) AS f_plvalue
               FROM person l
                 JOIN personidentifier pi ON l.personid = pi.personid
              WHERE pi.personidentifiervalue::text = ('CL'::text || d.client_id::text)
             LIMIT 1)
            ELSE ''::character varying
        END AS suffix_cd,
    d.draft_service_start_dt AS start_date,
    d.draft_service_end_dt AS end_date,
    (((( SELECT s.service_nm
           FROM tb_services s
          WHERE s.service_id = d.draft_service_id
         LIMIT 1))::text) || ' - '::text) || f_plvalue(d.draft_rate_type_cd, 82)::text AS service,
    d.draft_fiscal_category_cd,
    COALESCE(d.draft_amount_no, 0::numeric) AS subtotal,
        CASE
            WHEN p.contract_program_id > 0 THEN ( SELECT rtrim(c.programname::text) AS rtrim
               FROM program c
              WHERE p.contract_program_id::text = c.old_id::text AND c.activeflag = 1)
            ELSE ''::text
        END AS program_nm,
    f_sname(f_prim_assignment(h.provider_id, '2953'::character varying)) AS worker_nm,
    f_sname(f_supervisor(f_prim_assignment(h.provider_id, '2953'::character varying)::character varying)) AS supervisor_nm,
    to_char(date_trunc('MONTH'::text, date(now())::timestamp with time zone) - '1 mon'::interval, 'MM/DD/YYYY'::text) AS from_date,
    to_char(date_trunc('MONTH'::text, date(now())::timestamp with time zone) - '1 day'::interval, 'MM/DD/YYYY'::text) AS to_date,
    to_char(date(now())::timestamp with time zone, 'MM/DD/YYYY'::character varying::text) AS run_date,
    h.payment_start_dt,
    h.payment_end_dt
   FROM tb_payment_header h
     JOIN tb_payment_detail d ON h.payment_id = d.payment_id
     LEFT JOIN tb_placement_delete p ON d.placement_id = p.placement_id
  WHERE h.payment_type_cd::text = '6'::text AND d.delete_sw = 'N'::bpchar AND h.delete_sw = 'N'::bpchar AND p.delete_sw = 'N'::bpchar;
