CREATE OR REPLACE FUNCTION cjams.sp_audit_log_system_adjustments(searchobj json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, payment_id bigint, payment_detail_id bigint, category_code character varying, service_nm character varying, final_service_start_dt date, final_service_end_dt date, final_amount_no numeric, receivable_amount numeric, provider_id bigint, provider_nma character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE  

	al_event_id bigint;
	as_event_type_cd character varying;
	v_pagenumber int;
	v_pageoffset int;

BEGIN 
al_event_id := searchobj ->> 'event_id';
as_event_type_cd := searchobj ->> 'event_type_cd';
v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

	return query
SELECT  COUNT(1) OVER() totalcount, 
	  PH.PAYMENT_ID::bigint,
			PD.PAYMENT_DETAIL_ID::bigint,
			PD.FINAL_FISCAL_CATEGORY_CD::character varying AS CATEGORY_CODE,
			F_SERVICENAME(PD.FINAL_SERVICE_ID) AS SERVICE_NM,
			PD.FINAL_SERVICE_START_DT::date,
			PD.FINAL_SERVICE_END_DT::date,
			PD.FINAL_AMOUNT_NO,
			COALESCE((SELECT SUM(COALESCE(RD.AMOUNT_NO,0) - COALESCE(RD.WRITTEN_OFF_AMOUNT_NO,0))
			FROM TB_RECEIVABLE_DETAIL RD
			WHERE RD.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID
			AND RD.DELETE_SW = 'N' ),0) AS RECEIVABLE_AMOUNT,
			PH.PROVIDER_ID::bigint,
			F_ENAME('2953',PH.PROVIDER_ID) AS PROVIDER_NMa
   FROM TB_FISCAL_AUDIT_TRAIL FA,
			TB_FISCAL_AUDIT_TRAIL_ENTITY_LINK FL,
			TB_PAYMENT_DETAIL PD,
			TB_PAYMENT_HEADER PH
WHERE FA.FISCAL_AUDIT_TRAIL_ID = FL.FISCAL_AUDIT_TRAIL_ID
		AND PD.PAYMENT_DETAIL_ID = FL.ENTITY_ID
		AND PD.PAYMENT_ID = PH.PAYMENT_ID
		AND FA.EVENT_ID = al_event_id
		AND FA.EVENT_TYPE_CD = as_event_type_cd
		AND FL.ENTITY_TYPE_CD = '1008'
		AND FA.DELETE_SW = 'N'
		AND FL.DELETE_SW = 'N'
		AND PD.DELETE_SW = 'N'
		AND PH.DELETE_SW = 'N'
ORDER BY PD.PAYMENT_DETAIL_ID
LIMIT v_liPageSize OFFSET v_pageoffset; 

END;
$function$
;
