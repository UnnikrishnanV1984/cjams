CREATE OR REPLACE FUNCTION cjams.sp_generate_afcars_element65()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author : Raghu Tarlapu
-- Date Created : '2011-09-10'
-- Frequency : Twice in One year.
-- Modifications by:
-- Raghu Tarlapu: 09/05/2012 Change made to NO_FEDERAL_SUPPORT_SW for Prj-02853.
-- Raghu Tarlapu: 10/16/2012 Made elements 49 - 55 as '0' if 41 is not in ('1','2','3')
-- Samir Patil	09/15/2015	Commented logic for Element 65 NO_FEDERAL_SUPPORT_SW PRJ-05417 Req#2.
-- logic for this element65 is now in procedure SP_AFCARS_IVE_DETAILS.
-- 04/15/2021 - Vineet Tirodkar - To fix duplicate CIS Client Ids in person table error & performance improvements.
-- 05/06/2021 - Vineet Tirodkar - Modifications to update E&E responses in CJAMS AFCARS table
-- 04/21/2022 - Vineet Tirodkar - Modifications to update CSMS responses in CJAMS AFCARS table (B-130478/CIDM-4511)
------------------------------------------------------------------------
DECLARE 
	VN_CLIENT_ID varchar ;
	VN_DSCHRG_DT INTEGER ;
	VN_REM_ST_DT_CNT INTEGER ;
	--VN_65_CNT INTEGER DEFAULT 0;
	VN_REM_CNT INTEGER DEFAULT 0;
	VS_MONTH CHAR(2);
	VS_YEAR CHAR(4);
	VS_DAY VARCHAR(10);
	VS_DATE VARCHAR(10);
	VS_DISCHARGE_DT VARCHAR(10);
	v_clientid_cnt integer;
	v_SQLCODE integer DEFAULT 0;
	v_sqlerrm varchar;

	vl_client_id bigint;
	
	vs_afcarsfostercareid character varying;
	vs_cisclientid character varying;
	vs_element61sw character varying;
	vs_element63sw character varying;
	vs_element62sw character varying; 
	vs_ene_element61sw character varying; 
	vs_ene_element63sw character varying; 
	vs_csms_element62sw character varying; 
	v_updatedby character varying; 

	vb_ene_response boolean default False;
	
cur_interface_updates REFCURSOR;
cur_interface_updates_rec record;

DECLARE ELEMENT_65 CURSOR  FOR
	SELECT FK_ID FROM AFCARSFOSTERCARE_NEW
	WHERE activeflag = '1' ;


BEGIN
	raise notice 'SP started ';
	select count(fk_id) into v_clientid_cnt from AFCARSFOSTERCARE_NEW WHERE activeflag = '1';

	raise notice 'v_clientid_cnt % ',v_clientid_cnt;

	UPDATE AFCARSCARESRESPONSE ACR
		SET activeflag = 0,
		updatedon = current_timestamp 
	WHERE RESPONSEID = (SELECT MIN(RESPONSEID) FROM AFCARSCARESRESPONSE CR);

	raise notice 'upd 1';

	--UPDATE AFCARSFOSTERCARE_NEW AF
	--SET (IVAFLAG,XIXFLAG) = (SELECT ELEMENT61SW :: varchar,ELEMENT63sw :: varchar FROM AFCARSCARESRESPONSE AR WHERE AF.FK_ID = AR.CJAMSPID::varchar AND AR.ACTIVEFLAG = 1);
	/* Commented on 04/15
	UPDATE AFCARSFOSTERCARE_NEW AF SET (IVAFLAG,XIXFLAG) =
	(SELECT ELEMENT61SW :: varchar,ELEMENT63sw :: varchar 
		FROM AFCARSCARESRESPONSE AR
		JOIN PERSON P ON TRUNC(P.CISCLIENTID) = TRUNC(AR.CISCLIENTID) AND P.ACTIVEFLAG = 1
		WHERE AF.FK_ID = P.CJAMSPID::varchar AND AR.ACTIVEFLAG = 1);
	*/
				
	OPEN cur_interface_updates FOR		
		select afcarsfostercareid, fk_id::bigint  
			from afcarsfostercare_new
		where activeflag = '1';	
	LOOP
		fetch cur_interface_updates into cur_interface_updates_rec;
		exit when not found;
		
		vs_afcarsfostercareid := cur_interface_updates_rec.afcarsfostercareid;
		vl_client_id := cur_interface_updates_rec.fk_id;
		
		raise notice 'vs_afcarsfostercareid % ', vs_afcarsfostercareid ;
		raise notice 'vl_client_id % ', vl_client_id ;
		
		vs_cisclientid := null;
		vs_element61sw := null;
		vs_element63sw := null;
		vs_element62sw := null; 
		vb_ene_response := False;
		
		select cisclientid 
			into vs_cisclientid
		from person 
		where cjamspid = vl_client_id
			and activeflag = 1 ;
			
		raise notice 'vs_cisclientid % ', vs_cisclientid ;	

		IF vs_cisclientid is not null THEN
			
			-- Get CARES Response
			vs_element61sw := null::varchar;
			vs_element63sw := null::varchar;
			
			select element61sw::varchar,
				element63sw::varchar 
			into vs_element61sw,
				vs_element63sw
			from afcarscaresresponse ar
			where btrim(ar.cisclientid) = vs_cisclientid
				and ar.activeflag = '1'
			order by insertedon desc
			limit 1 ;
			
			-- Get CSES Response
			vs_element62sw := null::varchar;
			
			select element62sw::varchar 
				into vs_element62sw
			from afcarscsesresponse  
			where btrim(cisclientid) = vs_cisclientid
				and activeflag = '1'
			order by insertedon desc
			limit 1 ;

			-- Get E&E Response
			vs_ene_element61sw := null::varchar;
			vs_ene_element63sw := null::varchar;
			
			select ivaflag,
				xixflag 
			into vs_ene_element61sw,
				vs_ene_element63sw
			from afcarseneresponse 
			where afcarsfostercareid = vs_afcarsfostercareid
				and activeflag  = '1'  ;
				
			
			IF vs_ene_element61sw is not null or vs_ene_element63sw is not null THEN
				-- raise notice 'E&E vs_ene_element61sw % ', vs_ene_element61sw ;	
				-- raise notice 'E&E vs_ene_element63sw % ', vs_ene_element63sw ;	
				vb_ene_response := True;
			
				Update afcarsfostercare_new
				set IVAFLAG = vs_ene_element61sw,
					XIXFLAG = vs_ene_element63sw,
				--	IVDFLAG = vs_element62sw,
					updatedby = 'ENE_INTFC'
				where afcarsfostercareid = vs_afcarsfostercareid ;
			ELSE
				-- raise notice 'CARES vs_element61sw % ', vs_element61sw ;	
				-- raise notice 'CARES vs_element63sw % ', vs_element63sw ;	
				-- raise notice 'CSES vs_element62sw % ', vs_element62sw ;	
				
				Update afcarsfostercare_new
				set IVAFLAG = vs_element61sw,
					XIXFLAG = vs_element63sw,
				--	IVDFLAG = vs_element62sw,
					updatedby = 'LGCY_INTFC'
				where afcarsfostercareid = vs_afcarsfostercareid ;
			END IF;
			
			-- Get CSMS Response - B-130478
			vs_csms_element62sw := null::varchar;
			
			select ivdflag
				into vs_csms_element62sw
			from afcarscsmsresponse 
			where afcarsfostercareid = vs_afcarsfostercareid
				and activeflag  = '1'  ;
			
			IF vb_ene_response = true and vs_csms_element62sw is not null THEN
				v_updatedby := 'EECS_INTFC';
			ELSEIF vs_csms_element62sw is not null THEN
				v_updatedby := 'CSMS_INTFC';
			ELSE
				v_updatedby := 'LGCY_INTFC';
			END IF;
			
			IF vs_csms_element62sw is not null THEN
				Update afcarsfostercare_new
				set IVDFLAG = vs_csms_element62sw,
					updatedby = v_updatedby
				where afcarsfostercareid = vs_afcarsfostercareid ;
			ELSE
				Update afcarsfostercare_new
				set IVDFLAG = vs_element62sw
				where afcarsfostercareid = vs_afcarsfostercareid ;
			END IF;
		END IF;
	END LOOP;			

	
	--UPDATE AFCARSFOSTERCARE_NEW AF
	--SET IVDFLAG = (SELECT ELEMENT62SW ::varchar FROM AFCARSCSESRESPONSE AR WHERE AF.FK_ID = AR.CJAMSPID::varchar AND AR.ACTIVEFLAG = 1);
	/* Commented on 04/15
	UPDATE AFCARSFOSTERCARE_NEW AF 
		SET IVDFLAG = 
				(	SELECT ELEMENT62SW ::varchar 
					FROM AFCARSCSESRESPONSE AR 
						JOIN PERSON P ON BTRIM(P.CISCLIENTID) = BTRIM(AR.CISCLIENTID) 
							AND P.ACTIVEFLAG = 1 
					WHERE AR.ACTIVEFLAG = 1
						AND P.CJAMSPID::varchar = AF.FK_ID
				);
	*/
	
	raise notice 'upd 2';
	-- Update E&E Responses
	raise notice 'upd 3';

	UPDATE afcarsfostercare_new 
		SET nofederalsupportflag = 
			(	CASE WHEN ivefostercareflag = '1' OR iveadoptionflag = '1' OR ivaflag = '1' OR ivdflag = '1' 
					OR xixflag = '1' OR ssiorssaflag = '1' THEN '0' ELSE '1' END);

	raise notice 'upd 4';

	UPDATE AFCARSFOSTERCARE_NEW 
		SET IVAFLAG = '0' 
	WHERE IVAFLAG IS NULL;
	
	UPDATE AFCARSFOSTERCARE_NEW SET XIXFLAG = '0' WHERE XIXFLAG IS NULL;
	UPDATE AFCARSFOSTERCARE_NEW SET IVDFLAG = '0' WHERE IVDFLAG IS NULL;

	UPDATE AFCARSFOSTERCARE_NEW
	SET fosterfamilystructuretypekey = '0'
		, FOSTERCARE1BIRTHYEAR = '0'
		, FOSTERCARE2BIRTHYEAR = '0'
		, fostercare1raceaitypekey = '0'
		, fostercare1raceasiantypekey = '0'
		, FOSTERCARE1RACEBLACKtypekey = '0'
		, FOSTERCARE1RACEHAWAIIANtypekey = '0'
		, FOSTERCARE1RACEWHITEtypekey = '0'
		, FOSTERCARE1RACEUNtypekey = '0'
		, FOSTERCARE1HISPANICtypekey = '0'
		, FOSTERCARE2RACEAItypekey = '0'
		, FOSTERCARE2RACEASIANtypekey = '0'
		, FOSTERCARE2RACEBLACKtypekey = '0'
		, FOSTERCARE2RACEHAWAIIANtypekey = '0'
		, FOSTERCARE2RACEWHITEtypekey = '0'
		, FOSTERCARE2RACEUNtypekey = '0'
		, FOSTERCARE2HISPANICtypekey = '0'
	WHERE PLACEMENTSETTINGTYPEKEY not in ('1','2','3');

	raise notice 'upd 4';

	VS_MONTH := (SELECT substring(reportpdenddate,5,2) FROM AFCARSFOSTERCARE_NEW FETCH FIRST 1 ROW ONLY) :: varchar;
	VS_YEAR := (SELECT substring(reportpdenddate,1,4) FROM AFCARSFOSTERCARE_NEW FETCH FIRST 1 ROW ONLY) :: varchar;

	IF VS_MONTH = '03' THEN
		VS_DAY := VS_YEAR ||'-'|| VS_MONTH||'-'||'31';
	ELSE
		VS_DAY := VS_YEAR||'-'|| VS_MONTH ||'-'||'30';
	END IF;

	UPDATE AFCARSFOSTERCARE_NEW
		SET DISCHARGETRANSACTIONDT = '',
			DISCHARGEREASONtypekey = ''
	WHERE LENGTH(RTRIM(DISCHARGEdate)) = 0;

	raise notice 'upd 5';
	/* 
	if( v_clientid_cnt = 0 ) then
	  raise exception  'No Data Found';
	end if; */


	OPEN ELEMENT_65;
	LOOP 
		FETCH ELEMENT_65 INTO VN_CLIENT_ID; 

		raise notice 'VN_CLIENT_ID % ',VN_CLIENT_ID;
		--WHILE (SQLSTATE = '00000') loop
		EXIT WHEN NOT FOUND;

		--WHILE (v_clientid_cnt > 0 ) loop
		-- PRJ-05417 Comment logic for Element65. logic for this element65 is now in 
		-- procedure SP_AFCARS_IVE_DETAILS.
        --SELECT COUNT(*) INTO VN_65_CNT
        --FROM TB_AFCARS_FOSTERCARE
        --WHERE CLIENT_ID = VN_CLIENT_ID
        --AND (IV_E_FOSTERCARE_SW = '1' OR
        --     IV_E_ADOPTION_SW = '1' OR
        --     IV_A_SW = '1' OR
        --     IV_D_SW = '1' OR
        --     XIX_SW = '1' OR
        --     SSI_OR_SSA_SW = '1');

        --IF VN_65_CNT > 0 THEN
        --      UPDATE TB_AFCARS_FOSTERCARE
        --      SET NO_FEDERAL_SUPPORT_SW = '0'
        --      WHERE CLIENT_ID = VN_CLIENT_ID;
        --ELSE
        --      UPDATE TB_AFCARS_FOSTERCARE
        --      SET NO_FEDERAL_SUPPORT_SW = '1'
        --      WHERE CLIENT_ID = VN_CLIENT_ID;
        --END IF;
		-- PRJ-05417 Comment End.

        SELECT COUNT(*) 
			INTO VN_DSCHRG_DT
        FROM AFCARSFOSTERCARE_NEW
        WHERE fk_id = VN_CLIENT_ID  
		AND ACTIVEFLAG = '1'
        AND fk_id IN (	SELECT 	fk_id 
						FROM	(  SELECT TO_DATE((substring(DISCHARGEDATE,1,4)||'-' || substring(DISCHARGEDATE,6,2)||'-'||substring(DISCHARGEDATE,9,2)),'yyyy-mm-dd') DATE,
										fk_id
                                   FROM AFCARSFOSTERCARE_NEW
                                   WHERE LENGTH(LTRIM(RTRIM(DISCHARGEDATE))) > 0
                                ) TAB
                        WHERE TAB.DATE > to_DATE(VS_DAY,'yyyy-mm-dd')
					);
	
		RAISE NOTICE 'VN_DSCHRG_DT % ',VN_DSCHRG_DT;
		
        IF VN_DSCHRG_DT > 0 THEN
			UPDATE AFCARSFOSTERCARE_NEW
			SET DISCHARGETRANSACTIONDT = '',
				DISCHARGEREASONtypekey = '',
				DISCHARGEDATE = ''
			WHERE fk_id = VN_CLIENT_ID;
		END IF;

        VN_DSCHRG_DT := 0;

        SELECT COUNT(*) 
			INTO VN_REM_ST_DT_CNT
        FROM AFCARSFOSTERCARE_NEW
        WHERE fk_id = VN_CLIENT_ID   
			AND ACTIVEFLAG = '1'
			AND fk_id IN (SELECT fk_id FROM
                                (  SELECT to_DATE(substring(firstremovaldate,1,4)||'-' ||substring(firstremovaldate,6,2)||'-'||substring(firstremovaldate,9,2), 'yyyy-mm-dd') DATE,
										fk_id
                                   FROM AFCARSFOSTERCARE_NEW
                                   WHERE LENGTH(LTRIM(RTRIM(FIRSTREMOVALDATE))) > 0
                                ) TAB
                          WHERE TAB.DATE > to_DATE(VS_DAY,'yyyy-mm-dd')
						);

		RAISE NOTICE 'VN_REM_ST_DT_CNT % ',VN_REM_ST_DT_CNT;

        IF VN_REM_ST_DT_CNT > 0 THEN
			UPDATE AFCARSFOSTERCARE_NEW
				SET activeflag = '0'
			WHERE fk_id = VN_CLIENT_ID;
		END IF;

        VN_REM_ST_DT_CNT := 0;

        SELECT COUNT(*) 
			INTO VN_REM_CNT
        FROM AFCARSFOSTERCARE_NEW
        WHERE fk_id = VN_CLIENT_ID  
			AND ACTIVEFLAG = '1'
			AND firstremovaldate IS NULL;

		IF VN_REM_CNT > 0 THEN
			UPDATE AFCARSFOSTERCARE_NEW
				SET activeflag ='0'
			WHERE fk_id = VN_CLIENT_ID;
		END IF;

	END LOOP;
	CLOSE ELEMENT_65;
	
	return v_SQLCODE;
	-- EXCEPTION WHEN OTHERS THEN      
	-- return sqlstate||' '||sqlerrm;

END;
$function$
;

