Drop function if exists cjams.f_get_lastfcpaymentamount(bigint);

CREATE OR REPLACE FUNCTION cjams.f_get_lastfcpaymentamount(v_clientid bigint, OUT a_lastfcpaymentamount numeric)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------
-- Revisions:
-- 11/06/2024 - Vineet Tirodkar - To add new Non-paid Kinship Placement structure (B-207876 / CIDM-9688)
------------------------------------------------------------------------------------------------
DECLARE
    v_cjamspid bigint;
    v_contract_program_id bigint;
    v_rate_structure_id bigint;
    v_exit_dt date;
    v_client_dob date;
    v_client_age integer;
    v_per_diem_rate numeric;
	
BEGIN
	select cjamspid, dob
		into v_cjamspid, v_client_dob
	from person 
	where cjamspid = v_clientid 
		and activeflag = 1 ;
		
	IF v_cjamspid is not null THEN
		select Round((final_unit_rate_amt * 365)/12, 0)
			into a_lastfcpaymentamount
		from tb_payment_detail
		where delete_sw = 'N'
			and client_id = v_cjamspid
			and placement_id is not null
			and final_amount_no > 0
		order by placement_id desc, 
				payment_detail_id desc
		limit 1 ;

		IF a_lastfcpaymentamount is null THEN
			select contract_program_id, rate_structure_id, exit_dt, f_age(v_client_dob, exit_dt)
				into v_contract_program_id, v_rate_structure_id, v_exit_dt, v_client_age
			from tb_placement tp 
			where client_id = v_cjamspid 
				and delete_sw = 'N' 
				and coalesce(approval_status_cd, '') = '3047' 
				and coalesce (void_sw,'') <> 'Y'
				and placement_structure_id not in (8, 76, 531)
			order by entry_dt desc 
			limit 1;

			IF v_contract_program_id is not null THEN
				select monthly_rate_no 
					into a_lastfcpaymentamount
				from tb_prov_program_rates tppr 
				where program_id = v_contract_program_id
					and v_exit_dt between start_dt and end_dt 
					and prov_program_actual_max_cd = '5590'
					and delete_sw = 'N'
				order by program_rate_id desc
				limit 1;
			ELSE
				select monthly_rate_no, per_diem_rate_no
					into a_lastfcpaymentamount, v_per_diem_rate
				from tb_foster_care_rate tfcr
				where service_id = 10 
					and v_exit_dt between start_dt and end_dt 
					and v_client_age between min_age_no and max_age_no 
					and delete_sw = 'N'
				order by rate_id desc 
				limit 1;

				IF coalesce(a_lastfcpaymentamount, 0) = 0 THEN
					select Round((v_per_diem_rate * 365)/12, 0)
						into a_lastfcpaymentamount;
				END IF;

			END IF;

			IF coalesce(a_lastfcpaymentamount, 0) = 0 THEN
				a_lastfcpaymentamount := 2000;
			END IF;

		END IF;	

	ELSE
		a_lastfcpaymentamount := 2000;
		
	END IF;	
	
END;

$function$
;