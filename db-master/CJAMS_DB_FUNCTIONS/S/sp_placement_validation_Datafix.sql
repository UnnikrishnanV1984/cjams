Drop function if exists cjams.sp_placement_validation_datafix(date, date, character varying);

CREATE OR REPLACE FUNCTION cjams.sp_placement_validation_datafix(ad_start_date date, ad_end_date date, as_user_id character varying, OUT al_sqlcode integer, OUT as_mess character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 09/04/2020
-- SP to generate missing Placement Validations

-- Revision(s)
-- 11/11/2020 - Vineet Tirodkar - Modifications to delete out of placement range validations 
-- 01/14/2021 - Vineet Tirodkar - Modifications to consider placements with entry date as prior month last day
-- 05/07/2021 - Vineet Tirodkar - Modifications to Trigger Under/Over when Exit date is 1st of the month (CDM-13055_56_57_58_59_60)
-- 05/20/2022 - Vineet Tirodkar - Modifications to update placement exit date in validation table for Under/Over (CDM-22232)  
-- 09/22/2022 - Vineet Tirodkar - Type casting fixes for Aurora DB migration 
-- 11/06/2024 - Vineet Tirodkar - To add new Non-paid Kinship Placement structure in exclusion (B-207876 / CIDM-9688)
------------------------------------------------------------------------
declare sqlcode int default 0;
declare vs_placement_validation_id varchar(50) default 'sq_placement_validation';

declare vl_placment_val_count integer default 0;
declare vl_count integer default 0;
declare vl_placement_exit_day integer default 0;
declare vl_placement_id bigint;
declare vd_next_month_plvd_dt date;
declare vd_placement_entry_dt date;
declare vd_placement_exit_dt date;
declare vd_current_month_dt date;
declare vd_current_start_dt date;
declare vd_current_end_dt date;
declare vd_entry_month_first_day date;

declare vd_startdatetime timestamp without time zone;
declare vd_enddatetime timestamp without time zone;


cur_placement record;
cur_placement_refcur REFCURSOR;

cur_placement_exits record;
cur_placement_exits_refcur REFCURSOR;


BEGIN
	select (date_trunc('month', now())::date ) into vd_next_month_plvd_dt ;
	RAISE NOTICE 'vd_next_month_plvd_dt >> %',vd_next_month_plvd_dt;
	
	if as_user_id is NULL then
		as_user_id := 'financeDFX';
	end if;

	OPEN cur_placement_refcur FOR
		select placement_id, 
			entry_dt::date as entry_dt,
			exit_dt::date as exit_dt
			from tb_placement
		where delete_sw = 'N'
			and coalesce(void_sw, 'N') <> 'Y'
			and approval_status_cd  = '3047'
			and placement_structure_id not in ( 8, 76, 531 )
			and entry_dt <> coalesce(exit_dt, entry_dt + interval '1 day')
			and entry_dt::date <= (date_trunc('month', now())::date - 1)::date
			and placement_id 
				in (  select alternateid 
						from placement 
						where updatedon::date >= ad_start_date::date 
							and updatedon::date <= ad_end_date::date
							and activeflag = 1
							and altproviderid is not null
							
					)		
			-- for Unit Testing
			-- and placement_id in (1557040, 1557026, 340954, 327905, 324488)			
		order by entry_dt::date desc ;	
	loop
		fetch cur_placement_refcur into cur_placement;
			exit when not found;
		
			vl_placement_id := cur_placement.placement_id;
			vd_placement_entry_dt := cur_placement.entry_dt;
			vd_placement_exit_dt := cur_placement.exit_dt;
			
			
			RAISE NOTICE 'vl_placement_id >> %',vl_placement_id;
			RAISE NOTICE 'vd_placement_entry_dt >> %',vd_placement_entry_dt;
			RAISE NOTICE 'vd_placement_exit_dt >> %',vd_placement_exit_dt;
			
			vd_current_month_dt := date_trunc('month', vd_placement_entry_dt)::date ;
			
			IF vd_current_month_dt < vd_next_month_plvd_dt THEN
				vl_count := 1;
				loop EXIT WHEN vl_count <= 0::integer ;
					RAISE NOTICE 'vl_count >> %',vl_count;
					RAISE NOTICE 'vd_current_month_dt >> %',vd_current_month_dt;
					
					select (date_trunc('month', vd_current_month_dt) )::date,
							(date_trunc('month', vd_current_month_dt)::date + interval '1 month' - interval ' 1 day')::date
						into vd_current_start_dt,
							vd_current_end_dt ;
					
					RAISE NOTICE 'vd_current_start_dt for >> %',vd_current_start_dt;
					RAISE NOTICE 'vd_current_end_dt for >> %',vd_current_end_dt;
					
					Select count(*)
						into vl_placment_val_count
					from tb_placement_validation
					where placement_id = vl_placement_id 
						and validation_start_dt = vd_current_start_dt 
						and validation_end_dt = vd_current_end_dt 
						and delete_sw = 'N' ;
				
					RAISE NOTICE 'vl_placment_val_count >> %',vl_placment_val_count;
					
					IF vl_placment_val_count = 0 AND vd_current_start_dt >= '2009-01-01'::date THEN  
						RAISE NOTICE 'Placement Validation is missing for >> %',vd_current_start_dt;
						insert into
							tb_placement_validation
							(
							   placement_validation_id,               placement_id,
							   placement_entry_dt,                    placement_exit_dt,
							   validation_status_cd,                  comment_tx,
							   validation_start_dt,                   validation_end_dt,
							   create_ts,                             create_user_id,
							   update_ts,                             update_user_id,
							   delete_sw
							)
						 values
							(
							   nextval('sq_placement_validation'), 		vl_placement_id,
							   vd_placement_entry_dt,                   vd_placement_exit_dt,
							   NULL,                                    NULL,
							   vd_current_start_dt,              		vd_current_end_dt,
							   current_timestamp,                       as_user_id,
							   current_timestamp,                       as_user_id,
							   'N'
							);
					ELSE
						if vd_current_start_dt >= '2009-01-01'::date  then
							RAISE NOTICE 'Existing Placement Validation found for >> %',vd_current_start_dt;
						else
							RAISE NOTICE 'Validation month is prior to Finance Go-Live date >> %',vd_current_start_dt;
						end if;	
					END IF;
					
					al_sqlcode := SQLCODE;
					IF al_sqlcode < 0 THEN
						as_mess := 'Error in creating missing placement validations';
						al_sqlcode := -1;
						vl_count := -1; -- Exit
						ROLLBACK;
					END IF ;
					
					vd_current_month_dt := (vd_current_month_dt + interval '1 month')::date;
					RAISE NOTICE 'New vd_current_month_dt >> %',vd_current_month_dt;
					
					IF vd_current_month_dt >= vd_next_month_plvd_dt THEN 
						RAISE NOTICE 'Exit - Processed up to the current Month' ;
						vl_count := -1; -- Exit
					Elseif vd_placement_exit_dt is not null and  vd_current_month_dt >= vd_placement_exit_dt THEN
						RAISE NOTICE 'Exit - Month is beyond the Exit Date' ;
						vl_count := -1; -- Exit
					ELSE
						RAISE NOTICE 'Go to the Next month' ;
						vl_count := vl_count + 1;
					END IF;
				END loop;
			END IF;	
	
			-- Delete out of placement range validations
			select date_trunc('month', vd_placement_entry_dt)::date 
				into vd_entry_month_first_day ;
			
			update tb_placement_validation
				set delete_sw = 'Y' ,
					update_ts = current_timestamp,
					update_user_id = 'financeVD'
			where placement_id = vl_placement_id
				and delete_sw = 'N'
				and coalesce(validation_status_cd, '') <> '1750'
				and validation_start_dt < vd_entry_month_first_day ;

			if vd_placement_exit_dt is not null then
				select date_part('day', vd_placement_exit_dt::date)::integer
					into vl_placement_exit_day ;
					
				if vl_placement_exit_day = 1 then	
					-- Remove which are pending
					update tb_placement_validation
						set delete_sw = 'Y' ,
							update_ts = current_timestamp,
							update_user_id = 'financeVD'
					where placement_id = vl_placement_id
						and delete_sw = 'N'
						and coalesce(validation_status_cd, '') <> '1750'
						and validation_start_dt >= vd_placement_exit_dt; 
						
					-- To Trigger Under/Over	
					update tb_placement_validation
						set update_ts = current_timestamp,
							update_user_id = 'financeAR'
					where placement_id = vl_placement_id
						and delete_sw = 'N'
						and coalesce(validation_status_cd, '') = '1750'
						and date_part('month', validation_start_dt) = date_part('month', vd_placement_exit_dt)
						and date_part('year', validation_start_dt) = date_part('year', vd_placement_exit_dt); 
				else
					update tb_placement_validation
						set delete_sw = 'Y' ,
							update_ts = current_timestamp,
							update_user_id = 'financeVD'
					where placement_id = vl_placement_id
						and delete_sw = 'N'
						and coalesce(validation_status_cd, '') <> '1750'
						and validation_start_dt > vd_placement_exit_dt; 
				end if;		
			end if;
	END LOOP;	
	close cur_placement_refcur;	
	
	-- Delete placement validation prior to 2009-01-01
	update tb_placement_validation
		set delete_sw = 'Y',
			update_ts = now(),
			update_user_id = 'financeDL'
	where delete_sw = 'N'
		and create_user_id = as_user_id
		and validation_start_dt < '2009-01-01'::date ;  
  
	
	
	-- Temp fix to trigger under/over aftre placement exit
	/*
	In some scenarios of retroactive placement exits, CJAMS is currently not updating the placement validation 
	table with the placement exit date. Due to which the finance under over batch is not re-calculating the 
	payments and ARs are missing.
	*/
	
	OPEN cur_placement_exits_refcur FOR
		select pl.alternateid, pl.startdatetime, pl.enddatetime
			from placement pl
		where pl.altproviderid is not null
			and pl.enddatetime is not null
			and pl.enddatetime::date >= '2009-01-01'::date
			and pl.activeflag = 1
			and COALESCE(pl.isvoided, 0) <> 1
			and pl.updatedon::date >= ad_start_date::date 
			and pl.updatedon::date <= ad_end_date::date
			and (	select count(*)
						from tb_placement_validation pv
					where pv.placement_id = pl.alternateid
						and pv.delete_sw = 'N'
						and pv.placement_exit_dt is null
				) > 0 ;
	loop
		fetch cur_placement_exits_refcur into cur_placement_exits;
			exit when not found;
		
			vl_placement_id := cur_placement_exits.alternateid;
			vd_startdatetime := cur_placement_exits.startdatetime;
			vd_enddatetime := cur_placement_exits.enddatetime;
			
			update tb_placement_validation
			set placement_entry_dt = vd_startdatetime::date,
				placement_exit_dt = vd_enddatetime::date,
				update_ts = current_timestamp,
				update_user_id = 'financeEx'
			where placement_id = vl_placement_id
				and delete_sw = 'N'
				and placement_exit_dt is null 
				and validation_start_dt < vd_enddatetime::date ;
	end loop;
	close cur_placement_exits_refcur;	
  
	al_sqlcode := 0;
	as_mess := 'Success';
	  
END;

$function$
;