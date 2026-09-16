CREATE OR REPLACE FUNCTION cjams.sp_nytd_served_population(run_dt date, OUT al_sqlcode integer, OUT vs_message character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author          : Vineet Tirodkar
-- Date            : 10/21/2014
-- Description     : Stored Procedure to populate NYTD served_population

-- Requests #      : N/A
-- Argument(s):
-- 1) IN RUN_DT (NYTD Period End Date)
-- 2) OUT al_sqlcode (SQL code for error handling)
-- 3) OUT as_error (Error Text)

-- Revision:
-- 10/16/2020 - Vineet Tirodkar - Changes to exclude cjamspid with multiple persons & for Performance improvements
-- 09/30/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------
DECLARE 
	SQLSTATE 				CHAR(5) DEFAULT '00000';
	vl_output_sqlcode		varchar;
	vl_client_id			bigint;
	v_reporttypecd			bigint;
	v_reportingperiod		bigint;
	-- vl_count				integer;
	vl_client_cnt			integer;
	vs_err_message			character varying;
	vs_nytd_client_chk		varchar(1);
	
	CUR_NYTD_SERVED_refcur REFCURSOR;

BEGIN 
	OPEN CUR_NYTD_SERVED_refcur FOR
		select pr.cjamspid
			from person pr
        where pr.cjamspid > 0
			and pr.activeflag = 1
			/*
			-- and pr.clientflag = 1
			and sp_nytd_client_chk(cjamspid, run_dt) = 'S'
			and cjamspid not in 
				(	select cjamspid
					from person
					where activeflag = 1
					group by cjamspid
					having count(*) > 1 
				)
			*/	
			and f_age(run_dt, pr.dob) > 13
			and f_age(run_dt, pr.dob) < 22
		order by pr.cjamspid;
		
		LOOP
			FETCH CUR_NYTD_SERVED_refcur INTO vl_client_id;
			exit when not found;

			raise notice 'vl_client_id%,',vl_client_id;
			
			BEGIN 
				-- Verify Duplicate cjamspid
				vl_client_cnt := 0 ;
				vs_err_message := '';
				
				select count(*)
					into vl_client_cnt
				from person
				where activeflag = 1
					and cjamspid = vl_client_id ;

				IF vl_client_cnt > 1 THEN
				  vs_err_message := 'Duplicate Persons found for cjamspid --> ' || Btrim((vl_client_id)::character varying) ;
					
					INSERT INTO CJAMS.interfaceserrorlog
						(	interfaceid,
							currentruntimestamp,
							batchnumber,
							errorlineno,
							errordescription,
							insertedon
						)
					VALUES
						(	'SP_NYTD_SERVED_POPULATION',
							clock_timestamp(),
							'000',
							0,
							vs_err_message,
							current_date
						);
							
				ELSE
					-- Verify Client is eligible for Served Population
					vs_nytd_client_chk := '';
					select sp_nytd_client_chk(vl_client_id::bigint, run_dt::date)
						into vs_nytd_client_chk;
	
					IF Btrim(vs_nytd_client_chk) <> 'S' THEN
						-- Do nothing
					ELSE
						BEGIN
							select * 
								into vs_message
							from sp_nytd_data_population(vl_client_id, run_dt::character varying,'D');
							
							EXCEPTION WHEN OTHERS THEN 
								VL_OUTPUT_SQLCODE := SQLSTATE;
								al_sqlcode := -1 ;
								VS_MESSAGE := 'SP_NYTD_DATA_POPULATION FAILED FOR CLIENT ID :: '|| (vl_client_id::VARCHAR) || ' ERROR CODE ::' || (VL_OUTPUT_SQLCODE::VARCHAR);

								INSERT INTO CJAMS.interfaceserrorlog
									(	interfaceid,
										currentruntimestamp,
										batchnumber,
										errorlineno,
										errordescription,
										insertedon
									)
								VALUES
									(	'SP_NYTD_SERVED_POPULATION',
										clock_timestamp(),
										'000',
										0,
										VS_MESSAGE,
										current_date
									);
						END;	
					END IF;			
				END IF;			
			END ;
		END LOOP;
	CLOSE CUR_NYTD_SERVED_refcur;

	select (case when date_part('month', RUN_DT) = 3 then
				'13054' --    Services-March
			else
				'13055' --    Services-September
			end ) as report_type_cd,
			(case when date_part('month', RUN_DT) = 3 then
				date_part('year', RUN_DT)::character varying || '03'
			else
				date_part('year', RUN_DT)::character varying || '09'
			end ) as reporting_period
 	into v_reporttypecd,  
		v_reportingperiod;

 	update personnytdsummary
 		set validationflag = 1, 
			verifiedstaffid = 1, 
			updatedby = 'ADMIN',
			updatedon = now()			
	where activeflag = 1 
		and reporttypekey = v_reporttypecd::character varying
		and reportingperiod = v_reportingperiod::character varying 
		and date(insertedon) = CURRENT_DATE 
		and coalesce(validationflag, 0) <>  1;
	
	al_sqlcode:= 0;

END ;
$function$
;

