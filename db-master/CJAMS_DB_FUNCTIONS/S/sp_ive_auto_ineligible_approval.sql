DROP FUNCTION IF EXISTS cjams.sp_ive_auto_ineligible_approval(timestamp);

CREATE OR REPLACE FUNCTION cjams.sp_ive_auto_ineligible_approval(ad_run_dt timestamp without time zone, OUT vs_success_sw character varying, OUT vl_output_sqlcode character varying, OUT vs_message character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Surya Arigela
-- Date Created : 05/22/2026
-- IV-E Adoption and GAP auto-ineligible approval processing (CIDM-11293/B-242334)

-- Argument(s): 1) IN ad_run_dt - Batch Run Date, 

-- Revision(s)
-------------------------------------------------------------------------------------------------------------

DECLARE
    rec RECORD;
    vl_ret_status integer DEFAULT 0;
    vn_insert_count integer DEFAULT 0;
    vs_message_text varchar(3000) DEFAULT '';
    vs_procedure_nm varchar(100) DEFAULT 'SP_IVE_AUTO_INELIGIBLE_APPROVAL';
    v_eligibility_period_id  int;
    v_adoption_audit_transaction_id uuid;
    v_gap_audit_transaction_id uuid;

BEGIN
    BEGIN

        FOR rec IN
            SELECT
                temp.client_id,
                temp.case_type,
                temp.adoption_id,
                temp.guardian_subsidy_id,
                temp.approvalstatus,
                temp.eligibility_period_id,
                temp.eligibility_id,
                temp.sqnm_sw,
                temp.delete_sw,
                temp.eli_start_dt, temp.eli_end_dt
            FROM (
                SELECT
                    ce.eligibility_type_cd,
                    CASE
                        WHEN btrim(ce.eligibility_type_cd) = '2934' THEN 'ADOPTION'
                        WHEN btrim(ce.eligibility_type_cd) = '2935' THEN 'GAP'
                    END AS case_type,
                    ce.client_id,
                    ce.adoption_id,
                    ce.guardian_subsidy_id,
                    ep.eligibility_period_id,
                    ep.eligibility_id,
                    ep.start_dt AS eli_start_dt,
                    ep.end_dt AS eli_end_dt,
                    ep.sqnm_sw,
                    ep.approvalstatus,
                    ep.delete_sw,
                    pr.dob,
                    rank() OVER (
                        PARTITION BY ce.eligibility_id, ep.sqnm_sw
                        ORDER BY ep.eligibility_period_id DESC
                    ) AS rnk
                FROM tb_client_eligibility ce
                JOIN tb_eligibility_period ep
                    ON ce.eligibility_id = ep.eligibility_id
                JOIN person pr
                    ON ce.client_id = pr.cjamspid
                WHERE ce.delete_sw = 'N'

                  AND EXISTS (
                        SELECT 1
                        FROM tb_eligibility_period ep2
                        WHERE ep2.eligibility_id = ce.eligibility_id
                          AND ep2.delete_sw = 'N'
                          AND ep2.sqnm_sw = 'I'
                          AND btrim(ep2.status_cd) = '2913'
                  )

                  AND NOT EXISTS (
                        SELECT 1
                        FROM tb_eligibility_period ep3
                        WHERE ep3.eligibility_id = ce.eligibility_id
                          AND ep3.delete_sw = 'N'
                          AND ep3.sqnm_sw = 'R'
                  )

                  AND ep.delete_sw = 'N'
                  AND ep.sqnm_sw = 'I'
                  AND btrim(ep.status_cd) = '2913'
                  AND pr.activeflag = 1
                  AND ep.approvalstatus IN ('PENDING', 'APPROVED')
                  AND btrim(ce.eligibility_type_cd) IN ('2934', '2935')
                  AND (
                        EXTRACT(year FROM age(ad_run_dt::date, pr.dob::date)) BETWEEN 18 AND 21
                  )
            ) temp
            WHERE temp.rnk = 1
        LOOP
            IF rec.case_type = 'ADOPTION' THEN
                RAISE NOTICE 'Inserting Adoption audit for client_id %, eligibility_id %, eligibility_period_id %',
                    rec.client_id, rec.eligibility_id, rec.eligibility_period_id;
				
                INSERT INTO tb_eligibility_period
                    (eligibility_period_id, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, sqnm_sw, finalresult, ivenarrativesection,approvalid,approvalstatus)
                    VALUES(nextval('seq_tb_eligibility_period')::integer, rec.eli_start_dt, rec.eli_end_dt, '2914', rec.eligibility_id, now(), 'admin', now(), 'admin', 'N'::bpchar, 'R', 'Ineligible', 'YES','AUTO_APPROVAL','APPROVED') returning eligibility_period_id into v_eligibility_period_id;

                INSERT INTO tb_eligibility_events (event_id, event_dt, eligibility_period_id, resulting_status_cd, create_ts, update_ts, create_user_id, update_user_id, delete_sw, event_start_dt, event_end_dt, active_sw) 
                VALUES (nextval('seq_tb_eligibility_events')::integer, now(), v_eligibility_period_id, '2914', now(), now(), 'admin', 'admin','N', rec.eli_start_dt, rec.eli_end_dt, 'Y');

               
                INSERT INTO cjams.tb_ive_adoption_audit (
                    transactionid,
                    eligibility_period_id,
                    cjamspid,
                    clientid,
                    category,
                    approvalstatus,
                    finalresult,
                    insertedon,
                    insertedby,
                    updatedon,
                    updatedby
                )
                VALUES (
                    gen_random_uuid(),
                    v_eligibility_period_id,
                    rec.client_id,
                    rec.client_id,
                    'R',
                    rec.approvalstatus,
                    'ADOPTION_INELIGIBLE',
                    current_timestamp,
                    'finance',
                    current_timestamp,
                    'finance'
                )returning transactionid into v_adoption_audit_transaction_id;
				
			  
			   Update tb_client_eligibility
				set eligibility_status_cd = '2914', 
					update_user_id = 'admin', 
					update_ts = now() 
			    where eligibility_id = rec.eligibility_id
					and btrim(eligibility_status_cd) = '2913'
					and delete_sw  = 'N' ;

            ELSIF rec.case_type = 'GAP' THEN

                RAISE NOTICE 'Inserting GAP audit for client_id %, eligibility_id %, eligibility_period_id %',
                    rec.client_id, rec.eligibility_id, rec.eligibility_period_id;

                INSERT INTO tb_eligibility_period
                    (eligibility_period_id, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, sqnm_sw, finalresult, ivenarrativesection,approvalid,approvalstatus)
                    VALUES(nextval('seq_tb_eligibility_period')::integer, rec.eli_start_dt, rec.eli_end_dt, '2914', rec.eligibility_id, now(), 'admin', now(), 'admin', 'N'::bpchar, 'R', 'Ineligible', 'YES','AUTO_APPROVAL','APPROVED') returning eligibility_period_id into v_eligibility_period_id;

                INSERT INTO tb_eligibility_events (event_id, event_dt, eligibility_period_id, resulting_status_cd, create_ts, update_ts, create_user_id, update_user_id, delete_sw, event_start_dt, event_end_dt, active_sw) 
                VALUES (nextval('seq_tb_eligibility_events')::integer, now(), v_eligibility_period_id, '2914', now(), now(), 'admin', 'admin','N', rec.eli_start_dt, rec.eli_end_dt, 'Y');

               
               	INSERT INTO cjams.tb_ive_gapaudit (
                    transactionid,
                    eligibility_period_id,
                    cjamspid,
                    clientid,
                    category,
                    approvalstatus,
                    finalresult,
                    guardiansubsidyid,
                    insertedon,
                    insertedby,
                    updatedon,
                    updatedby
                )
                VALUES (
                    gen_random_uuid(),
                    v_eligibility_period_id,
                    rec.client_id,
                    rec.client_id::varchar,
                    'R',
                    rec.approvalstatus,
                    'GAP_INELIGIBLE',
                    rec.guardian_subsidy_id,
                    current_timestamp,
                    'finance',
                    current_timestamp,
                    'finance'
                )returning transactionid into v_gap_audit_transaction_id;
				
               
               Update tb_client_eligibility
				set eligibility_status_cd = '2914', 
					update_user_id = 'admin', 
					update_ts = now() 
			    where eligibility_id = rec.eligibility_id
					and btrim(eligibility_status_cd) = '2913'
					and delete_sw  = 'N' ;

            END IF;

            vn_insert_count := vn_insert_count + 1;

        END LOOP;

        vs_success_sw := 'Y';
        vl_output_sqlcode := '0';
        vs_message := 'IVE Adoption/GAP audit insert completed successfully. Insert count: '
                      || vn_insert_count;

    EXCEPTION WHEN OTHERS THEN

        GET STACKED DIAGNOSTICS vs_message_text = MESSAGE_TEXT;

        vs_success_sw := 'N';
        vl_output_sqlcode := vs_message_text;
        vs_message := 'Error in sp_ive_auto_ineligible_approval: ' || vs_message_text;

        SELECT SP_BATCH_ERROR_LOG(
            vs_procedure_nm,
            NULL::bigint,
            NULL::bigint,
            NULL::character varying,
            NULL::integer,
            NULL::character varying,
            SQLSTATE::character varying,
            vs_message::character varying,
            'finance'::character varying
        )
        INTO vl_ret_status;

    END;
END;
$function$
;
