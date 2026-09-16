CREATE OR REPLACE FUNCTION cjams.sp_afcars_csms_interface(ad_start_dt date, ad_end_dt date)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Auhor: Vineet Tirodkar
-- Date : 04/20/2022
-- Description: 
-- CJAMS AFCARS Interface SP to capture CSMS response for Element 63 (IVDFLAG) (B-130478/CIDM-4511)

-- Revision(s)
-- 02/08/2023 - Vineet Tirodkar - To fix (SELECT ...) [AS] foo. errro Aurora DB migration (CIDM-6650)
------------------------------------------------------------------------
DECLARE
	vi_client_id		integer;
	vd_removal_dt 		date;
	vd_removal_dt_old 	date;
	vd_return_dt 		date;
	vd_return_dt_old 	date;
	vn_clnt_cnt 		integer;
	vn_clnt_stg_cnt 	integer default 0;
	vn_rem_stg_cnt 		integer default 0;
	vn_ret_stg_cnt 		integer default 0;
	vn_rem_cnt 			integer default 0;
	vn_clnt_act_rem_cnt integer default 0;
	vs_cis_id 			varchar(10);
	vs_afcarsfostercareid varchar;	

DECLARE REM_CUR CURSOR FOR
	select distinct isrm.removaldate,
		-- coalesce(isrm.exitdate, isrm.returndate) as returndate
		isrm.exitdate as returndate
	from cjams.intakeservreqchildremoval isrm, 
		cjams.intakeservicerequestactor isra,
		cjams.person pr, 
		cjams.routing rur 
	where isrm.servicecaseid = isra.servicecaseid
		and isra.personid = pr.personid
		and rur.objectid = isrm.intakeservreqchildremovalid::character varying
		and pr.cjamspid = vi_client_id
		and isrm.activeflag  = 1
		and rur.eventcode = 'CHRR'
		and rur.activeflag = 1
		and rur.routingstatustypeid = '16'
	order by isrm.removaldate;

DECLARE CLNT_CUR CURSOR FOR
	select distinct af.afcarsfostercareid,
		af.fk_id,
		pr.cisclientid
	from cjams.afcarsfostercare_new af, 
		cjams.person pr 
	where af.fk_id = pr.cjamspid ::varchar
		and pr.activeflag = 1
		and pr.cisclientid is not null
		and btrim(af.localagencytypekey)
			in ( select btrim(localagencytypekey)
					from cjams.interfacegolivedates 
				 where applicationname = 'CSMS'
					and golivedate is not null
					and activeflag = 1	
				)
	-- Unit Testing
	--	and btrim(pr.cisclientid)  = 401031063	
	order by af.fk_id  ;


BEGIN 
	-- Create prior run data Snapshot 
	insert into cjams.afcarscsmsresponsehistory
		(	afcarscsmsresponseid, afcarsfostercareid, cjamspid, cisclientid, removaldate, returndate, 
			activeflag, insertedon, updatedon, updatedby, insertedby, 
			"extract", ivdflag, dataloaddate
		)
	select afcarscsmsresponseid, afcarsfostercareid, cjamspid, cisclientid, removaldate, returndate, 
		activeflag, insertedon, updatedon, updatedby, insertedby, 
		"extract", ivdflag, current_timestamp
	from cjams.afcarscsmsresponse;
 	
	-- Delete the prior run data
	delete from cjams.afcarscsmsresponse;
	

	select count(*)
		into vn_clnt_cnt
	from cjams.afcarsfostercare_new af, 
		cjams.person pr 
	where af.fk_id = pr.cjamspid::varchar
		and pr.activeflag = 1
		and pr.cisclientid is not null
		and btrim(af.localagencytypekey)
			in ( select btrim(localagencytypekey)
					from cjams.interfacegolivedates 
				 where applicationname = 'CSMS'
					and golivedate is not null
					and activeflag = 1	
				)
		-- Unit Testing
		-- and btrim(pr.cisclientid)  = 401031063	
		;
			
	raise notice 'Total Clients >> vn_clnt_cnt % ',vn_clnt_cnt;

	OPEN CLNT_CUR;
        WHILE vn_clnt_cnt > 0 LOOP
		FETCH CLNT_CUR INTO vs_afcarsfostercareid, vi_client_id, vs_cis_id;
		
		-- RAISE NOTICE 'vs_afcarsfostercareid % ', vs_afcarsfostercareid;
		-- RAISE NOTICE 'vi_client_id % ', vi_client_id;
		-- RAISE NOTICE 'vs_cis_id % ', vs_afcarsfostercareid;
		
		--EXIT WHEN NOT FOUND;--

		select count(*)
			into vn_rem_cnt
		from (
			select distinct isrm.removaldate, 
				-- coalesce(isrm.exitdate, isrm.returndate) as returndate
				isrm.exitdate as returndate
			from cjams.intakeservreqchildremoval isrm, 
				cjams.intakeservicerequestactor isra ,
				cjams.person pr, 
				cjams.routing rur  
			where isrm.servicecaseid = isra.servicecaseid
				and isra.personid = pr.personid
				and rur.objectid = isrm.intakeservreqchildremovalid::character varying
				and pr.cjamspid = vi_client_id
				and isrm.activeflag  = 1
				and rur.eventcode = 'CHRR'
				and rur.activeflag = 1
				and rur.routingstatustypeid = '16'
			) as tab;
						
		-- RAISE NOTICE 'vn_rem_cnt % ', vn_rem_cnt;
						
		OPEN REM_CUR;
			WHILE vn_rem_cnt > 0 LOOP
	
            FETCH REM_CUR INTO vd_removal_dt, vd_return_dt;
			
			-- RAISE NOTICE 'vd_removal_dt % ', vd_removal_dt;
			-- RAISE NOTICE 'vd_return_dt % ', vd_return_dt;
			
			--EXIT WHEN NOT FOUND;--
		
			vn_rem_cnt := vn_rem_cnt - 1;

			vn_clnt_stg_cnt := ( select count(*) 
									from cjams.afcarscsmsresponse af
								where af.cjamspid = vi_client_id
								);

			-- RAISE NOTICE 'vn_clnt_stg_cnt % ', vn_clnt_stg_cnt;
			
			vn_rem_stg_cnt := ( select count(*)
									from afcarscsmsresponse af
								WHERE af.cjamspid = vi_client_id
									and af.returndate = vd_removal_dt
								);
								
			-- RAISE NOTICE 'vn_rem_stg_cnt % ', vn_rem_stg_cnt;
								
			vn_ret_stg_cnt := ( select count(*)
									from afcarscsmsresponse af
								where af.cjamspid = vi_client_id
									and af.removaldate = vd_return_dt
								);
															
			-- RAISE NOTICE 'vn_ret_stg_cnt % ', vn_ret_stg_cnt;

			-- New
			IF vn_clnt_stg_cnt > 0 THEN
				vn_clnt_act_rem_cnt := ( select count(*) 
											from cjams.afcarscsmsresponse af
										where af.cjamspid = vi_client_id
											and af.returndate is null
										);
			ELSE
				vn_clnt_act_rem_cnt := 0;
			END IF;	
	
			-- RAISE NOTICE 'vn_clnt_act_rem_cnt % ', vn_clnt_act_rem_cnt;
			
			IF vn_clnt_act_rem_cnt > 0 THEN
				-- RAISE NOTICE 'Multiple Active Removals % ', vi_client_id ;
			ELSE
				IF vn_clnt_stg_cnt = 0  THEN
									
					-- RAISE NOTICE 'INSERT INTO afcarscsmsresponse (1)';
										
					insert into cjams.afcarscsmsresponse
						( 	afcarsfostercareid, 
							cjamspid, 
							cisclientid, 
							removaldate, 
							returndate, 
							activeflag, 
							insertedon, 
							updatedon, 
							updatedby, 
							insertedby, 
							"extract", 
							ivdflag
						)
					values
						(	vs_afcarsfostercareid, 
							vi_client_id, 
							btrim(vs_cis_id), 
							vd_removal_dt, 
							vd_return_dt, 
							1, 
							current_timestamp, 
							current_timestamp, 
							'cwadmin', 
							'cwadmin', 
							null, 
							null
						);

				END IF;

				IF vn_clnt_stg_cnt >= 1 AND vn_rem_stg_cnt = 0 AND vn_ret_stg_cnt = 0  THEN
								
					-- RAISE NOTICE 'INSERT INTO afcarscsmsresponse (2)';			
					
					insert into cjams.afcarscsmsresponse
						( 	afcarsfostercareid, 
							cjamspid, 
							cisclientid, 
							removaldate, 
							returndate, 
							activeflag, 
							insertedon, 
							updatedon, 
							updatedby, 
							insertedby, 
							"extract", 
							ivdflag
						)
					values
						(	vs_afcarsfostercareid, 
							vi_client_id, 
							btrim(vs_cis_id), 
							vd_removal_dt, 
							vd_return_dt, 
							1, 
							current_timestamp, 
							current_timestamp, 
							'cwadmin', 
							'cwadmin', 
							null, 
							null
						);
						
				END IF;

				IF vn_rem_stg_cnt >= 1 AND vd_removal_dt = vd_return_dt_old THEN
										   
					-- RAISE NOTICE 'UPDATE afcarscsmsresponse (1)';
										
					update cjams.afcarscsmsresponse
						set returndate = vd_return_dt,
						updatedon= now(),
						updatedby = 'cwadmin'
					where cjamspid = vi_client_id
						and afcarscsmsresponseid 
							= (	select afcarscsmsresponseid
									from cjams.afcarscsmsresponse af
								where af.cjamspid = vi_client_id
								order by afcarscsmsresponseid desc
								limit 1
							  );
				END IF;
			END IF;	

			vd_removal_dt_old := vd_removal_dt;
			vd_return_dt_old := vd_return_dt;
			
        END LOOP;
        CLOSE REM_CUR;
		
        vn_clnt_cnt := vn_clnt_cnt - 1;
		
    END LOOP;
	CLOSE CLNT_CUR;

	-- RAISE NOTICE 'FINAL UPDATE for afcarscsmsresponse (1)';

	update cjams.afcarscsmsresponse
		set activeflag = 0,
		updatedon= now(),
		updatedby = 'cwadmin'
	where removaldate is null;
				
	update cjams.afcarscsmsresponse
		set activeflag = 0,
		updatedon= now(),
		updatedby = 'cwadmin'
	where afcarscsmsresponseid
		not in	(	SELECT afcarscsmsresponseid 
						FROM cjams.afcarscsmsresponse af
					where (	ad_start_dt::timestamp between af.removaldate::timestamp and af.returndate::timestamp ) 
						or ( ad_end_dt::timestamp between af.removaldate::timestamp and af.returndate::timestamp) 
						or ( af.returndate is null)	
						or ( af.removaldate::timestamp between ad_start_dt::timestamp and ad_end_dt::timestamp) 
						-- or ( af.removaldate::timestamp between ad_start_dt::timestamp and ad_end_dt::timestamp)
				);
					
						
	-- RAISE NOTICE 'FINAL UPDATE for afcarscsmsresponse >> extract ';
										
	update cjams.afcarscsmsresponse
		set "extract" 
			= (	trim(cjamspid::varchar)	||
				trim(cisclientid::VARCHAR) ||
				substring(to_char( removaldate,'YYYYMMDD'),5,2)	||
				substring(to_char( removaldate,'YYYYMMDD'),7,2) ||
				substring(to_char( removaldate,'YYYYMMDD'),1,4)	||
				coalesce(substring(to_char( returndate,'YYYYMMDD'),5,2),'  ') ||
				coalesce(substring(to_char( returndate,'YYYYMMDD'),7,2),'  ') ||
				coalesce(substring(to_char( returndate,'YYYYMMDD'),1,4),'    ')),
				updatedon= now(),
				updatedby = 'cwadmin';
END;

$function$
;
