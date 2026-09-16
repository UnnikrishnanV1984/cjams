-- CIDM-10610 Adoption subsidy payments batch failure 07/01/2025 fix

-- To revert the GAP payments status back to Approved, for FMIS SP to re-process the payments  


update TB_PAYMENT_STATUS
	set PAYMENT_STATUS_CD = '1634',	-- Approved
		update_ts = now(),
		update_user_id  = 'CIDM-10610'
where delete_sw  = 'N'
	and PAYMENT_STATUS_CD = '1636' -- Interfaced
	and payment_id in (
			SELECT ph.payment_id 
			FROM TB_PAYMENT_DETAIL PD,
			     TB_PAYMENT_HEADER PH,
				 TB_PAYMENT_STATUS PS,
				 TB_PROVIDER P	
			WHERE PD.PAYMENT_ID = PH.PAYMENT_ID
				AND PH.PAYMENT_ID = PS.PAYMENT_ID
				and PH.provider_id = P.provider_id
				AND PD.DELETE_SW = 'N'
				AND PH.DELETE_SW = 'N'
				AND PS.DELETE_SW = 'N'
				and P.delete_sw  = 'N'
				AND SUBSIDY_AGREEMENT_ID > 0
				AND PH.PAYMENT_TYPE_CD in ('7') -- 	Guardianship Assistance Program
				AND PS.PAYMENT_STATUS_CD  = '1636' -- Interfaced
				AND date_part('month', PD.FINAL_SERVICE_START_DT) = 06
				AND date_part('year', PD.FINAL_SERVICE_START_DT) = 2025
				)	
		;	