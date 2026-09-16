CREATE OR REPLACE FUNCTION cjams.sp_nytd_client_chk_prior(vi_client_id bigint, vd_run_dt date, OUT vs_prior_report_type character)
 RETURNS character
 LANGUAGE plpgsql
AS $function$ 

DECLARE
	vs_report_type character DEFAULT '';
	vd_run_date DATE;
	vd_end_dt_prev DATE;
	vi_prev_rec_client_chk INTEGER;
	v_personid uuid;
 
BEGIN
	-- Get person id
	select personid into v_personid from person where cjamspid::bigint = vi_client_id::bigint ;
	RAISE NOTICE '>>>>>>>>v_personid >>>> %',v_personid;	
	
	if vd_run_dt is null then
		vd_run_date = now();
	else
		vd_run_date = vd_run_dt;
	end if;

	RAISE NOTICE '>>>>>>>>vd_run_date >>>> %',vd_run_date;
	
	if (date_part('month', vd_run_date)::integer in (10,11,12,1,2,3)) then
		if (date_part('month', vd_run_date)::integer in (1,2,3)) then
			vd_end_dt_prev = to_date('09/30/'||(date_part('year', vd_run_date)-1)::integer,'MM/DD/YYYY');		
		else
			vd_end_dt_prev = to_date('09/30/'||(date_part('year', vd_run_date))::integer,'MM/DD/YYYY');
		end if;
	else
		vd_end_dt_prev = to_date('03/31/'||(date_part('year', vd_run_date))::integer,'MM/DD/YYYY');
	end if;
	
	RAISE NOTICE '>>>>>>>>vd_end_dt_prev >>>> %',vd_end_dt_prev;
	
	if vd_run_date between vd_end_dt_prev and vd_end_dt_prev +  interval '45 day' then
		RAISE NOTICE '>>>>>>>>Inside 45 days check >>>> ';
		
		select a.vs_report_type
			from cjams.sp_nytd_client_chk(vi_client_id::bigint, vd_end_dt_prev::date) a
		into vs_report_type ;
		
		vs_prior_report_type = vs_report_type;
		RAISE NOTICE '>>>>>>>>sp_nytd_client_chk -- vs_prior_report_type >>>> %',vs_prior_report_type;
		
		vi_prev_rec_client_chk = 0;

		vi_prev_rec_client_chk = 
			(	select count(*)
					from personnytdsummary s 
				where s.personid::character varying = v_personid::character varying
					and s.activeflag = 1 
					and ( s.validationflag = 1 or s.validationflag is not null)
					and	s.reportingperiod::character varying =
							btrim(date_part('year',vd_end_dt_prev::date)::character varying)
								|| lpad(btrim(date_part('month',vd_end_dt_prev::date)::character varying),2,'0')
			 ) ;
			
		RAISE NOTICE '>>>>>>>>vi_prev_rec_client_chk >>>> %',vi_prev_rec_client_chk;
		
		IF vi_prev_rec_client_chk > 0 then
			RAISE NOTICE '>>>>>>>>Inside vi_prev_rec_client_chk > 0 >>>>';	
			vs_prior_report_type = 'N';
		END IF;
		  
	else
		RAISE NOTICE '>>>>>>>>Condition 45 days is NOT True >>>> ';
		vs_prior_report_type = 'N';
	end if;    

	RAISE NOTICE '>>>>>>>>Final vs_prior_report_type  >>>> %',vs_prior_report_type;	
END;
$function$
;
