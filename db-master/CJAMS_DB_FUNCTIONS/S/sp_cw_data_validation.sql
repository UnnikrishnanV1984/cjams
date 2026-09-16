Drop FUNCTION if exists cjams.sp_cw_data_validation( date );
													   
CREATE OR REPLACE FUNCTION cjams.sp_cw_data_validation(	adt_date date, 
														OUT al_main_sqlcode integer, 
														OUT as_mail_mess character varying
													   )
RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 09/01/2023

-- CJAMS CW - Daily Data Validation Batch to validate and correct the data. (CIDM-7866)

-- Revision(s)

------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vl_sqlcode integer;
Declare vs_mess character varying;
Declare vl_sp_call_level_cd integer;

BEGIN
	if adt_date is NULL then
		adt_date := current_date;
	end if;
	
	-- 1) Provider vacancy data validation & sync
	vl_sp_call_level_cd := NULL; 
	
	select sp_call_level_cd 
		into vl_sp_call_level_cd
	from cjams.tb_batch_sp_master 
	where batch_master_id = 77
		and batch_sp_master_id = 101;

	
	if COALESCE(vl_sp_call_level_cd, 0) = -1 then 
		RAISE NOTICE 'Do Not Run - Provider vacancy data validation & sync';
	else
		RAISE NOTICE 'Provider vacancy data validation & sync - Start';
	
		select al_sqlcode, as_mess 
			into vl_sqlcode, vs_mess 
		from cjams.sp_provider_vacancy_data_sync(NULL::character varying, 'N'::character varying) ;

		RAISE NOTICE 'Provider vacancy data validation & sync - End';
	end if;
	
	-- 2) ....
	-- vl_sp_call_level_cd := NULL; 
	
	al_main_sqlcode := vl_sqlcode;
	as_mail_mess := vs_mess;
	
END;

$function$
;
