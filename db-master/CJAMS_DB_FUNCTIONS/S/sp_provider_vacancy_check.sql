CREATE OR REPLACE FUNCTION cjams.sp_provider_vacancy_check(		v_provider_id bigint,
																v_program_id bigint,
																OUT as_vacancy_no character varying, 
																OUT al_sqlcode integer, 
																OUT as_mess character varying
															  )
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 08/02/2023
-- To verify the provider vacancy prior to child placement enrty (CDM-32894 R1)

-- Revision(s)
-- 
------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vl_vacancy_no Integer;
Declare vs_provider_name character varying;

BEGIN

	select f_ename('2953', v_provider_id::bigint) as provider_name
		into vs_provider_name ;
	
	if v_program_id > 0 then
		-- Private Provider
		select cp.contract_beds_no  
				- 
				(select count(*) 
					from placement pl
				where pl.contractprogramid = cp.program_id
					and pl.activeflag = 1
					and pl.startdatetime is not null
					and pl.enddatetime is null
					and coalesce(pl.isvoided, 0) <> 1
					and (
							( select count(*)
								from routing ro
							  where ro.objectid = pl.placementid::character varying
								and ro.eventcode = 'PLTR'
								and ro.routingstatustypeid = 16
								and ro.activeflag = 1
							) > 0	
							or 
							( select count(*)
								from routing ro
							  where ro.objectid = pl.placementid::character varying
								and ro.eventcode = 'PLTR'
								and ro.routingstatustypeid = 15
								and ro.activeflag = 1
							) > 0	
						)
				) as active_placement
				/*
				( select count(*)
					from cjams.tb_placement pl  
				  where pl.delete_sw = 'N'
					and pl.entry_dt is not null
					and pl.exit_dt is null
					and coalesce(pl.void_sw, 'N') <> 'Y' 
					and pl.approval_status_cd = '3047'
					and pl.contract_program_id = cp.program_id
				) as active_placement
				*/
			into vl_vacancy_no
		from prov.tb_contract_program cp
		where cp.program_id = v_program_id
			and cp.delete_sw = 'N' ;
			
		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_mess := 'Error in verifying the Private Provider Vacancy.';
			al_sqlcode := -1;
		END IF ;		
			
	else
		-- Public Provider 
		select pa.approved_beds_no
				-
				(select count(*) 
					from placement pl
				where pl.altproviderid = pa.provider_id
					and pl.activeflag = 1
					and pl.startdatetime is not null
					and pl.enddatetime is null
					and coalesce(pl.isvoided, 0) <> 1
					and (
							( select count(*)
								from routing ro
							  where ro.objectid = pl.placementid::character varying
								and ro.eventcode = 'PLTR'
								and ro.routingstatustypeid = 16
								and ro.activeflag = 1
							) > 0	
							or 
							( select count(*)
								from routing ro
							  where ro.objectid = pl.placementid::character varying
								and ro.eventcode = 'PLTR'
								and ro.routingstatustypeid = 15
								and ro.activeflag = 1
							) > 0	
						)
				) as active_placement
				/*
				( select count(*)
						from cjams.tb_placement pl  
					where pl.delete_sw = 'N'
						and pl.entry_dt is not null
						and pl.exit_dt is null
						and coalesce(pl.void_sw, 'N') <> 'Y' 
						and pl.approval_status_cd = '3047'
						and pl.provider_id = pa.provider_id
				) as active_placement
				*/
			into vl_vacancy_no	
		from prov.tb_provider_approval pa
		where pa.provider_id = v_provider_id
			and pa.delete_sw = 'N'
		order by pa.provider_approval_id desc
		limit 1 ;
		
		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_mess := 'Error in verifying the Public Provider Vacancy.';
			al_sqlcode := -1;
		END IF ;	
					
	end if;	
	
	
	if al_sqlcode = - 1 then
		as_vacancy_no := 'Error';
	else
		if vl_vacancy_no is null or vl_vacancy_no < 0 then 
			vl_vacancy_no := 0;
		end if;	
		
		as_vacancy_no := vl_vacancy_no::character varying;
	
		if vl_vacancy_no <= 0 then 
			al_sqlcode := -1;
			as_mess :=  'Selected provider "' || vs_provider_name 
						|| '" doesn''t have enough vacancy to accommodate the child/children. Please check with the provider resource worker for any additional questions.' ;
		else
			al_sqlcode := 0;
			as_mess :=  'Selected provider "' || vs_provider_name || '" is having ' || as_vacancy_no || ' vacancies.' ;
		end if;
	end if;
END;

$function$
;
