CREATE OR REPLACE FUNCTION cjams.sp_cses_outbound_interface_gen_data_01(vl_client_id integer, vl_other_id bigint, vs_transaction_type_cd character varying, vl_transaction_sequence integer, vd_transaction_ts timestamp without time zone, OUT vs_message character varying, OUT vl_output_sqlcode character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Sudhin
-- Date Created :08/25/2005
-- generates Cares Interface Outbound Data

-- Revision(s)
-- Hema   12/13/05  -   cses Outbound if the child assigned to county
-- display the director name inthe worker name(Incident 5170)
-- 5/31/06 - Tanya Lee - Incident #7740 -- Updated eligibility fields to look at FC and Adoption
-- sandhya -- 02/08/2007 -#12329 added code for subsidy guardianship , 02/19/07 - changed col13 = start date
-- #7739 04/18/07  -- sandhya - To pick Referral date when eligibility status has been end dated.
-- 04.14.2010  --GAYATHRI RAJKUMAR - MAPPED DECLINED RACE TO UNKNOWN.
-- 17-06-2019  -- Swaraj -- Migrations to Postgresql
-- 06/10/2020 Vineet Tirodkar - To fix the get Caseworker & get Case county logic.
-- 06/24/2020 Vineet Tirodkar - To modify logic to send Gender as 'U' for all other types than Male & Female 
-- 06/30/2020 Vineet Tirodkar - Modifications to send 'Unknown' for racetypekey 'Other' ro any not known code to MD CHESSIE 
-- 08/20/2020 Vineet Tirodkar - Modifications to send only Valid (Numeric) SSN attribute values (CDM-3270)
-- 09/25/2020 Vineet Tirodkar - Changes to trim and compare Eligibility Status Code (CDM-4684)
-- 03/08/2021 Vineet Tirodkar - Modifications for person name suffix logic fix (CIDM-2204)
-- 08/03/2021 Vineet Tirodkar - Modifications to send Client Person First/Last Names first 20 characters only 
--								and Middle Name first 10 characters (CDM-15668)
-- 05/03/2022 Vineet Tirodkar - Modifications for Worker Phone Number fix (CIDM-4512)
-------------------------------------------------------------------
DECLARE
	VS_RECORD_TYPE VARCHAR(2);
	VS_OUTPUT_STATE VARCHAR(5) DEFAULT '00000';
	VL_RECORD_SEQUENCE INTEGER DEFAULT 000;
	VS_TRANSACTION_SEQUENCE VARCHAR(5);
	VS_RECORD_SEQUENCE VARCHAR(3);
	-- Client Variables
	VL_STAFF_ID VARCHAR;
	VS_CIS_CLIENT_ID VARCHAR(10);
	VL_PROVIDER_ID INTEGER;
	VL_PLACEMENT_CASE_ID VARCHAR;
	csesoutcol1 CHAR(1);
	csesoutcol2 CHAR(1);
	csesoutcol3 INTEGER;
	VL_PLACEMENT_ENTRY  VARCHAR;
	VL_PLACEMENT_EXIT  VARCHAR;
	VL_ELIGIBILITY_DET_DATE INTEGER;
	VL_ELIGIBILITY_REDET_DATE INTEGER;
	VS_PRIMARY_COUNTY_CD CHAR(2); -- CSES_OUT_COL4
	V_PRIMARY_COUNTY_CD VARCHAR(4);
	VS_WORKER_NAME VARCHAR(50); -- CSES_OUT_COL5
	VS_WORKER_PHONE VARCHAR(32); -- CSES_OUT_COL6

	VS_CLIENT_SURNAME VARCHAR(20); -- CSES_OUT_COL7
	VS_CLIENT_GIVENNAME VARCHAR(20); -- CSES_OUT_COL8
	VS_CLIENT_MIDDLENAME VARCHAR(10); -- CSES_OUT_COL9
	VS_CLIENT_SUFFIX VARCHAR(5); -- CSES_OUT_COL10
	VL_SSN_NO VARCHAR; -- CSES_OUT_COL11
	VL_DOB_DT INTEGER; -- CSES_OUT_COL12
	VS_CLIENT_GENDER CHAR(1); -- CSES_OUT_COL13
	VS_CLIENT_RACE VARCHAR(1000); -- CSES_OUT_COL14

	csesoutcol15 INTEGER;
	csesoutcol16 DECIMAL(10,2);
	csesoutcol16_CONVERT VARCHAR(15);
	csesoutcol17 INTEGER;
	service_case_id uuid;
	sec_id uuid;
	
BEGIN
 
	VL_OUTPUT_SQLCODE := '00000';
	-- SET transaction sequence
	VS_TRANSACTION_SEQUENCE := LTRIM(RTRIM(CAST(VL_TRANSACTION_SEQUENCE AS VARCHAR))) ;

	-- Get CIS_CLIENT_ID
	BEGIN
		SELECT person.cisclientid
			INTO VS_CIS_CLIENT_ID
		FROM person  	
		WHERE person.cjamspid =  VL_CLIENT_ID
			AND person.activeflag = 1;

		EXCEPTION WHEN OTHERS THEN
			VL_OUTPUT_SQLCODE :=SQLSTATE;
			VS_MESSAGE := 'SELECT CIS_CLIENT_ID FAILED FOR person'  || SQLERRM ;
			RETURN;
	END; 

    -- Generate records for record type 01
    VS_RECORD_TYPE := '01';

    IF VS_RECORD_TYPE = '01' THEN
		VL_RECORD_SEQUENCE := VL_RECORD_SEQUENCE + 1 ;

        if vs_transaction_type_cd = '15' then -- #12329 -- Subsidy Guardianship
			BEGIN     
				SELECT 	*
					INTO csesoutcol1,VL_PROVIDER_ID,VL_PLACEMENT_CASE_ID,VL_PLACEMENT_ENTRY,VL_PLACEMENT_EXIT
                FROM
					   (SELECT 	'S',
								TB_GUARDIAN_SUBSIDY.PROVIDER_ID,
								TB_GUARDIAN_SUBSIDY.CASE_ID,
								to_char(SUBSIDY_START_DT::DATE, 'YYYYMMDD'),
								to_char(SUBSIDY_END_DT::DATE, 'YYYYMMDD')
						FROM    TB_GUARDIAN_SUBSIDY 
						WHERE   CLIENT_ID = VL_CLIENT_ID
								AND     SUBSIDY_END_DT IS NOT NULL
								AND     SUBSIDY_START_DT IS NOT NULL
								AND     CHECK_LIST_APPROVAL_STATUS_CD = '3047'
								AND     SUSBSIDY_APPROVAL_STATUS_CD = '3047'
								AND     DELETE_SW = 'N'
						ORDER BY SUBSIDY_START_DT DESC, GUARDIAN_SUBSIDY_ID DESC) as A
                limit 1;

                 
                EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE:=SQLSTATE;
	                VS_MESSAGE := 'SELECT  FAILED FOR TB_GUARDIAN_SUBSIDY'  || SQLERRM ;
					RETURN;
			END ;

		ELSIF VS_TRANSACTION_TYPE_CD <> '70' and vs_transaction_type_cd <> '15' THEN -- #12329
            BEGIN               
			   SELECT *
					INTO csesoutcol1,VL_PROVIDER_ID,VL_PLACEMENT_CASE_ID,VL_PLACEMENT_ENTRY,VL_PLACEMENT_EXIT
                FROM
                (SELECT  CASE    WHEN PLACEMENT_STRUCTURE_ID = 501 THEN 'A'
								WHEN PLACEMENT_STRUCTURE_ID = 8 THEN 'K'
								ELSE 'F'
                        END,
                        TB_PLACEMENT.PROVIDER_ID,
                        TB_PLACEMENT.CASE_ID :: BIGINT,
						to_char(ENTRY_DT::DATE, 'YYYYMMDD'),
						to_char(EXIT_DT::DATE, 'YYYYMMDD')
                FROM    TB_PLACEMENT
                WHERE   CLIENT_ID = VL_CLIENT_ID
                AND     EXIT_DT IS NULL
                AND     ENTRY_DT IS NOT NULL
                AND     PLACEMENT_STRUCTURE_ID IS NOT NULL
                AND     APPROVAL_STATUS_CD = '3047'
                AND     DELETE_SW = 'N'
                ORDER BY ENTRY_DT DESC, PLACEMENT_ID DESC) AS A
                limit 1;

                
                EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT  FAILED FOR TB_PLACEMENT'  || SQLERRM ;
					RETURN;
	        END ;
		END IF;
	
        IF VS_TRANSACTION_TYPE_CD = '70' THEN
			BEGIN          
				SELECT *
					INTO csesoutcol1,VL_PROVIDER_ID,VL_PLACEMENT_CASE_ID,VL_PLACEMENT_ENTRY,VL_PLACEMENT_EXIT
                FROM
                (SELECT  CASE    WHEN PLACEMENT_STRUCTURE_ID = 501 THEN 'A'
                        WHEN PLACEMENT_STRUCTURE_ID = 8 THEN 'K'
                        ELSE 'F'
                        END,
                        TB_PLACEMENT.PROVIDER_ID,
                        TB_PLACEMENT.CASE_ID,
						to_char(ENTRY_DT::DATE, 'YYYYMMDD'),
					 to_char(EXIT_DT::DATE, 'YYYYMMDD')
                FROM    TB_PLACEMENT
                WHERE   CLIENT_ID = VL_CLIENT_ID
                AND     EXIT_DT IS NOT NULL
                AND     ENTRY_DT IS NOT NULL
                AND     PLACEMENT_STRUCTURE_ID IS NOT NULL
                AND     DELETE_SW = 'N'
                ORDER BY ENTRY_DT DESC, PLACEMENT_ID DESC) AS A
                limit 1;

                EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT  FAILED FOR TB_PLACEMENT '  || SQLERRM ;
					RETURN;
	        END ;
        END IF;

        IF VS_TRANSACTION_TYPE_CD = '15' THEN -- #12329
			csesoutcol2 := 'S';
			csesoutcol3 := VL_PLACEMENT_ENTRY; -- SUBSIDY_START_DT
		ELSE
			BEGIN             
				SELECT * INTO csesoutcol2,VL_ELIGIBILITY_DET_DATE,VL_ELIGIBILITY_REDET_DATE
					FROM (SELECT CASE WHEN btrim(ELIGIBILITY_STATUS_CD) IN ('2912','2913','3597','3598') THEN 'F'
							WHEN btrim(ELIGIBILITY_STATUS_CD) = '2914' THEN 'S'
							WHEN btrim(ELIGIBILITY_STATUS_CD) = '2909' THEN 'P'
							WHEN btrim(ELIGIBILITY_STATUS_CD) = '2910' THEN 'U'
							WHEN btrim(ELIGIBILITY_STATUS_CD) = '2911' THEN 'V'
							END,
					to_char(START_DT,'yyyymmdd')::INTEGER,
					CASE WHEN btrim(ELIGIBILITY_STATUS_CD) IN ('2912','2913','3597','3598')
					THEN to_char(START_DT+ Interval '6 months','yyyymmdd')::INTEGER
					END	
                FROM TB_CLIENT_ELIGIBILITY
                WHERE TB_CLIENT_ELIGIBILITY.CLIENT_ID = VL_CLIENT_ID
				--  Incident #7740
				--	AND TB_CLIENT_ELIGIBILITY.ELIGIBILITY_TYPE_CD = '2931'
                AND btrim(TB_CLIENT_ELIGIBILITY.ELIGIBILITY_TYPE_CD) IN ('2931','2934')
                AND TB_CLIENT_ELIGIBILITY.START_DT IS NOT NULL
                --AND TB_CLIENT_ELIGIBILITY.END_DT IS NULL  -- #7739 04.18.07
                AND TB_CLIENT_ELIGIBILITY.DELETE_SW = 'N'
                ORDER BY TB_CLIENT_ELIGIBILITY.START_DT DESC, TB_CLIENT_ELIGIBILITY.ELIGIBILITY_ID DESC) AS A
                limit 1;
	
                
                EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT  FAILED FOR TB_CLIENT_ELIGIBILITY '  || SQLERRM ;
					RETURN;
			END ;

			-- Since referral category is required field set it to 'U'
			IF csesoutcol2 = '' OR csesoutcol2 IS NULL OR LENGTH(csesoutcol2) <= 0 THEN
				csesoutcol2 := 'U';
			END IF;
		END IF;	
	
		IF VS_TRANSACTION_TYPE_CD = '10' THEN
			csesoutcol3 := VL_PLACEMENT_ENTRY  ;
		ELSIF VS_TRANSACTION_TYPE_CD = '70' THEN
			csesoutcol3 := VL_PLACEMENT_EXIT     ;
		ELSIF VS_TRANSACTION_TYPE_CD = '20' THEN
			csesoutcol3 := VL_ELIGIBILITY_DET_DATE   ;
		ELSIF VS_TRANSACTION_TYPE_CD = '30' THEN
			csesoutcol3 := VL_ELIGIBILITY_REDET_DATE  ;
		ELSIF  VS_TRANSACTION_TYPE_CD  <> '15' THEN  -- #12329
			csesoutcol3 := CAST(date_part('year',current_timestamp):: varchar ||lpad(date_part('month',current_timestamp):: varchar,2,'0')||lpad(date_part('day',current_timestamp)::varchar,2,'0') AS INT);
		END IF;
		
		BEGIN
			select cjams.f_prim_county(VL_PLACEMENT_CASE_ID::bigint,'NULL') 
				into V_PRIMARY_COUNTY_CD ;
			/* old code	
			SELECT f_prim_county_interface(VL_PLACEMENT_CASE_ID::varchar)
				INTO V_PRIMARY_COUNTY_CD;
			*/	

	      	         	
			VS_PRIMARY_COUNTY_CD := CASE WHEN  V_PRIMARY_COUNTY_CD = '1427' THEN '01' -- Allegany
	                                      WHEN V_PRIMARY_COUNTY_CD = '1428' THEN '02' -- Anne Arundel
	                                      WHEN V_PRIMARY_COUNTY_CD = '1430' THEN '03' -- Baltimore County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1431' THEN '04' -- Calvert County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1432' THEN '05' -- Caroline County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1433' THEN '06' -- Carroll County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1434' THEN '07' -- Cecil County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1435' THEN '08' -- Charles County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1436' THEN '09' -- Dorchester County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1437' THEN '10' -- Frederick County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1438' THEN '11' -- Garrett County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1439' THEN '12' -- Harford County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1440' THEN '13' -- Howard County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1441' THEN '14' -- Kent County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1442' THEN '15' -- Montgomery County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1443' THEN '16' -- Prince Georges County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1444' THEN '17' -- Queen Annes County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1446' THEN '18' -- St. Marys County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1445' THEN '19' -- Somerset County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1447' THEN '20' -- Talbot County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1448' THEN '21' -- Washington County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1449' THEN '22' -- Wicomico County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1450' THEN '23' -- Worcester County
	                                      WHEN V_PRIMARY_COUNTY_CD = '1429' THEN '30' -- Baltimore City
	                                      WHEN V_PRIMARY_COUNTY_CD = '3824' THEN '00' -- DHR/SSA
	                                   END  ;
	
			service_case_id = (	SELECT servicecaseid 
									from servicecase where servicecasenumber = VL_PLACEMENT_CASE_ID::varchar);
            
			-- Get Primary Casewroker
			select ca.toworkeridno
				into sec_id
				from caseassignment ca,
					userprofile up 
			where ca.toworkeridno = up.securityusersid
				and ca.objectid = service_case_id
				and lower(ca.responsibilitytypekey) = 'family'
				and ca.activeflag = 1
				and up.activeflag = 1
				and ca.enddate is null
			order by ca.insertedon desc
			limit 1 ;
			
			/* -- old code
			SELECT routing.tosecurityusersid into sec_id
				FROM routing 
            WHERE ((routing.objectid = service_case_id::varchar) ) and 
				routing.activeflag=1 and routing.eventcode= 'SRVC';
			*/
			
			IF sec_id is null THEN
				-- Get Child Casewroker
				select ca.toworkeridno
					into sec_id
					from caseassignment ca,
						userprofile up 
				where ca.toworkeridno = up.securityusersid
					and ca.objectid = service_case_id
					and ca.old_id::bigint = VL_CLIENT_ID
					and lower(ca.responsibilitytypekey) = 'child'
					and ca.activeflag = 1
					and up.activeflag = 1
					and ca.enddate is null
				order by ca.insertedon desc
				limit 1 ;
			END IF;
			
			IF sec_id is null THEN
				-- Get LDSS Director
				select up.securityusersid
					into sec_id
					from team t
						join teammember tm on tm.teamid = t.teamid and tm.activeflag = 1
						join teammemberassignment tma on tma.teammemberid = tm.teammemberid and tma.activeflag = 1
						join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag = 1
						join rolemapping rm on rm.principalid::int = mu.id and rm.activeflag = 1
						join county c on c.countyid::character varying = t.countyid
						join userresource ur on ur.userid = mu.id and ur.activeflag = 1
						join role r on r.id = rm.roleid::int and r.activeflag = 1
						join userprofile up on up.securityusersid = mu.securityusersid and up.activeflag = 1
					where ur.permissiongroupid = '57a390b8-3387-428a-97a8-0b8559fd1f1e'    
					 and lower(tm.description) like '%director%'
					 and btrim(c.statecountycode) = btrim(V_PRIMARY_COUNTY_CD)
				order by (case when tm.description = 'LDSS Director' then 1 else 2 end) 
				limit 1;
			END IF;
			
			--#GET Staff Telephone Number & Name
			SELECT right( regexp_replace (upn.phonenumber::varchar, '[- )]+','','g')::varchar, 10) as phonenumber, -- CIDM-4512
				-- right( regexp_replace (upn.phonenumber::varchar, '[- ]+','','g')::varchar, 10) as phonenumber,
				substring(COALESCE(up.firstname || ' ','') || COALESCE(up.lastname,''), 1, 50)
			INTO VS_WORKER_PHONE,
				VS_WORKER_NAME
			FROM userprofile up 
				left outer join userprofilephonenumber upn on upn.securityusersid = up.securityusersid
					and upn.activeflag = 1
			WHERE up.securityusersid = sec_id::character varying
				and up.activeflag = 1
			ORDER BY upn.insertedon desc
			limit 1 ;
			
			IF length(VS_WORKER_PHONE) = 10 THEN
				-- Valid Value
			ELSE
				VS_WORKER_PHONE:= '0000000000';
			END IF;
			
			/* -- old code
			SELECT  upn.phonenumber,
					COALESCE(up.firstname || ' ','') || COALESCE(up.lastname,'')
			INTO	VS_WORKER_PHONE,
					VS_WORKER_NAME
			FROM 	userprofile up, 
					userprofilephonenumber upn, 
					securityusers scu, 
					userprofileaddress upa
	        WHERE 	up.securityusersid = upn.securityusersid
					and scu.securityusersid = up.securityusersid
					and upa.securityusersid = up.securityusersid
					and upa.securityusersid = sec_id::character varying
					AND up.activeflag = 1
					and upa.activeflag = 1
					and scu.activeflag = 1
					AND upn.activeflag = 1
            ORDER BY upa.county ASC 
			LIMIT 1 ;
			*/
		end;     
  
		BEGIN
			SELECT  person.cisclientid,
				COALESCE(substring(person.lastname,1 ,20),''),
				COALESCE(substring(person.firstname, 1, 20),''),
				COALESCE(substring(btrim(person.middlename), 1, 10),''),
				-- CIDM-2204
				substring((select value_text 
					from cjams.referencevalues rf  
				where rf.referencetypeid = 302
					and rf.activeflag = 1 
					and rf.value_text not in ('Ret.')
					and rf.ref_key = person.suffix ),1,5
				) as suffix,
				-- SUBSTRING(F_PLVALUE(person.suffix,214),1,5),
				TO_CHAR(person.dob,'yyyymmdd')::INTEGER,
				( CASE WHEN person.gendertypekey = '1281' THEN 'F'	-- IF DATA COMES AS CHESSIE CODES
					WHEN person.gendertypekey = 'F' THEN 'F'
					WHEN person.gendertypekey = '1282' THEN 'M' -- IF DATA COMES AS CHESSIE CODES
					WHEN person.gendertypekey = 'M' THEN 'M'
					ELSE 'U' 
				END) as gendertypekey, 
				( CASE WHEN person.racetypekey LIKE '%WH%' THEN '1806'
					WHEN  person.racetypekey LIKE '%AI%' THEN '1803'
					WHEN  person.racetypekey LIKE '%AN%' THEN '1802'
					WHEN  person.racetypekey LIKE '%BA%' THEN '1801'
					WHEN  person.racetypekey LIKE '%AS%' THEN '6310'
					WHEN  person.racetypekey LIKE '%PI%' THEN '6311'
					ELSE '6312'
				END ) as racetypekey
			INTO VS_CIS_CLIENT_ID,
				VS_CLIENT_SURNAME,
				VS_CLIENT_GIVENNAME,
				VS_CLIENT_MIDDLENAME,
				VS_CLIENT_SUFFIX,
				VL_DOB_DT,
				VS_CLIENT_GENDER,
				VS_CLIENT_RACE
			FROM person
			WHERE person.cjamspid =  VL_CLIENT_ID
				AND person.activeflag = 1;
	

			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR PERSON ' || SQLERRM ;
				RETURN;
	    END ;
		--Gayathri Rajkumar - Mapped Declined race to Unknown. --04.14.2010
		IF LTRIM(RTRIM(VS_CLIENT_RACE)) = '6314' THEN
			VS_CLIENT_RACE := '6312';
		END IF;
			
		begin -- June17		
			SELECT ( CASE WHEN (personidentifiervalue ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$') = false then 
						NULL 
					 ELSE 
						personidentifiervalue::varchar 
					END )
					-- personidentifiervalue :: varchar 
				INTO VL_SSN_NO
			FROM person, personidentifier
			WHERE  person.personid = personidentifier.personid
				and personidentifier.personidentifiertypekey = 'SSN'
				AND person.cjamspid =  VL_CLIENT_ID
				AND person.activeflag = 1
				AND personidentifier.activeflag = 1;
	
	    
            EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR PERSON ' || SQLERRM ;
				RETURN;
		END ;
	       
		BEGIN
			/*   SELECT  CAST(SUBSTRING(TO_CHAR(PH.PAYMENT_DT),7,4)||SUBSTRING(TO_CHAR(PH.PAYMENT_DT),1,2)||SUBSTRING(TO_CHAR(PH.PAYMENT_DT),4,2) AS INT),
				SUM(TO_DECIMAL(PD.FINAL_AMOUNT_NO,10,2))
			INTO csesoutcol15,
				 CSES_OUT_COL16
				FROM TB_PAYMENT_HEADER PH, TB_PAYMENT_DETAIL PD
				WHERE PD.actorid = VL_CLIENT_ID
				AND PD.paymentid = PH.paymentid
				AND PH.paymenttypekey = '6'
				AND PH.paymentdate IS NOT NULL
				AND PH.activeflag = 1
				AND PD.activeflag = 1
				AND PD.paymentid = (SELECT MAX(A.paymentid)
					FROM paymentdetail A, paymentheader B
					WHERE A.CLIENT_ID = VL_CLIENT_ID
					AND A.paymentid = B.paymentid
					AND B.paymenttypekey = '6'
					AND B.paymentdate IS NOT NULL
					AND A.activeflag = 1
					AND B.activeflag = 1)
				GROUP BY PH.paymentdate;-- */
			
			SELECT 
				TO_CHAR(PH.PAYMENT_DT,'yyyymmdd')::INTEGER,
				NULL -- SUM(TO_DECIMAL(PD.FINAL_AMOUNT_NO,10,2))
			INTO csesoutcol15,
				csesoutcol16
			FROM TB_PAYMENT_HEADER PH, TB_PAYMENT_DETAIL PD
			WHERE   PD.CLIENT_ID = VL_CLIENT_ID
				AND PD.PAYMENT_ID = PH.PAYMENT_ID
				AND PH.PAYMENT_TYPE_CD = '6'
				AND PH.PAYMENT_DT IS NOT NULL
				AND PH.DELETE_SW = 'N'
				AND PD.DELETE_SW = 'N'
				AND PD.PAYMENT_ID = (SELECT MAX(A.PAYMENT_ID)
					FROM TB_PAYMENT_DETAIL A, TB_PAYMENT_HEADER B
					WHERE   A.CLIENT_ID = VL_CLIENT_ID
					 AND A.PAYMENT_ID = B.PAYMENT_ID
					AND B.PAYMENT_TYPE_CD = '6'
					AND B.PAYMENT_DT IS NOT NULL
					AND A.DELETE_SW = 'N'
					AND B.DELETE_SW = 'N')
				GROUP BY PH.PAYMENT_DT;

             
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR paymentdetail'  || SQLERRM ;
				RETURN;
	    END ;
	
		csesoutcol16_CONVERT := LTRIM(RTRIM(CAST(csesoutcol16 AS VARCHAR))) ;                            	
		csesoutcol16_CONVERT := SUBSTRING('00000000000',1,11 - LENGTH(csesoutcol16_CONVERT)) || csesoutcol16_CONVERT ;	
		
		BEGIN
		
			SELECT * INTO csesoutcol17 FROM
				(SELECT CAST(date_part('year',petitionfileddate):: varchar ||lpad(date_part('month',petitionfileddate):: varchar,2,'0')||lpad(date_part('day',petitionfileddate)::varchar,2,'0') AS INT)
					FROM intakeservicerequestpetition
			WHERE petitiontypekey = '5952'
				--  AND petitionfocusname = VL_CLIENT_ID
				AND activeflag = 1
			ORDER BY petitionfileddate DESC,intakeservicerequestpetitionid DESC) as A
			FETCH FIRST 1 ROWS ONLY ;
	
	
            
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR TB_COURT_PETITIONS' || SQLERRM ;
				RETURN;
	    END ;
	
		BEGIN
			-- Set Interface Data
			INSERT INTO csesoutboundinterface
				(csesoutboundinterfaceid,
				statustypekey,
				batchseqno,
				transactionseqno,
				transactiontypekey,
				cisclientid,
				recordtypekey,
				transactionon,
				recordseqno,
				csesoutcol1,
				csesoutcol2,
				csesoutcol3,
				csesoutcol4,
				csesoutcol5,
				csesoutcol6,
				csesoutcol7,
				csesoutcol8,
				csesoutcol9,
				csesoutcol10,
				csesoutcol11,
				csesoutcol12,
				csesoutcol13,
				csesoutcol14,
				csesoutcol15,
				csesoutcol16,
				csesoutcol17)
		SELECT
			NEXTVAL ('SQ_CSES_OUTBOUND_INTERFACE'),
			'000',
			'',
			CASE WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 1 THEN '0000'||VS_TRANSACTION_SEQUENCE
			WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 2 THEN '000'||VS_TRANSACTION_SEQUENCE
			WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 3 THEN '00'||VS_TRANSACTION_SEQUENCE
			WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 4 THEN '0'||VS_TRANSACTION_SEQUENCE
			WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 5 THEN VS_TRANSACTION_SEQUENCE
			END,
			VS_TRANSACTION_TYPE_CD,
			COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)),'000000000') ,
			'01',
			VD_TRANSACTION_TS,
			'001',
			csesoutcol1,
			csesoutcol2,
			COALESCE(CAST(csesoutcol3 AS VARCHAR),'00000000'),
			VS_PRIMARY_COUNTY_CD,
			VS_WORKER_NAME,
			COALESCE(VS_WORKER_PHONE,'0000000000'),
			-- COALESCE(right( regexp_replace (VS_WORKER_PHONE::varchar, '[- ]+','','g')::varchar, 10),'0000000000'),
			VS_CLIENT_SURNAME,
			VS_CLIENT_GIVENNAME,
			VS_CLIENT_MIDDLENAME,
			VS_CLIENT_SUFFIX,
			COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(cast(VL_SSN_NO  as varchar))))) || LTRIM(RTRIM(cast(VL_SSN_NO  as varchar))),'000000000'),
			COALESCE(cast(VL_DOB_DT as varchar),'00000000'),
			VS_CLIENT_GENDER,
			VS_CLIENT_RACE,
			COALESCE(cast(csesoutcol15 as varchar),'00000000'),
			CASE WHEN csesoutcol16_CONVERT = '' THEN '00000000.00'
			WHEN LENGTH(csesoutcol16_CONVERT) <= 0 THEN '00000000.00'
			ELSE COALESCE(cast(csesoutcol16_CONVERT as varchar),'00000000.00')
			END,
			COALESCE(cast(csesoutcol17 as varchar),'00000000');
	  

			EXCEPTION WHEN OTHERS  THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'INSERT 01 INTO TB_CSES_OUTBOUND_INTERFACE FAILED ' || SQLERRM ;
				RETURN;
		END ;
	
    END IF;

	-- VL_OUTPUT_SQLCODE  := '00000' ;
	-- RAISE NOTICE 'INSERTED DATA_01';
	VS_MESSAGE := 'Procedure ran succesfully';
	RETURN;

END;

$function$
;
