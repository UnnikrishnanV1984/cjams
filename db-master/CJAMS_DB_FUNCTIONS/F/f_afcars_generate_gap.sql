DROP FUNCTION if exists cjams.f_afcars_generate_gap(bigint, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.f_afcars_generate_gap(	vl_summary_id bigint,
														vdt_from character varying, 
														vdt_to character varying, 
														OUT vl_output_sqlcode integer, 
														OUT vs_message character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Description: Stored Procedure to generate AFCARS GAP Data
-- 04/18/2024 - To include GAP cases on AFCARS Adoption Reporting (CIDM-8193)

-- Revision(s):
-- 04/22/2025 - Vineet Tirodkar - To fix 2025A Non-compliance errors (CIDM-10422)
--				1) A6_to_A13_declined_inconsistency If A13_child_race_declined = 1 (Yes), data elements A6-A12 must all be 0 (No).
------------------------------------------------------------------------

Declare vs_output_state char(5) default '00000';
Declare vl_excep_message varchar;
Declare vs_state_cd varchar(2) default '24';
Declare vs_user_id varchar(10) default 'interface';
Declare vl_excep_flag integer;
Declare vs_year varchar(4) default null;
Declare vs_month varchar(2) default null;
Declare vs_day varchar(2) default null;
Declare vdt_year_mnth_day varchar default null;
Declare vdt_year_year_day varchar;
Declare vl_provider_id integer default 0;
Declare vs_report_pd_end_dt varchar(6);
Declare vs_actual_period varchar(6);
Declare vs_record_no varchar(12);
Declare vs_agency_involvement_cd varchar(1) default '1';
Declare vs_child_dob varchar(10);
Declare vs_gender_cd varchar(5);
Declare vs_race_ai_cd varchar(5) default '';
Declare vs_race_asian_cd varchar(5) default '';
Declare vs_race_black_cd varchar(5) default '';
Declare vs_race_hawaiian_cd varchar(5) default '';
Declare vs_race_white_cd varchar(5) default '';
Declare vs_race_un_cd varchar(5) default '';
Declare vs_hispanic_cd varchar(5) default '3';
Declare vs_adoption_finalized_dt varchar(10);
Declare vs_a12_child_race_abandoned character varying;
Declare vs_a13_child_race_declined character varying;
Declare vs_a15_assistance_agreement_type character varying;
Declare vs_agreement_start_date character varying;
Declare vs_a18_agreement_termination_date character varying;
Declare vs_a4_child_date_of_birth character varying;
Declare vl_record_count Bigint default 0;
Declare vs_child_placed_by_cd varchar(5) default '';
Declare vs_subsidy_payment_amt varchar(5) default '00000';
	
Declare vu_gapid uuid;
Declare vu_gapagreementid uuid;
Declare vu_personid uuid;

Declare vl_gap_casenumber bigint;
Declare vl_client_id bigint;
Declare vl_guardian_subsidy_id bigint;
-- Declare vl_provider_id bigint;

Declare vd_agreement_start_date timestamp;
Declare vd_agreement_end_date timestamp;

DECLARE GAP_CASE_CLIENS_CUR CURSOR FOR 
	select g.gapid,
		ga.gapagreementid,
		sc.servicecasenumber::bigint as case_id,
		p.cjamspid as client_id,
		p.personid, 
		g.alternateid as guardian_subsidy_id,
		/*
		(	select gar.provider_id
			   from gapagreementrate gar
			where gar.gapagreementid = ga.gapagreementid 
				and gar.activeflag = 1
			order by gar.startdate desc
			limit 1
		) as provider_id,
		*/
		ga.startdate::date as agreement_start_date,
		ga.enddate::date as agreement_end_date
	from guardianship g
		join gapagreement ga on ga.gapid = g.gapid 
			and ga.activeflag = 1
		join permanencyplan pp on pp.permanencyplanid = g.permanencyplanid 
			and pp.activeflag = 1
		join intakeservicerequestactor isra on isra.intakeservicerequestactorid = pp.intakeservicerequestactorid 
			and isra.activeflag = 1
		join person p on p.personid = isra.personid 
			and p.activeflag = 1
		join servicecase sc on sc.servicecaseid = g.servicecaseid 
			and sc.activeflag = 1
	where ga.startdate::date::date <= vdt_to::date 
		and ga.enddate::date >= vdt_from::date	
		and g.activeflag = 1
		and ( select count(*)
			   from routing
			  where routing.routingstatustypeid = 16 
					and routing.eventcode::text = 'GAAR'::text 
					and routing.activeflag = 1 
					and routing.objectid::text = ga.gapagreementid::character varying::text
			 ) > 0
	;
						
BEGIN 
	RAISE NOTICE 'vl_summary_id %', vl_summary_id;
	
	OPEN GAP_CASE_CLIENS_CUR;

    << GAP_CASE_CLIENS_CUR >>
	
    LOOP FETCH GAP_CASE_CLIENS_CUR INTO vu_gapid,
										vu_gapagreementid,
										vl_gap_casenumber, 
										vl_client_id,
										vu_personid,
										vl_guardian_subsidy_id,
										-- vl_provider_id,
										vd_agreement_start_date,
										vd_agreement_end_date;
 
             
		EXIT WHEN NOT FOUND;
		
		vl_record_count := vl_record_count + 1 ;
		
		RAISE NOTICE 'vl_record_count %', vl_record_count;
		RAISE NOTICE 'vl_guardian_subsidy_id %', vl_guardian_subsidy_id; 
		
		VL_EXCEP_FLAG:=0;
		
	----------------------------- Element 2 -----------------------------
	
		vs_year := substring (vdt_to,1,4);
		vs_month := substring( vdt_to,6,2);
		vs_report_pd_end_dt := ltrim(vs_year) ||  ltrim(vs_month);--09-30 

	----------------------------- Element 3 -----------------------------
		BEGIN 
			
			select f_afcars_encryptv1(vl_client_id::varchar) INTO vs_record_no;
		
			EXCEPTION WHEN OTHERS THEN 
				VL_EXCEP_FLAG := 1 ;
				VL_OUTPUT_SQLCODE :=  SQLSTATE;
				VS_MESSAGE := 'GAP - ELEMENT 3 CLIENT ID ECNCRYPTION FAILED';
				RETURN;
		END;

	----------------------------- Element 5 To 8 -----------------------------
		
		BEGIN 
		
			SELECT	case when COUNT(*) FILTER (WHERE pr.racetypekey like '%AI%') > 0 then '1' 
				when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AN%' ) > 0 then '1' else '0' end, 
				case when COUNT(*) FILTER (WHERE pr.racetypekey like '%AS%') > 0 then '1' else '0' end, 
				case when COUNT(*) FILTER (WHERE pr.racetypekey like '%BA%') > 0 then '1' else '0' end, 
				case when COUNT(*) FILTER (WHERE pr.racetypekey like '%WH%') > 0 then '1' else '0' end, 
				case when COUNT(*) FILTER (WHERE pr.racetypekey like '%PI%') > 0 then '1' else '0' end,
				case when COUNT(*) FILTER (WHERE pr.racetypekey like '%UN%') > 0 then '1' 
				when COUNT(*) FILTER (WHERE pr.racetypekey like '%DC%') > 0 then '1' else '0' end
			INTO vs_race_ai_cd,
				vs_race_asian_cd,
				vs_race_black_cd,
				vs_race_white_cd,
				vs_race_hawaiian_cd,
				vs_race_un_cd
			from personracetypemap pr
			where pr.personid = vu_personid
				and pr.activeflag = 1;
			
		
			SELECT  EXTRACT(MONTH FROM dob) AS DOBMONTH, 
				EXTRACT(YEARS FROM dob) AS DOBYEAR, 
				AFC.afcars_ref_cd as gendertype, 
				CASE WHEN pp.ethnicgrouptypekey = 'H' THEN '1'
					WHEN pp.ethnicgrouptypekey = 'X' THEN '2'
					WHEN pp.ethnicgrouptypekey = 'U' THEN '3'
					else '3'
				END,
				(dob::date)::character varying
			into vdt_year_mnth_day, 
				vdt_year_year_day, 
				vs_gender_cd, 
				vs_hispanic_cd,
				vs_a4_child_date_of_birth
			from person PP 
				LEFT JOIN afcars_ref_code afc on afc.afcars_ref_type = 'sex' 
					and PP.gendertypekey = afc.cjams_cd 
					and AFC.activeflag = 1 
			where PP.cjamspid = vl_client_id
				and PP.activeflag = 1;
					
			if (vs_race_ai_cd = '0' and 
				vs_race_asian_cd = '0' and 
				vs_race_black_cd = '0' and  
				vs_race_hawaiian_cd = '0' and  
				vs_race_white_cd = '0') then
					vs_race_un_cd = '1';  
			end if;		
			
			if (vs_race_ai_cd = '1' or 
				vs_race_asian_cd = '1' or 
				vs_race_black_cd = '1' or  
				vs_race_hawaiian_cd = '1' or  
				vs_race_white_cd = '1') then
					vs_race_un_cd = '0';  
			end if;
					 
			vs_child_dob := vdt_year_mnth_day || vdt_year_year_day;

			EXCEPTION WHEN OTHERS THEN 
				VL_EXCEP_FLAG := 1;
				VL_OUTPUT_SQLCODE :=  SQLSTATE;
				VS_MESSAGE := 'GAP - Element 5 to 8 FAILED';
				RETURN;

		END;

	----------------------------- Element 21 -----------------------------
		BEGIN 
			
			VS_ADOPTION_FINALIZED_DT := cast(to_char(vd_agreement_start_date,'MM/DD/YYYY') as character varying); 
			
			if DATE_PART('MONTH', vd_agreement_start_date) in (10, 11, 12, 1, 2, 3) then 
				if DATE_PART('MONTH', vd_agreement_start_date) in (1, 2, 3) then 
					VS_ACTUAL_PERIOD := rtrim( DATE_PART('YEAR', vd_agreement_start_date):: TEXT)|| '03';

				else 
					VS_ACTUAL_PERIOD := rtrim(( DATE_PART('YEAR', vd_agreement_start_date )+ 1 ):: TEXT)|| '03';
				end if;
			else 
				VS_ACTUAL_PERIOD := rtrim(DATE_PART('YEAR', vd_agreement_start_date ):: TEXT)|| '09';
			end if;
			
		END;
		
	
	----------------------------- Element 34 -----------------------------
		/*
		Element # 19 Adoption or Guardianship Placing Agency 	

		1 = Title IV-E agency 
		2 = Private agency
		3 = Tribe 
		*/
		BEGIN 
				
			VS_CHILD_PLACED_BY_CD := '1'; --  Title IV-E agency 
			
		END; 
	
	----------------------------- Element 36 -----------------------------
		BEGIN 
			vs_subsidy_payment_amt = '0000';
			
			select (CASE WHEN (gar.paymentamout IS NOT NULL and round(gar.paymentamout, 0) > 0) THEN 
						substring((round(gar.paymentamout, 0)::decimal)::varchar,1,5) 
					ELSE 
						'0000' 
					END)
				into vs_subsidy_payment_amt
			from gapagreementrate gar
			where gar.gapagreementid = vu_gapagreementid
				and gar.activeflag = 1
			order by gar.startdate desc
			limit 1 ;
		  
			
			if vs_subsidy_payment_amt is null then
				vs_subsidy_payment_amt = '0000';
			end if;
			
			EXCEPTION WHEN OTHERS THEN 
				VL_EXCEP_FLAG:= 1 ;
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'GAP - Element 36 FAILED';
				RETURN;
					
		END;

	-------------------------- New AFCARS 2.0 Elements --------------------------
		Begin 

			-- Child Race: Abandoned
			vs_A12_child_race_abandoned := NULL;

			select (case when count(*) > 0 then '1' else '0' end) 
				into vs_A12_child_race_abandoned
			from personracetypemap prt,
				referencevalues race 
			where race.ref_key = prt.racetypekey
				and prt.personid = vu_personid
				and prt.activeflag = 1
				and race.referencetypeid = 171
				and race.ref_key = 'AB' ;
			
			-- Childs Race: Declined 	
			vs_A13_child_race_declined := NULL;
			
			select (case when count(*) > 0 then '1' else '0' end) 
				into vs_A13_child_race_declined
			from personracetypemap prt,
				referencevalues race 
			where race.ref_key = prt.racetypekey
				and prt.personid = vu_personid
				and prt.activeflag = 1
				and race.referencetypeid = 171
				and race.ref_key = 'DC' ;


			-- 04/22/2025
			IF vs_A13_child_race_declined = '1' or vs_A12_child_race_abandoned = '1' THEN
				VS_RACE_UN_CD := '0';  
			END IF;
			
			-- Assistance Agreement Type
			-- 1 = Adoption 
			-- 2 = Guardianship 
			vs_A15_assistance_agreement_type := '2' ;
		
			vs_agreement_start_date := NULL;
			vs_a18_agreement_termination_date := NULL;
				
			
			select vd_agreement_start_date::character varying, 
				(case when vd_agreement_end_date::date <= vdt_to::DATE then
					vd_agreement_end_date::character varying 
				 else
					null::character varying 
				end ) 	
			into vs_Agreement_Start_date,
				vs_A18_agreement_termination_date;
		end;
	-------------------------- New AFCARS 2.0 Elements --------------------------
		
		BEGIN 

			INSERT INTO afcarsadoptiondetail 
			(
			  summaryid, 
			  submittedperiod, 
			  actualperiod, 
			  statetypekey, 
			  reportpdenddate, 
			  recordno, 
			  agencyinvolvementtypekey, 
			  childdob, 
			  gendertypekey, 
			  raceaitypekey, 
			  raceasiantypekey, 
			  raceblacktypekey, 
			  racehawaiiantypekey, 
			  racewhitetypekey, 
			  raceuntypekey, 
			  hispanictypekey, 
			  adoptionfinalizeddt, 
			  childplacedbytypekey, 
			  subsidypaymentamount, 
			  insertedon, 
			  insertedby, 
			  updatedon, 
			  updatedby, 
			  activeflag, 
			  clientid,
			  ------ New AFCARS 2.0 Elements ---------
			  a12_child_race_abandoned,
			  a13_child_race_declined,
			  a15_assistance_agreement_type,
			  agreement_start_date,
			  a18_agreement_termination_date,
			  a4_child_date_of_birth,
			  adoption_gap_casetype
			) 
			VALUES 
			(
				vl_summary_id, 
				VS_REPORT_PD_END_DT, 
				VS_ACTUAL_PERIOD, 
				VS_STATE_CD, 
				RTRIM(LTRIM(VS_REPORT_PD_END_DT)), 
				VS_RECORD_NO, 
				VS_AGENCY_INVOLVEMENT_CD, 
				VS_CHILD_DOB, 
				VS_GENDER_CD, 
				VS_RACE_AI_CD, 
				VS_RACE_ASIAN_CD, 
				VS_RACE_BLACK_CD, 
				VS_RACE_HAWAIIAN_CD, 
				VS_RACE_WHITE_CD, 
				VS_RACE_UN_CD, 
				VS_HISPANIC_CD, 
				VS_ADOPTION_FINALIZED_DT, 
				VS_CHILD_PLACED_BY_CD, 
				VS_SUBSIDY_PAYMENT_AMT, 
				CURRENT_TIMESTAMP, 
				VS_USER_ID, 
				CURRENT_TIMESTAMP, 
				VS_USER_ID, 
				1, 
				VL_CLIENT_ID,
				------ New AFCARS 2.0 Elements ---------
				vs_A12_child_race_abandoned,
				vs_A13_child_race_declined,
				vs_A15_assistance_agreement_type,
				vs_Agreement_Start_date,
				vs_A18_agreement_termination_date,
				vs_A4_child_date_of_birth,
				'GAP'
			  );
			  
			  EXCEPTION WHEN others then                                      
			  
				VL_EXCEP_FLAG:= 1 ;
				VS_OUTPUT_STATE := sqlstate;
				VS_MESSAGE:='SQLSTATE:' || VS_OUTPUT_STATE 
						|| ' GAP - INSERT INTO afcarsadoptiondetail FAILED '|| (vl_client_id::VARCHAR);
				
			end;
			
			IF VL_EXCEP_FLAG = 1 THEN 
				
				INSERT INTO	interfaceserrorlog( interfaceid, 
												currentruntimestamp, 
												errorlineno,
												errorcode,
												errordescription, 
												insertedon) 
				VALUES 						(  'AFCARS ADOPTION (GAP)', 
												CURRENT_TIMESTAMP, 
												000, 
												VS_MESSAGE, 
												VS_OUTPUT_STATE, 
												CURRENT_DATE );
				
												
				RETURN;
			END IF;
    END LOOP;
	
	CLOSE GAP_CASE_CLIENS_CUR;
	
	RAISE NOTICE 'GAP PROCESS END';
	
	IF VL_EXCEP_FLAG = 1 THEN 
            
		INSERT INTO	interfaceserrorlog( interfaceid, 
										currentruntimestamp, 
										errorlineno,
										errorcode,
										errordescription, 
										insertedon) 
		VALUES 						(  'AFCARS ADOPTION (GAP)', 
										CURRENT_TIMESTAMP, 
										000, 
										VL_EXCEP_MESSAGE, 
										VS_OUTPUT_STATE, 
										CURRENT_DATE );
										
	
											
		RETURN;
	END IF;
	
	VL_OUTPUT_SQLCODE := 0;
	VS_MESSAGE:= 'GAP SP RAN SUCCESSFULLY';

END;
$function$
;

