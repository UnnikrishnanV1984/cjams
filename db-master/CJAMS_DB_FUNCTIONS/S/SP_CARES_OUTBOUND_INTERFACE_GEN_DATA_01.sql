CREATE OR REPLACE FUNCTION cjams.sp_cares_outbound_interface_gen_data_01(vl_client_id integer, vl_other_id bigint, vs_transaction_type_cd character varying, vl_transaction_sequence integer, vd_transaction_ts timestamp without time zone, OUT vs_message character varying, OUT vl_output_sqlcode character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Sudhin
-- Date Created :08/25/2005
-- generates Cares Interface Outbound Data

-- Revision(s)
-- 5/31/06 - Tanya Lee - Incident #7739 -- Updated eligibility fields to look at FC and Adoption
-- 02/09/2007 - Sandhya -- #12329    - Added condition for transaction type = '15' (Subsidy Guardianship)
-- 02/16/07 - sandhya - #12329 - Added condition before disability for no records found.
-- #12329 02/19/07 - sandhya - default dates to null for subsidy guardianship
-- #7739 04/18/07  -- sandhya - To pick Transaction date when eligibility status has been end dated.
-- 04.10.08 -#17248 sandhya-  Check for telephone nos having spaces and store zeros in place.
-- 04.14.2010 --GAYATHRI RAJUKMAR - MAPPED DECLINED RACE TO UNKNOWN
-- 26.06.2019 --- Ram Kumar changes are commented with tag #26062019
-- 06/10/2020 Vineet Tirodkar - To fix the get Caseworker & get Case county logic.
-- 06/24/2020 Vineet Tirodkar - To modify logic to send Gender as 'U' for all other types than Male & Female 
-- 06/30/2020 Vineet Tirodkar - Modifications to send 'Unknown' for racetypekey 'Other' ro any not known code to MD CHESSIE 
-- 07/06/2020 Vineet Tirodkar - To report Person's Insurance info use personhealthinsurance table (Instead of personinsurance)
-- 08/20/2020 Vineet Tirodkar - Modifications to send only Valid (Numeric) SSN attribute values (CDM-3270)
-- 09/25/2020 Vineet Tirodkar - Changes to trim and compare Eligibility Status Code (CDM-4684)
-- 10/05/2020 Vineet Tirodkar - Changes to send first 50 characters only for Person’s educationname (CIDM-1010)
-- 03/08/2021 Vineet Tirodkar - Modifications for person name suffix logic fix (CIDM-2203)
-- 03/11/2021 Vineet Tirodkar - Modifications to get the personaddress using personid (uuid) (CIDM-2203)
-- 08/03/2021 Vineet Tirodkar - Modifications to send Client Person First/Last Names first 20 characters only 
--								and Middle Name first 10 characters (CDM-15668)
-- 11/02/2021 Vineet Tirodkar - Modifications to send numeric values for telephone numbers (CIDM-4020)
------------------------------------------------------------------------

DECLARE VS_RECORD_TYPE VARCHAR(2);
VS_OUTPUT_STATE VARCHAR(5) DEFAULT '00000';
VL_RECORD_SEQUENCE INTEGER DEFAULT 000;
VS_TRANSACTION_SEQUENCE VARCHAR(5);
VS_RECORD_SEQUENCE VARCHAR(3);
  -- Client Variables
VL_STAFF_ID VARCHAR;
VL_TRANSACTION_DATE INTEGER;   -- CARES_OUT_COL1
VS_PLACEMENT_STRUCTURE_ID CHAR(1); -- CARES_OUT_COL2
VS_PRIMARY_COUNTY_CD CHAR(2);   -- CARES_OUT_COL3
VS_WORKER_NAME VARCHAR(50);     -- CARES_OUT_COL4
VS_WORKER_PHONE VARCHAR(32);        -- CARES_OUT_COL5
VS_CIS_CLIENT_ID VARCHAR(10);      --  CARES_OUT_COL6
VS_CLIENT_SURNAME VARCHAR(20);  --  CARES_OUT_COL7
VS_CLIENT_GIVENNAME VARCHAR(20); -- CARES_OUT_COL8
VS_CLIENT_MIDDLENAME VARCHAR(10); -- CARES_OUT_COL9
VS_CLIENT_SUFFIX VARCHAR(5);     -- CARES_OUT_COL10  
VS_AKA_LAST_NM VARCHAR(20);       -- CARES_OUT_COL11
VL_SSN_NO VARCHAR;                 -- CARES_OUT_COL12
VL_DOB_DT INTEGER;                  -- CARES_OUT_COL13
VS_CLIENT_GENDER CHAR(1);           -- CARES_OUT_COL14 
VS_CLIENT_RACE VARCHAR(20);          -- CARES_OUT_COL15 -- length increased #26062019
VL_PLACEMENT_START_DATE INTEGER;   -- CARES_OUT_COL16
VL_PLACEMENT_END_DATE INTEGER;     -- CARES_OUT_COL17
VS_PLACEMENT_NAME VARCHAR(100);     -- CARES_OUT_COL18
VS_LONG_TERM_CF_INDICATOR CHAR(1);    -- CARES_OUT_COL19
VL_LTCF_ADMISSION_DATE INTEGER;       -- CARES_OUT_COL20
VL_LTCF_DISCHARGE_DATE INTEGER;       -- CARES_OUT_COL21
VL_PROVIDER_ID INTEGER;
VL_PLACEMENT_CASE_ID BIGINT;
VS_CLIENT_BIRTH_HOSPITAL VARCHAR(50);  -- CARES_OUT_COL22
VS_CLIENT_BIRTH_CITY VARCHAR(50);      -- CARES_OUT_COL23
VS_CLIENT_BIRTH_STATE CHAR(2);         -- CARES_OUT_COL24
VS_CLIENT_MARITAL_STATUS VARCHAR(5);    -- CARES_OUT_COL25
VS_CLIENT_RESIDENCY_STATUS CHAR(1);    -- CARES_OUT_COL26
VS_CLIENT_DISABLED CHAR(1) default 'N';             -- CARES_OUT_COL27
VS_CLIENT_PHYSICAL_DISABILITY CHAR(2);   -- CARES_OUT_COL28
VS_CLIENT_MENTAL_DISABILITY CHAR(2);      -- CARES_OUT_COL29
VS_CLIENT_VISUAL_DISABILITY CHAR(2);       -- CARES_OUT_COL30
VS_CLIENT_HEARING_DISABILITY CHAR(2);     -- CARES_OUT_COL31
VS_CLIENT_MENTAL_RETARDATION CHAR(2);      -- CARES_OUT_COL32
VS_CLIENT_LEARNING_DISABILITY CHAR(2);      -- CARES_OUT_COL33
VS_CLIENT_COGNITIVE_DISABILITY CHAR(2);  -- CARES_OUT_COL34
VS_CLIENT_DEV_DELAY_DISABILITY CHAR(2);   -- CARES_OUT_COL35
VS_CLIENT_OTHER_DISABILITY CHAR(2);       -- CARES_OUT_COL36
VS_CLIENT_MEDICAL_INSURANCE CHAR(1);      -- CARES_OUT_COL37
CARES_OUT_COL38 CHAR(1);
CARES_OUT_COL39 INTEGER;
CARES_OUT_COL40 INTEGER;
CARES_OUT_COL41 INTEGER;
CARES_OUT_COL42 DECIMAL(10,2);
CARES_OUT_COL42_CONVERT VARCHAR(15);
CARES_OUT_COL43 VARCHAR(50);
VL_PRIMARY_CAREGIVER_ID INTEGER;
CARES_OUT_COL44 CHAR(3);
CARES_OUT_COL45 VARCHAR(9); -- INTEGER
CARES_OUT_COL46 VARCHAR(50);
CARES_OUT_COL47 CHAR(5);
CARES_OUT_COL48 CHAR(3);
CARES_OUT_COL49 CHAR(5);
CARES_OUT_COL50 VARCHAR(50);
CARES_OUT_COL51 CHAR(2);
CARES_OUT_COL52 INTEGER;
CARES_OUT_COL53 CHAR(3);
CARES_OUT_COL54 VARCHAR(9); -- INTEGER
CARES_OUT_COL55 VARCHAR(50);
CARES_OUT_COL56 CHAR(5);
CARES_OUT_COL57 CHAR(3);
CARES_OUT_COL58 CHAR(5);
CARES_OUT_COL59 VARCHAR(50);
CARES_OUT_COL60 CHAR(2);
CARES_OUT_COL61 INTEGER;
CARES_OUT_COL62 VARCHAR(32);
CARES_OUT_COL63 VARCHAR(100);
CARES_OUT_COL64 CHAR(3);
CARES_OUT_COL65 VARCHAR(9); -- INTEGER
CARES_OUT_COL66 VARCHAR(50);
CARES_OUT_COL67 CHAR(5);
CARES_OUT_COL68 CHAR(3);
CARES_OUT_COL69 CHAR(5);
CARES_OUT_COL70 VARCHAR(50);
CARES_OUT_COL71 CHAR(2);
CARES_OUT_COL72 INTEGER;
CARES_OUT_COL73 VARCHAR(10);
VL_ADOPTIVE_FATHER_ID INTEGER;
VL_ADOPTIVE_MOTHER_ID INTEGER;
CARES_OUT_COL74 VARCHAR(20);
CARES_OUT_COL75 VARCHAR(20);
CARES_OUT_COL76 VARCHAR(10);
CARES_OUT_COL77 CHAR(5);
CARES_OUT_COL78 CHAR(3);
CARES_OUT_COL79 VARCHAR(9); -- INTEGER
CARES_OUT_COL80 VARCHAR(50);
CARES_OUT_COL81 CHAR(5);
CARES_OUT_COL82 CHAR(3);
CARES_OUT_COL83 CHAR(5);
CARES_OUT_COL84 VARCHAR(50);
CARES_OUT_COL85 CHAR(2);
CARES_OUT_COL86 INTEGER;
CARES_OUT_COL87 VARCHAR(10);
CARES_OUT_COL88 CHAR(1);
CARES_OUT_COL89 CHAR(1);
CARES_OUT_COL90 CHAR(5);
CARES_OUT_COL91 CHAR(5);
CARES_OUT_COL92 VARCHAR(20);
CARES_OUT_COL93 VARCHAR(20);
CARES_OUT_COL94 CHAR(1);
CARES_OUT_COL95 CHAR(5);
CARES_OUT_COL96 CHAR(5);
CARES_OUT_COL97 VARCHAR;
CARES_OUT_COL98 VARCHAR(50);
CARES_OUT_COL99 CHAR(3);
CARES_OUT_COL100 VARCHAR(9); -- INTEGER
CARES_OUT_COL101 VARCHAR(50);
CARES_OUT_COL102 CHAR(5);
CARES_OUT_COL103 CHAR(3);
CARES_OUT_COL104 CHAR(5);
CARES_OUT_COL105 VARCHAR(50);
CARES_OUT_COL106 CHAR(2);
CARES_OUT_COL107 INTEGER;
service_case_id uuid;
sec_id uuid;

-- New Variables for Provider Payment Address
VS_PAY_TO_AFFILIATE_CD VARCHAR(5);
VS_ALTERNATE_ADR_TYPE_CD VARCHAR(5);
VS_PAY_TO_AFFILIATE_CD_1 VARCHAR(5);
VL_AFFILIATE_PROVIDER_ID INTEGER DEFAULT 0;
VL_TEMP_PROVIDER_ID INTEGER DEFAULT 0;
LS_temp_PROVIDER_NM varchar(100);
LS_temp_PROV_FIRST_NM varchar(100);
LS_temp_PROV_MIDDLE_NM varchar (100);
LS_temp_PROV_LAST_NM varchar (100);
LS_temp_PROV_SUFFIX varchar (100);
V_PRIMARY_COUNTY_CD VARCHAR(4);

BEGIN    
	VL_OUTPUT_SQLCODE:='00000';  

	--   RAISE NOTICE 'GEN DATA 01 STARTS';


	-- SET transaction sequence
	VS_TRANSACTION_SEQUENCE := LTRIM(RTRIM(CAST(VL_TRANSACTION_SEQUENCE AS VARCHAR))) ;

	-- Get CIS_CLIENT_ID
	BEGIN
		SELECT  person.cisclientid
			INTO    VS_CIS_CLIENT_ID
		FROM    person  	
		WHERE   person.cjamspid = VL_CLIENT_ID
		AND     person.activeflag  = 1;  
		
		EXCEPTION WHEN OTHERS THEN 
		VL_OUTPUT_SQLCODE  :=  SQLSTATE;
		VS_MESSAGE :=  'SELECT CIS_CLIENT_ID FAILED FOR TB_CLIENT'  ;
		RETURN;
    END ;
   
	-- Generate records for record type 01
    VS_RECORD_TYPE := '01';
	IF 	VS_RECORD_TYPE = '01' THEN
		VL_RECORD_SEQUENCE := VL_RECORD_SEQUENCE + 1 ;
		IF VS_TRANSACTION_TYPE_CD = '15' THEN -- #12329

			BEGIN   
			
				SELECT 	*
				INTO    VS_PLACEMENT_STRUCTURE_ID,
						VL_PLACEMENT_START_DATE,
						VL_PLACEMENT_END_DATE,
						VS_PLACEMENT_NAME,
						VS_LONG_TERM_CF_INDICATOR,
						--   VL_LTCF_ADMISSION_DATE,VL_LTCF_DISCHARGE_DATE,
						VL_PROVIDER_ID,
						VL_PLACEMENT_CASE_ID
				FROM
					(SELECT  	'S',
								to_char(TBS.SUBSIDY_START_DT,'yyyymmdd')::integer,
								to_char(TBS.SUBSIDY_END_DT,'yyyymmdd')::integer,      
								(SELECT
									CASE   WHEN LENGTH(RTRIM(PROVIDER_NM)) > 0 THEN PROVIDER_NM
										ELSE
										COALESCE(PROVIDER_FIRST_NM || ' ','')  ||
										COALESCE(PROVIDER_MIDDLE_NM || ' ','') ||
										COALESCE(PROVIDER_LAST_NM,'')
									END
								FROM TB_PROVIDER
								WHERE PROVIDER_ID = TB_GUARDIAN_SUBSIDY.PROVIDER_ID AND DELETE_SW = 'N'),
								'',
								TB_GUARDIAN_SUBSIDY.PROVIDER_ID,
								TB_GUARDIAN_SUBSIDY.CASE_ID
				   /*  FROM    	TB_GUARDIAN_SUBSIDY
					WHERE   	CLIENT_ID = VL_CLIENT_ID	AND     
								SUBSIDY_START_DT IS NOT NULL	AND     
								SUBSIDY_END_DT IS NOT NULL	AND     
								--CHECK_LIST_APPROVAL_STATUS_CD = '3047'	 AND    -- coulumn doesnt exist in dev db  
								SUSBSIDY_APPROVAL_STATUS_CD = '3047'	AND     
								DELETE_SW = 'N'
					ORDER BY SUBSIDY_START_DT DESC, GUARDIAN_SUBSIDY_ID DESC ) AS A
					LIMIT 1 ;-- */	
				FROM    TB_GUARDIAN_SUBSIDY TBS , TB_GUARDIAN_SUBSIDY_DELETE TGSD
				WHERE   TBS.CLIENT_ID = VL_CLIENT_ID
						and     TGSD.case_id = TBS.case_id
						AND     TBS.SUBSIDY_START_DT IS NOT NULL
						AND     TBS.SUBSIDY_END_DT IS NOT NULL
						AND     TGSD.CHECK_LIST_APPROVAL_STATUS_CD = '3047'
						AND     TBS.SUSBSIDY_APPROVAL_STATUS_CD = '3047'
						AND     TBS.DELETE_SW = 'N'
				ORDER BY TBS.SUBSIDY_START_DT DESC, TBS.GUARDIAN_SUBSIDY_ID DESC ) AS A 
				LIMIT 1; 
							
				EXCEPTION WHEN OTHERS THEN

				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR GUARDIAN SUBSIDY '||SQLERRM  ;
				RETURN ;
			END;
			
			VL_LTCF_ADMISSION_DATE := NULL; -- #12329 02/19/07
			VL_LTCF_DISCHARGE_DATE := NULL; -- #12329 02/19/07

		ELSIF VS_TRANSACTION_TYPE_CD <> '70' AND VS_TRANSACTION_TYPE_CD <>'15' THEN -- #12329 
			BEGIN
				SELECT 	*
				INTO    VS_PLACEMENT_STRUCTURE_ID,
						VL_PLACEMENT_START_DATE,
						VL_PLACEMENT_END_DATE,
						VS_PLACEMENT_NAME,
						VS_LONG_TERM_CF_INDICATOR,
						VL_LTCF_ADMISSION_DATE,
						VL_LTCF_DISCHARGE_DATE,
						VL_PROVIDER_ID,
						VL_PLACEMENT_CASE_ID
				FROM
					(SELECT  
						CASE	WHEN PLACEMENT_STRUCTURE_ID = 501 THEN 'A'
								WHEN PLACEMENT_STRUCTURE_ID = 8 THEN 'K'
							ELSE 'F'
						END,
						to_char(ENTRY_DT,'yyyymmdd')::integer,
						to_char(EXIT_DT,'yyyymmdd')::integer,
						(SELECT
								CASE   WHEN LENGTH(RTRIM(PROVIDER_NM)) > 0 THEN PROVIDER_NM
								ELSE
									COALESCE(PROVIDER_FIRST_NM || ' ','')  ||
									COALESCE(PROVIDER_MIDDLE_NM || ' ','') ||
									COALESCE(PROVIDER_LAST_NM,'')
								END
						FROM 	TB_PROVIDER
						WHERE 	PROVIDER_ID = TB_PLACEMENT.PROVIDER_ID AND DELETE_SW = 'N'),
						CASE WHEN PLACEMENT_STRUCTURE_ID = 76 THEN 'Y'
							ELSE 'N'
						END,
						CASE 	WHEN PLACEMENT_STRUCTURE_ID = 76
								THEN to_char(ENTRY_DT,'yyyymmdd')::integer
						END,
						CASE	WHEN PLACEMENT_STRUCTURE_ID = 76
								THEN to_char(EXIT_DT,'yyyymmdd')::integer
						END,
						TB_PLACEMENT.PROVIDER_ID,
						TB_PLACEMENT.CASE_ID
					FROM    TB_PLACEMENT
					WHERE   CLIENT_ID = VL_CLIENT_ID
							AND     EXIT_DT IS NULL
							AND     ENTRY_DT IS NOT NULL
							AND     PLACEMENT_STRUCTURE_ID IS NOT NULL
							AND     APPROVAL_STATUS_CD = '3047'
							AND     DELETE_SW = 'N'
					ORDER BY ENTRY_DT DESC, PLACEMENT_ID DESC) AS A
					LIMIT 1 ;
	  

				EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR TB_PLACEMENT '||SQLERRM  ;
				RETURN ;
			END;
		END IF;	
		
		IF VS_TRANSACTION_TYPE_CD = '70' THEN
			BEGIN	
				SELECT *
				INTO    VS_PLACEMENT_STRUCTURE_ID,
						VL_PLACEMENT_START_DATE,
						VL_PLACEMENT_END_DATE,
						VS_PLACEMENT_NAME,
						VS_LONG_TERM_CF_INDICATOR,
						VL_LTCF_ADMISSION_DATE,
						VL_LTCF_DISCHARGE_DATE,
						VL_PROVIDER_ID,
						VL_PLACEMENT_CASE_ID
				FROM
				(SELECT  CASE    WHEN PLACEMENT_STRUCTURE_ID = 501 THEN 'A'
						WHEN PLACEMENT_STRUCTURE_ID = 8 THEN 'K'
						ELSE 'F'
						END,
						to_char(ENTRY_DT,'yyyymmdd')::integer,
						to_char(EXIT_DT,'yyyymmdd')::integer,
				   
				(SELECT
				CASE   WHEN LENGTH(RTRIM(PROVIDER_NM)) > 0 THEN PROVIDER_NM
				ELSE
						COALESCE(PROVIDER_FIRST_NM || ' ','')  ||
						COALESCE(PROVIDER_MIDDLE_NM || ' ','') ||
						COALESCE(PROVIDER_LAST_NM,'')
				END
				FROM TB_PROVIDER
				WHERE PROVIDER_ID = TB_PLACEMENT.PROVIDER_ID AND DELETE_SW = 'N'),
				CASE WHEN PLACEMENT_STRUCTURE_ID = 76 THEN 'Y'
								ELSE 'N'
						END,
						CASE WHEN PLACEMENT_STRUCTURE_ID = 76
								THEN to_char(ENTRY_DT,'yyyymmdd')::integer
								
						END,
						CASE WHEN PLACEMENT_STRUCTURE_ID = 76 THEN 
						to_char(EXIT_DT,'yyyymmdd')::integer
								
						END,
						TB_PLACEMENT.PROVIDER_ID,
						TB_PLACEMENT.CASE_ID
				FROM    TB_PLACEMENT
				WHERE   CLIENT_ID = VL_CLIENT_ID
				AND     EXIT_DT IS NOT NULL
				AND     ENTRY_DT IS NOT NULL
				AND     PLACEMENT_STRUCTURE_ID IS NOT NULL
				AND     DELETE_SW = 'N'
				ORDER BY ENTRY_DT DESC , PLACEMENT_ID DESC) AS A
				LIMIT 1 ;

				EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR TB_PLACEMENT '||SQLERRM  ;
				RETURN ;
			END;
			
		END IF;

		--SET VL_TRANSACTION_DATE = INTEGER(SUBSTRING(CHAR(DATE(VD_TRANSACTION_TS)),7,4)||SUBSTRING(CHAR(DATE(VD_TRANSACTION_TS)),1,2)||SUBSTRING(CHAR(DATE(VD_TRANSACTION_TS)),4,2));
		BEGIN
			select cjams.f_prim_county(VL_PLACEMENT_CASE_ID,'NULL') 
				into V_PRIMARY_COUNTY_CD ;
			/* -- old code	
			SELECT f_prim_county_interface(VL_PLACEMENT_CASE_ID::varchar)
				INTO V_PRIMARY_COUNTY_CD;
			*/
							
			VS_PRIMARY_COUNTY_CD := CASE WHEN  V_PRIMARY_COUNTY_CD = '1427' THEN '01' -- Allegany
									  WHEN V_PRIMARY_COUNTY_CD = '1428' THEN '02'     -- Anne Arundel
									  WHEN V_PRIMARY_COUNTY_CD = '1430' THEN '03'     -- Baltimore County
									  WHEN V_PRIMARY_COUNTY_CD = '1431' THEN '04'     -- Calvert County
									  WHEN V_PRIMARY_COUNTY_CD = '1432' THEN '05'     -- Caroline County
									  WHEN V_PRIMARY_COUNTY_CD = '1433' THEN '06'     -- Carroll County
									  WHEN V_PRIMARY_COUNTY_CD = '1434' THEN '07'     -- Cecil County
									  WHEN V_PRIMARY_COUNTY_CD = '1435' THEN '08'     -- Charles County
									  WHEN V_PRIMARY_COUNTY_CD = '1436' THEN '09'     -- Dorchester County
									  WHEN V_PRIMARY_COUNTY_CD = '1437' THEN '10'     -- Frederick County
									  WHEN V_PRIMARY_COUNTY_CD = '1438' THEN '11'     -- Garrett County
									  WHEN V_PRIMARY_COUNTY_CD = '1439' THEN '12'     -- Harford County
									  WHEN V_PRIMARY_COUNTY_CD = '1440' THEN '13'     -- Howard County
									  WHEN V_PRIMARY_COUNTY_CD = '1441' THEN '14'     -- Kent County
									  WHEN V_PRIMARY_COUNTY_CD = '1442' THEN '15'     -- Montgomery County
									  WHEN V_PRIMARY_COUNTY_CD = '1443' THEN '16'     -- Prince Georges County
									  WHEN V_PRIMARY_COUNTY_CD = '1444' THEN '17'     -- Queen Annes County
									  WHEN V_PRIMARY_COUNTY_CD = '1446' THEN '18'     -- St. Marys County
									  WHEN V_PRIMARY_COUNTY_CD = '1445' THEN '19'     -- Somerset County
									  WHEN V_PRIMARY_COUNTY_CD = '1447' THEN '20'     -- Talbot County
									  WHEN V_PRIMARY_COUNTY_CD = '1448' THEN '21'     -- Washington County
									  WHEN V_PRIMARY_COUNTY_CD = '1449' THEN '22'     -- Wicomico County
									  WHEN V_PRIMARY_COUNTY_CD = '1450' THEN '23'     -- Worcester County
									  WHEN V_PRIMARY_COUNTY_CD = '1429' THEN '30'     -- Baltimore City
									  WHEN V_PRIMARY_COUNTY_CD = '3824' THEN '00'     -- DHR/SSA
								   END  ;
		
			service_case_id = (SELECT servicecaseid 
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
			FROM  routing 
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
			SELECT right( regexp_replace (upn.phonenumber::varchar, '[- ]+','','g')::varchar, 10) as phonenumber,
				substring(COALESCE(up.firstname || ' ','') || COALESCE(up.lastname,''),1,50)
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
					and upa.securityusersid=sec_id::character varying
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
				substring(COALESCE(person.lastname,''), 1, 20),
				substring(COALESCE(person.firstname,''), 1, 20),
				COALESCE(substring(btrim(person.middlename), 1, 10),''),
				-- CIDM-2203
				substring((select value_text 
					from cjams.referencevalues rf  
				where rf.referencetypeid = 302
					and rf.activeflag = 1 
					and rf.value_text not in ('Ret.')
					and rf.ref_key = person.suffix ),1,5
				) as suffix,
				-- SUBSTRING(F_PLVALUE(person.suffix,214),1,5), -- changed from name_suffix  #26062019
				--alias.ssn :: INTEGER,
				--person.ssnno, -- table changed 
				( CASE WHEN (personidentifier.personidentifiervalue ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$') = false then 
					NULL 
				  ELSE 
					personidentifier.personidentifiervalue::integer 
				  END ),
				-- personidentifier.personidentifiervalue:: integer,
				to_char(person.dob,'yyyymmdd')::integer,
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
			INTO    VS_CIS_CLIENT_ID,
				VS_CLIENT_SURNAME,
				VS_CLIENT_GIVENNAME,
				VS_CLIENT_MIDDLENAME,
				VS_CLIENT_SUFFIX,
				VL_SSN_NO,
				VL_DOB_DT,
				VS_CLIENT_GENDER,
				VS_CLIENT_RACE
			FROM person	LEFT OUTER JOIN personidentifier ON person.personid = personidentifier.personid 
				AND personidentifier.activeflag = 1 
				AND personidentifier.personidentifiertypekey = 'SSN'		
			WHERE person.cjamspid = VL_CLIENT_ID	
				AND person.activeflag = 1;
		
			EXCEPTION WHEN OTHERS THEN
			VL_OUTPUT_SQLCODE  :=  SQLSTATE;
			VS_MESSAGE := 'SELECT  FAILED FOR TB_CLIENT' ||SQLERRM  ;
			RETURN;
		END;
		
		---GAYATHRI RAJUKMAR - DECLINED RACE MAPPED TO UNKNOWN -2010-04-14
		IF  (LTRIM(RTRIM(VS_CLIENT_RACE)) = '3004' OR LTRIM(RTRIM(VS_CLIENT_RACE)) = '6314' ) THEN
			VS_CLIENT_RACE := '6312';
		ELSIF LTRIM(RTRIM(VS_CLIENT_RACE)) = 'DC' THEN
			VS_CLIENT_RACE := '6312';
		END IF;
		
		BEGIN 	
			SELECT 	*
				INTO    VS_CLIENT_MARITAL_STATUS
			FROM
					(SELECT  
							/* case		
								when personmaritalstatus.statustypekey = '88' then '88'		
								when personmaritalstatus.statustypekey = '99' then '99'		
								when personmaritalstatus.statustypekey = 'UK' then '7791'		
								when personmaritalstatus.statustypekey = 'WD' then '3673'		
								when personmaritalstatus.statustypekey = 'DV' then '1568'		
								when personmaritalstatus.statustypekey = 'LS' then '1570'		
								when personmaritalstatus.statustypekey = 'LP' then 'LP'		
								when personmaritalstatus.statustypekey = 'MR' then '1569'		
								when personmaritalstatus.statustypekey = 'SG' then '1571'		
								when personmaritalstatus.statustypekey = '' then '    '		
								else personmaritalstatus.statustypekey		
							end */
							case		
								when personmaritalstatus.statustypekey IN  ('88' , '99', 'LP', 'LTU') then '7791'		
								when personmaritalstatus.statustypekey = 'UK' then '7791'		
								when personmaritalstatus.statustypekey = 'WD' then '3673'		
								when personmaritalstatus.statustypekey = 'DV' then '1568'		
								when personmaritalstatus.statustypekey = 'LS' then '1570'		
								when personmaritalstatus.statustypekey = 'MR' then '1569'		
								when personmaritalstatus.statustypekey = 'SG' then '1571'	
								when personmaritalstatus.statustypekey = '1568' then '1568'		
								when personmaritalstatus.statustypekey = '1569' then '1569'		
								when personmaritalstatus.statustypekey = '1570' then '1570'		
								when personmaritalstatus.statustypekey = '1571' then '1571'
								when personmaritalstatus.statustypekey = '3673' then '3673'
								when personmaritalstatus.statustypekey = '7791' then '7791'
								when personmaritalstatus.statustypekey = '' then '    '		
								else '7791'		
						end
					FROM    personmaritalstatus, person 	
					WHERE   personmaritalstatus.personid = person.personid
							and person.cjamspid =  VL_CLIENT_ID
							AND     personmaritalstatus.activeflag = 1
					ORDER BY personmaritalstatus.startdate DESC  
				--,personmaritalstatus.old_id DESC
				) AS A
			LIMIT 1 ;

			EXCEPTION WHEN OTHERS THEN
			VL_OUTPUT_SQLCODE  :=  SQLSTATE;
			VS_MESSAGE := 'SELECT  FAILED FOR personmaritalstatus' ||SQLERRM ;
			RETURN;
		END;
		
		BEGIN	
			SELECT 	*
			INTO 	VS_AKA_LAST_NM
			FROM
					(	SELECT 	substring(COALESCE(alias.lastname,''), 1, 20)
						FROM  	alias, person
						WHERE 	alias.personid = person.personid
								and person.cjamspid =  VL_CLIENT_ID
								AND alias.activeflag = 1
								AND alias.akatypetypekey in( '2553' ,'MN') --  check with sai team 
						ORDER BY alias.insertedon DESC
						--, alias.old_id DESC
					) AS A
			LIMIT 1 ;
		
		
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR alias '||SQLERRM  ;
				RETURN;
		END;
		
		BEGIN	
			SELECT	*
			INTO   	VS_CLIENT_BIRTH_HOSPITAL,
					VS_CLIENT_BIRTH_CITY,
					VS_CLIENT_BIRTH_STATE
			FROM
					(	SELECT 	hospitalname,
								cityname,
								statetypekey   	
						FROM 	clientunder5yearsinfo, person
						WHERE 	clientunder5yearsinfo.personid = person.personid
								and person.cjamspid = VL_CLIENT_ID
								AND clientunder5yearsinfo.activeflag = 1
						ORDER BY clientunder5yearsinfo.insertedon DESC, clientunder5yearsinfo.old_id DESC) AS A
			LIMIT 1 ;
		
		
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR clientunder5yearsinfo '||SQLERRM  ;
				RETURN;
		END;
		
		BEGIN
			SELECT 	*
			INTO 	VS_CLIENT_RESIDENCY_STATUS
			FROM
					(SELECT CASE	WHEN ADR_STATE_CD = 'MD' THEN 'Y'
									WHEN ADR_STATE_CD IS NULL THEN ''
									WHEN ADR_STATE_CD = '' THEN ''
								ELSE 'N'
							END
					FROM   	TB_PROVIDER_ADDRESSES
					WHERE  	PARENT_KEY_ID::INTEGER = VL_PROVIDER_ID
							AND    ADR_END_DT IS NULL
							AND    ADR_START_DT IS NOT NULL
							AND    DELETE_SW = 'N'
							AND    ADR_TYPE_CD = '3357'
					ORDER BY ADR_START_DT DESC, ADDRESS_ID DESC) AS A
			LIMIT 1 ;

		
		
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT RESIDENCY STATUS FAILED FOR TB_PROVIDER_ADDRESSES '||SQLERRM  ;
				RETURN;
		END;	
		
		--- --#12329 added for no record for disability, the client_disabled should be 'N'
		IF EXISTS(select 1 from personmedicalinfo, person 
					WHERE personmedicalinfo.personid = person.personid AND
			person.cjamspid = VL_CLIENT_ID AND personmedicalinfo.activeflag = 1) THEN
		
		ELSE
			 VS_CLIENT_DISABLED := 'N';
		END IF;
		--- #12329
	   
		BEGIN   
			SELECT 	* 
			INTO 	VS_CLIENT_DISABLED,
					VS_CLIENT_PHYSICAL_DISABILITY,
					VS_CLIENT_MENTAL_DISABILITY,
					VS_CLIENT_VISUAL_DISABILITY,
					VS_CLIENT_HEARING_DISABILITY,
					VS_CLIENT_MENTAL_RETARDATION,
					VS_CLIENT_LEARNING_DISABILITY,
					VS_CLIENT_COGNITIVE_DISABILITY,
					VS_CLIENT_DEV_DELAY_DISABILITY,
					VS_CLIENT_OTHER_DISABILITY
			FROM
					(	SELECT	CASE 	WHEN physicaldisabilitykey IN('1168','1169','1170') THEN 'Y'
										WHEN emotionaldisabilitykey IN('1168','1169','1170') THEN 'Y'
										WHEN visualdisabilitykey IN('1168','1169','1170') THEN 'Y'
										WHEN hearingdisabilitykey IN('1168','1169','1170') THEN 'Y'
										WHEN mentalretardationtypekey IN('1168','1169','1170') THEN 'Y'
										WHEN otherdisabilitykey IN('1168','1169','1170') THEN 'Y'
										WHEN learningdisabilitykey IN('1168','1169','1170') THEN 'Y'
										WHEN physicaldisabilitykey IN('MLD','MOD','SEVR') THEN 'Y'
										WHEN emotionaldisabilitykey IN('MLD','MOD','SEVR') THEN 'Y'
										WHEN visualdisabilitykey IN('MLD','MOD','SEVR') THEN 'Y'
										WHEN hearingdisabilitykey IN('MLD','MOD','SEVR') THEN 'Y'
										WHEN mentalretardationtypekey IN('MLD','MOD','SEVR') THEN 'Y'
										WHEN otherdisabilitykey IN('MLD','MOD','SEVR') THEN 'Y'
										WHEN learningdisabilitykey IN('MLD','MOD','SEVR') THEN 'Y'
										WHEN mentallyretarded =  'Y' THEN 'Y'
										WHEN developmentallydelayedflag = 0 THEN 'Y'
										ELSE 'N'	
								END,
								CASE	WHEN physicaldisabilitykey IN('1168','1169','1170') THEN 'PD'
										WHEN physicaldisabilitykey IN('MLD','MOD','SEVR') THEN 'PD'
										ELSE LPAD('',2)
								END,
								CASE 	WHEN emotionaldisabilitykey IN('1168','1169','1170') THEN 'MD'
										WHEN emotionaldisabilitykey IN('MLD','MOD','SEVR') THEN 'MD'
										ELSE LPAD('',2)
								END,
								CASE 	WHEN visualdisabilitykey IN('1168','1169','1170') THEN 'VD'
										WHEN visualdisabilitykey IN('MLD','MOD','SEVR') THEN 'VD'
										ELSE LPAD('',2)
								END,
								CASE 	WHEN hearingdisabilitykey IN('1168','1169','1170') THEN 'HD'
										WHEN hearingdisabilitykey IN('MLD','MOD','SEVR') THEN 'HD'
										ELSE LPAD('',2)
								END,
								CASE 	WHEN mentalretardationtypekey IN('1168','1169','1170') THEN 'MR'
										WHEN mentalretardationtypekey IN('MLD','MOD','SEVR') THEN 'MR'
										ELSE LPAD('',2)
								END,
								CASE	WHEN learningdisabilitykey IN('1168','1169','1170') THEN 'LD'
										WHEN learningdisabilitykey IN('MLD','MOD','SEVR') THEN 'LD'
										ELSE LPAD('',2)
								END,
								CASE 	WHEN mentallyretarded = 'Y' THEN 'CD'
										ELSE LPAD('',2)
								END,
								CASE 	WHEN developmentallydelayedflag = 0 THEN 'DD'
										ELSE LPAD('',2)
								END,
								CASE 	WHEN otherdisabilitykey IN('1168','1169','1170') THEN 'OD'
										WHEN otherdisabilitykey IN('MLD','MOD','SEVR')THEN 'OD'
										ELSE LPAD('',2)
								END
						FROM  	personmedicalinfo, person
						WHERE 	personmedicalinfo.personid = person.personid
								and person.cjamspid = VL_CLIENT_ID
								AND   personmedicalinfo.activeflag = 1
						ORDER BY personmedicalinfo.insertedon  DESC, personmedicalinfo.old_id  DESC) AS A
						LIMIT 1 ;

		
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR personmedicalinfo '||SQLERRM  ;
				RETURN;
		END ;
		
		BEGIN
			
			select 	( CASE WHEN COUNT(*) > 0 THEN 
						'Y'
					  ELSE 
						'N'
					  END 
					)
				INTO VS_CLIENT_MEDICAL_INSURANCE
			from personhealthinsurance phlt,
				person pr
			where phlt.personid = pr.personid 
				and pr.cjamspid = VL_CLIENT_ID
				and phlt.activeflag = 1
				and phlt.insurancetype <> 'HOWN'  -- 1371 - Homeowners Insurance
				and phlt.caresauno IS NULL 
				and phlt.effectivedate IS NOT NULL  
				and ( phlt.expirationdate IS NULL OR phlt.expirationdate > phlt.effectivedate );
			/*	
			SELECT  	CASE 	WHEN COUNT(*) > 0 THEN 'Y'
						ELSE 'N'
						END
			INTO   		VS_CLIENT_MEDICAL_INSURANCE
			FROM    	personinsurance, person
			WHERE  		personinsurance.personid = person.personid 
						and    person.cjamspid =  VL_CLIENT_ID
						AND     personinsurance.activeflag = 1
						AND     personinsurance.typekey <> '1371' 
						AND     personinsurance.caresauno IS NULL  
						AND     personinsurance.startdate IS NOT NULL  
						AND     (personinsurance.enddate IS NULL  
						OR      personinsurance.enddate > personinsurance.startdate);
			*/

			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR personhealthinsurance '||SQLERRM  ;
				RETURN ;
		END ; 	
		
		IF VS_TRANSACTION_TYPE_CD = '15' OR VS_PLACEMENT_STRUCTURE_ID ='S' THEN -- #12329
			
			CARES_OUT_COL38 := '';
			CARES_OUT_COL39 := NULL::INTEGER;
			CARES_OUT_COL40 := NULL::INTEGER;
		ELSE
			BEGIN
				SELECT * INTO   CARES_OUT_COL38,
								CARES_OUT_COL39,
								CARES_OUT_COL40
				FROM
				(SELECT CASE WHEN btrim(ELIGIBILITY_STATUS_CD) IN ('2912','2913','3597','3598') THEN 'F'
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
				--  Incident #7739
				--	    AND TB_CLIENT_ELIGIBILITY.ELIGIBILITY_TYPE_CD = '2931'
					AND btrim(TB_CLIENT_ELIGIBILITY.ELIGIBILITY_TYPE_CD) IN ('2931','2934')
					AND TB_CLIENT_ELIGIBILITY.START_DT IS NOT NULL
				--    AND TB_CLIENT_ELIGIBILITY.END_DT IS NULL -- #7739 04/18/07
					AND TB_CLIENT_ELIGIBILITY.DELETE_SW = 'N'
				ORDER BY TB_CLIENT_ELIGIBILITY.START_DT DESC, TB_CLIENT_ELIGIBILITY.ELIGIBILITY_ID DESC) AS A
				LIMIT 1 ;
		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT  FAILED FOR TB_CLIENT_ELIGIBILITY '||SQLERRM  ;
					RETURN ;
			END;
		END IF;
		
		IF VS_TRANSACTION_TYPE_CD = '10' THEN
			VL_TRANSACTION_DATE := VL_PLACEMENT_START_DATE;
		ELSIF VS_TRANSACTION_TYPE_CD = '70' THEN
			VL_TRANSACTION_DATE := VL_PLACEMENT_END_DATE;
		ELSIF VS_TRANSACTION_TYPE_CD = '20' THEN
			VL_TRANSACTION_DATE := CARES_OUT_COL39;
		ELSIF VS_TRANSACTION_TYPE_CD = '30' THEN
			VL_TRANSACTION_DATE := CARES_OUT_COL40;
		ELSIF VS_TRANSACTION_TYPE_CD = '40' THEN
			BEGIN			
				SELECT to_char(PAYMENT_DT,'yyyymmdd')::INTEGER
					
					INTO VL_TRANSACTION_DATE
				FROM TB_PAYMENT_HEADER
				WHERE PAYMENT_ID = VL_OTHER_ID
				AND DELETE_SW = 'N';

				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT PAYMENT_DT FAILED FOR TABLE PAYMENT_HEADER '||SQLERRM  ;
					RETURN ;
			END;

		ELSE
			VL_TRANSACTION_DATE := to_char(VD_TRANSACTION_TS::DATE,'yyyymmdd')::INTEGER	;

		END IF;
		
		BEGIN	
			SELECT  to_char(PH.PAYMENT_DT,'yyyymmdd')::INTEGER,
				SUM((PD.FINAL_AMOUNT_NO)::DECIMAL(10,2))
			INTO CARES_OUT_COL41,
				 CARES_OUT_COL42
				FROM TB_PAYMENT_HEADER PH, TB_PAYMENT_DETAIL PD
				WHERE PD.CLIENT_ID = VL_CLIENT_ID
				AND PD.PAYMENT_ID = PH.PAYMENT_ID
				AND PH.PAYMENT_TYPE_CD = '6'
				AND PH.PAYMENT_DT IS NOT NULL
				AND PH.DELETE_SW = 'N'
				AND PD.DELETE_SW = 'N'
				AND PD.PAYMENT_ID = (SELECT MAX(A.PAYMENT_ID)
					FROM TB_PAYMENT_DETAIL A, TB_PAYMENT_HEADER B
					WHERE A.CLIENT_ID = VL_CLIENT_ID
					AND A.PAYMENT_ID = B.PAYMENT_ID
					AND B.PAYMENT_TYPE_CD = '6'
					AND B.PAYMENT_DT IS NOT NULL
					AND A.DELETE_SW = 'N'
					AND B.DELETE_SW = 'N')
				GROUP BY PH.PAYMENT_DT;

			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT  FAILED FOR TB_PAYMENT_DETAIL '||SQLERRM ;
				RETURN;
		END ;
		
		CARES_OUT_COL42_CONVERT := LTRIM(RTRIM((CARES_OUT_COL42::VARCHAR))) ;   	
		CARES_OUT_COL42_CONVERT := SUBSTRING('00000000000',1,11 - LENGTH(CARES_OUT_COL42_CONVERT)) || CARES_OUT_COL42_CONVERT ;
		BEGIN	
			SELECT *
			INTO CARES_OUT_COL43,
				 VL_PRIMARY_CAREGIVER_ID
			FROM
			(SELECT substring(COALESCE(TC.firstname || ' ','') || COALESCE(TC.lastname,''), 1, 50),
				   TR.primarycaregiverid
			FROM  intakeservreqchildremoval TR, person TC, intakeservicerequestactor TSA
			WHERE TR.intakeservicerequestactorid = TSA.intakeservicerequestactorid
			and TSA.personid = TC.personid
			and TC.cjamspid = VL_CLIENT_ID
			AND TR.primarycaregiverid = TC.cjamspid
			AND TR.activeflag = 1
			AND TC.activeflag = 1
			and TSA.activeflag = 1
			ORDER BY TR.removaldate DESC , TR.removalid desc) AS A
			LIMIT 1 ;
					
		
			EXCEPTION WHEN OTHERS THEN 			
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT PRIMARY CAREGIVER FAILED FOR TB_REMOVAL '||SQLERRM  ;
				RETURN;
		END ;
		
		BEGIN	
			SELECT *
			INTO CARES_OUT_COL44,
				 CARES_OUT_COL45,
				 CARES_OUT_COL46,
				 CARES_OUT_COL47,
				 CARES_OUT_COL48,
				 CARES_OUT_COL49,
				 CARES_OUT_COL50,
				 CARES_OUT_COL51,
				 CARES_OUT_COL52
				FROM    	
			(SELECT SUBSTRING(F_PLVALUE(personaddresstypekey,69),1,3), -- column changed #26062019
				   SUBSTRING(address,'(^[0-9]+)'), -- ADR_STREET_NO
				   TRIM(substring(address,'([[:alpha:]\s]+)')),
				   adrstreetsuffixtypekey,
				   SUBSTRING(F_PLVALUE(personaddresstypekey,69),1,3), -- column changed #26062019
				   adrunitno,
				   city,
				   state,
				   SUBSTRING(COALESCE(CAST(zipcode as VARCHAR),'00000'),1,5) || SUBSTRING(COALESCE(CAST(adrzip4no as VARCHAR),'0000'),1,4):: INTEGER
			FROM personaddress
			WHERE -- CIDM-2203
				-- old_id::INTEGER = VL_PRIMARY_CAREGIVER_ID
				personid = (select p.personid 
								from cjams.person p 
						    where p.cjamspid = VL_PRIMARY_CAREGIVER_ID 
								and p.activeflag = 1
						   )
				AND  personadrenddate IS NULL
				AND  personadrstartdate IS NOT NULL
				AND  activeflag = 1 
				AND  adrdefaultflag = 1 -- 0
			ORDER BY personadrstartdate DESC, old_id desc) AS A
			LIMIT 1 ;

			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT PRIMARY CAREGIVER ADDRESS FAILED FOR TB_CLIENT_ADDRESSES '||SQLERRM  ;
				RETURN;
		END ;
		
		-- Provider Location Address
		BEGIN	
			SELECT *
			INTO CARES_OUT_COL53,
				 CARES_OUT_COL54,
				 CARES_OUT_COL55,
				 CARES_OUT_COL56,
				 CARES_OUT_COL57,
				 CARES_OUT_COL58,
				 CARES_OUT_COL59,
				 CARES_OUT_COL60,
				 CARES_OUT_COL61
			FROM
			(SELECT SUBSTRING(F_PLVALUE(ADR_PRE_DIR_CD,69),1,3),
				   SUBSTRING(ADR_STREET_TX,1,9), -- ADR_STREET_NO
				   ADR_STREET_NM,
				   ADR_STREET_SUFFIX_CD,
				   SUBSTRING(F_PLVALUE(ADR_POST_DIR_CD,69),1,3),
				   ADR_UNIT_NO_TX,
				   ADR_CITY_NM,
				   ADR_STATE_CD,
				   (SUBSTRING(COALESCE((ADR_ZIP5_NO::VARCHAR),'00000'),1,5) || SUBSTRING(COALESCE((ADR_ZIP4_NO::VARCHAR),'0000'),1,4))::INTEGER
			FROM   TB_PROVIDER_ADDRESSES
				WHERE  PARENT_KEY_ID::INTEGER = VL_PROVIDER_ID
			AND    ADR_END_DT IS NULL
			AND    ADR_START_DT IS NOT NULL
			AND    DELETE_SW = 'N'
			AND    ADR_TYPE_CD = '3357'
			ORDER BY ADR_START_DT DESC, ADDRESS_ID DESC) AS A
			LIMIT 1 ;
		
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT PROVIDER LOCATION ADDRESS FAILED FOR TB_PROVIDER_ADDRESSES '||SQLERRM  ;
				RETURN;
		END ;
		
		BEGIN	
			-- Provider Info	
			SELECT ADR_WORK_PHONE_TX,
				   PROVIDER_NM,
				   PROVIDER_FIRST_NM,
				   PROVIDER_MIDDLE_NM,
				   PROVIDER_LAST_NM ,
				   ADM_WORK_PHONE_TX,
				   PROVIDER_SUFFIX_CD
			INTO  CARES_OUT_COL62,
				  LS_temp_PROVIDER_NM,
				  LS_temp_PROV_FIRST_NM,
				  LS_temp_PROV_MIDDLE_NM,
				  LS_temp_PROV_LAST_NM,
				  CARES_OUT_COL73,
				  LS_temp_PROV_SUFFIX
			FROM TB_PROVIDER
			WHERE PROVIDER_ID = VL_PROVIDER_ID
			AND DELETE_SW = 'N';

			CARES_OUT_COL63 := CASE  WHEN LENGTH(RTRIM(LS_temp_PROVIDER_NM)) > 0 THEN -- #12329
					  LS_temp_PROVIDER_NM
			ELSE
				  COALESCE(LS_temp_PROV_FIRST_NM || ' ','')  ||  COALESCE(LS_temp_PROV_MIDDLE_NM || ' ','') ||
											COALESCE(LS_temp_PROV_LAST_NM,'') 
			END ;
		
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT PROVIDER INFO FAILED FOR TB_PROVIDER '||SQLERRM  ;
				RETURN;
		END ;

		BEGIN
			-- New Code to get Provider Address
			SELECT PAY_TO_AFFILIATE_CD
			INTO VS_PAY_TO_AFFILIATE_CD
			FROM TB_PROVIDER
			WHERE PROVIDER_ID = VL_PROVIDER_ID
			AND DELETE_SW = 'N';     	
		
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT PAY_TO_AFFILIATE_CD FAILED FOR TB_PROVIDER ' ||SQLERRM ;
				RETURN;
		END ; 	
		
	   IF VS_PAY_TO_AFFILIATE_CD IN ('3366') THEN -- For LDSS
			VS_ALTERNATE_ADR_TYPE_CD := '3357';
			VL_TEMP_PROVIDER_ID := VL_PROVIDER_ID;

		ELSIF VS_PAY_TO_AFFILIATE_CD IN ('3367') THEN -- For Private Department
			VS_ALTERNATE_ADR_TYPE_CD := '3356';
			VL_TEMP_PROVIDER_ID := VL_PROVIDER_ID;

		ELSIF VS_PAY_TO_AFFILIATE_CD IN ('3368') THEN
				  
			BEGIN
				SELECT DISTINCT TB_PROVIDER.AFFILIATE_PROVIDER_ID
					INTO VL_AFFILIATE_PROVIDER_ID
				FROM  TB_PROVIDER
				WHERE  TB_PROVIDER.PROVIDER_ID  = VL_PROVIDER_ID
					AND TB_PROVIDER.DELETE_SW  = 'N';
		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT AFFILIATE_PROVIDER_ID FAILED FOR TB_PROVIDER '||SQLERRM  ;
					RETURN;
			END ;

			IF  VL_AFFILIATE_PROVIDER_ID > 0 THEN
				BEGIN				
					SELECT PAY_TO_AFFILIATE_CD
						INTO VS_PAY_TO_AFFILIATE_CD_1
					FROM TB_PROVIDER
					WHERE PROVIDER_ID = VL_AFFILIATE_PROVIDER_ID
					AND DELETE_SW = 'N';     	
			
					EXCEPTION WHEN OTHERS THEN
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;
						VS_MESSAGE := 'SELECT PAY_TO_AFFILIATE_CD FAILED FOR AFFILIATE ORGANIZATION '||SQLERRM  ;
						RETURN;
				END ;
		
				IF VS_PAY_TO_AFFILIATE_CD_1 IN ('3366') THEN -- For LDSS
					VS_ALTERNATE_ADR_TYPE_CD := '3357';
					VL_TEMP_PROVIDER_ID := VL_AFFILIATE_PROVIDER_ID;
				ELSIF VS_PAY_TO_AFFILIATE_CD_1 IN ('3367') THEN -- For Private Department
					VS_ALTERNATE_ADR_TYPE_CD := '3356';
					VL_TEMP_PROVIDER_ID := VL_AFFILIATE_PROVIDER_ID;
				ELSE
					VS_ALTERNATE_ADR_TYPE_CD := LPAD('',4);
				END IF;
			END IF;
		ELSE
			VS_ALTERNATE_ADR_TYPE_CD := LPAD('',4);
		END IF;
		
		BEGIN	
			SELECT *
				INTO CARES_OUT_COL64,
				 CARES_OUT_COL65,
				 CARES_OUT_COL66,
				 CARES_OUT_COL67,
				 CARES_OUT_COL68,
				 CARES_OUT_COL69,
				 CARES_OUT_COL70,
				 CARES_OUT_COL71,
				 CARES_OUT_COL72
			FROM
			(SELECT SUBSTRING(F_PLVALUE(ADR_PRE_DIR_CD,69),1,3),
				   SUBSTRING(ADR_STREET_TX,1,9), -- ADR_STREET_NO
				   ADR_STREET_NM,
				   ADR_STREET_SUFFIX_CD,
				   SUBSTRING(F_PLVALUE(ADR_POST_DIR_CD,69),1,3),
				   ADR_UNIT_NO_TX,
				   ADR_CITY_NM,
				   ADR_STATE_CD,
				   (SUBSTRING(COALESCE((ADR_ZIP5_NO::VARCHAR),'00000'),1,5) || SUBSTRING(COALESCE((ADR_ZIP4_NO::VARCHAR),'0000'),1,4))::INTEGER
			FROM   TB_PROVIDER_ADDRESSES
				WHERE  PARENT_KEY_ID::INTEGER = VL_TEMP_PROVIDER_ID
			AND    ADR_END_DT IS NULL
			AND    ADR_START_DT IS NOT NULL
			AND    DELETE_SW = 'N'
			AND    ADR_TYPE_CD = VS_ALTERNATE_ADR_TYPE_CD
			ORDER BY  ADR_START_DT DESC, ADDRESS_ID DESC) AS A
			LIMIT 1 ;
		
			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT PROVIDER MAILING ADDRESS FAILED FOR TB_PROVIDER_ADDRESSES '||SQLERRM  ;
				RETURN;
		END ;
		
		-- Coding to start from here  CARES_OUT_COL74 to  CARES_OUT_COL88
		IF VS_PLACEMENT_STRUCTURE_ID = 'S' THEN -- #12329
			 CARES_OUT_COL74 := LS_temp_PROV_LAST_NM;
			 CARES_OUT_COL75 := LS_temp_PROV_FIRST_NM ;
			 CARES_OUT_COL76 := LS_temp_PROV_MIDDLE_NM;
			 CARES_OUT_COL77 := LS_temp_PROV_SUFFIX;
			 CARES_OUT_COL78 := CARES_OUT_COL53;
			 CARES_OUT_COL79 := CARES_OUT_COL54;
			 CARES_OUT_COL80 := CARES_OUT_COL55;
			 CARES_OUT_COL81 := CARES_OUT_COL56;
			 CARES_OUT_COL82 := CARES_OUT_COL57;
			 CARES_OUT_COL83 := CARES_OUT_COL58;
			 CARES_OUT_COL84 := CARES_OUT_COL59;
			 CARES_OUT_COL85 := CARES_OUT_COL60;
			 CARES_OUT_COL86 := CARES_OUT_COL61;
			 CARES_OUT_COL87 := CARES_OUT_COL62;
			 CARES_OUT_COL88 := 'W';
		
		ELSIF VS_PLACEMENT_STRUCTURE_ID IN ('F','K') THEN
			
			BEGIN
				SELECT  substring(UP.lastname, 1, 20),
						substring(UP.firstname, 1 ,20),
						substring(UP.middlename, 1, 10),
						SUBSTRING(UP.displayname,1,5), --- changed the column from name_suffix #26062019
						UPP.phonenumber
				INTO CARES_OUT_COL74,
					CARES_OUT_COL75,
					CARES_OUT_COL76,
					CARES_OUT_COL77,
					CARES_OUT_COL87
				FROM userprofile UP, userprofilephonenumber UPP ,muser m
				where UP.securityusersid = UPP.securityusersid
				and m.securityusersid = UP.securityusersid
				and m.id::varchar = VL_STAFF_ID
				AND UP.activeflag = 1
				and UPP.activeflag = 1
				and m.activeflag = 1;
		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT STAFF INFO FAILED FOR TB_STAFF '||SQLERRM  ;
					RETURN;
			END;
			
			BEGIN	
				SELECT *
				INTO CARES_OUT_COL78,
					 CARES_OUT_COL79,
					 CARES_OUT_COL80,
					 CARES_OUT_COL81,
					 CARES_OUT_COL82,
					 CARES_OUT_COL83,
					 CARES_OUT_COL84,
					 CARES_OUT_COL85,
					 CARES_OUT_COL86
				FROM
				(	SELECT	SUBSTRING(F_PLVALUE(adrpredirtypekey,69),1,3),
							SUBSTRING(UPA.address,'(^[0-9]+)'), -- ADR_STREET_NO
							TRIM(substring(UPA.address,'([[:alpha:]\s]+)')),
							UPA.adrstreetsuffixtypekey,
							SUBSTRING(F_PLVALUE(UPA.adrpostdirtypekey,69),1,3),
							UPA.adrunitno,
							UPA.city,
							UPA.state,
							SUBSTRING(COALESCE(CAST(UPA.zipcode as VARCHAR),'00000'),1,5) || SUBSTRING(COALESCE(CAST(UPA.zipcodeplus as VARCHAR),'0000'),1,4):: INTEGER	
					FROM 	userprofileaddress UPA, 
							securityusers UP, 
							userprofilephonenumber UPP
					where 	UPA.securityusersid = UP.securityusersid
							and UPP.securityusersid = UP.securityusersid
							and UP.securityusersid  = VL_STAFF_ID
							AND UP.activeflag = 1
							and UPP.activeflag = 1
							and UPA.activeflag = 1
							AND adrdefaultflag = 1
				ORDER BY UPA.insertedon DESC, UPA.old_id DESC) AS A
				LIMIT 1 ;
		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT STAFF ADDRESS FAILED FOR TB_STAFF_ADDRESS '||SQLERRM  ;
					RETURN;
			END ;
			
			CARES_OUT_COL88 := 'W';
		
		ELSIF VS_PLACEMENT_STRUCTURE_ID IN ('A') THEN
			BEGIN		
				 /*    SELECT TB_ADOPTION.ADOPTIVE_FATHER_ID,
					TB_ADOPTION.ADOPTIVE_MOTHER_ID
				INTO VL_ADOPTIVE_FATHER_ID,
				 VL_ADOPTIVE_MOTHER_ID
					FROM TB_ADOPTION, servicecase
					 WHERE   servicecase.servicecasenumber = VL_PLACEMENT_CASE_ID
				   -- AND TB_CASE.CASE_TYPE_CD =  '3333'
				  AND TB_ADOPTION.CASE_ID :: varchar = servicecase.servicecasenumber
					AND TB_ADOPTION.DELETE_SW = 'N'
					AND servicecase.activeflag = 1;-- */
				SELECT	PPT.cjamspid,
						PP.cjamspid
				INTO 	VL_ADOPTIVE_FATHER_ID,
						VL_ADOPTIVE_MOTHER_ID
				FROM 	person PP, 
						adoptioncase AC, 
						servicecase SC, 
						intakeservicerequest ISR, 
						intakeservicerequestactor ISA, 
						person PPT
				WHERE 	AC.adoptioncasenumber = VL_PLACEMENT_CASE_ID
						--  AND TB_CASE.CASE_TYPE_CD =  '3333'
						AND SC.servicecaseid = AC.servicecaseid
						AND ISR.intakeserviceid = ISA.intakeserviceid
						AND ISR.servicecaseid = SC.servicecaseid
						AND ISA.personid = PP.personid
						AND ISA.personid = PPT.personid
						AND PPT.gendertypekey IN ('M')
						AND PP.gendertypekey IN ('F')
						AND SC.activeflag = 1
						AND AC.activeflag = 1
						AND ISA.personid IN (	select	intakeservicerequestactor.personid 
												from 	intakeservicerequestactor, 
														actorrelationship 
												where 	actorrelationship.intakeserviceid = intakeservicerequestactor.intakeserviceid 
														AND actorrelationship.relationshiptypekey IN ('adoptiveparent', 'fosterparent','mother', 'father'));

				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT ADOPTIVE INFO FAILED FOR TB_ADOPTION '||SQLERRM  ;
					RETURN;
			END ;
		
			IF  VL_ADOPTIVE_FATHER_ID > 0 THEN
				
				BEGIN			
					 SELECT lastname,
							firstname,
							middlename,
							SUBSTRING(suffixkey,1,5),
							SUBSTRING(F_PLVALUE(adrpredirkey,69),1,3),--column changed #26062019
							SUBSTRING(adrstreet,1,9), -- ADR_STREET_NO
							adrstreetname,
							adrstreetsuffixkey,
							SUBSTRING(F_PLVALUE(adrpostdirkey,69),1,3),--column changed #26062019
							adrunitno,
							adrcityname,
							adrstatekey,
							SUBSTRING(COALESCE(cast(adrzip5no as varchar),'00000'),1,5) || SUBSTRING(COALESCE(cast(adrzip4no as varchar),'0000'),1,4):: INTEGER, -- column changed #26062019
							adrhomephone
					INTO    CARES_OUT_COL74,
							CARES_OUT_COL75,
							CARES_OUT_COL76,
							CARES_OUT_COL77,
							CARES_OUT_COL78,
							CARES_OUT_COL79,
							CARES_OUT_COL80,
							CARES_OUT_COL81,
							CARES_OUT_COL82,
							CARES_OUT_COL83,
							CARES_OUT_COL84,
							CARES_OUT_COL85,
							CARES_OUT_COL86,
							CARES_OUT_COL87
					FROM 	provapprovalperson
					WHERE 	provapprovalperson.old_id::INTEGER = VL_ADOPTIVE_FATHER_ID
							AND  	provapprovalperson.activeflag = 1;

					EXCEPTION WHEN OTHERS THEN
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;
						VS_MESSAGE := 'SELECT INFO FAILED FOR TB_PROV_APPROVAL_PERSON '||SQLERRM  ;
						RETURN;
				END ;

			ELSE
				BEGIN
					SELECT lastname,
							firstname,
							middlename,
							SUBSTRING(suffixkey,1,5),
							SUBSTRING(F_PLVALUE(adrpredirkey,69),1,3),--column changed #26062019
							SUBSTRING(adrstreet,1,9), -- ADR_STREET_NO
							adrstreetname,
							adrstreetsuffixkey,
							SUBSTRING(F_PLVALUE(adrpostdirkey,69),1,3),--column changed #26062019
							adrunitno,
							adrcityname,
							adrstatekey,
							SUBSTRING(COALESCE(cast(adrzip5no as varchar),'00000'),1,5) || SUBSTRING(COALESCE(cast(adrzip4no as varchar),'0000'),1,4):: INTEGER,---column changed #26062019
							adrhomephone
					INTO    CARES_OUT_COL74,
							CARES_OUT_COL75,
							CARES_OUT_COL76,
							CARES_OUT_COL77,
							CARES_OUT_COL78,
							CARES_OUT_COL79,
							CARES_OUT_COL80,
							CARES_OUT_COL81,
							CARES_OUT_COL82,
							CARES_OUT_COL83,
							CARES_OUT_COL84,
							CARES_OUT_COL85,
							CARES_OUT_COL86,
							CARES_OUT_COL87
					FROM 	provapprovalperson
					WHERE  	provapprovalperson.old_id::INTEGER = VL_ADOPTIVE_MOTHER_ID
							AND   provapprovalperson.activeflag = 1;
		
					EXCEPTION WHEN OTHERS THEN
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;
						VS_MESSAGE := 'SELECT INFO FAILED FOR TB_PROV_APPROVAL_PERSON '||SQLERRM  ;
						RETURN;
				END ;
			END IF;
		
			CARES_OUT_COL88 := 'P';
		END IF;
		
		BEGIN	
			-- CARES_OUT_COL89 to  CARES_OUT_COL93
			SELECT  CASE WHEN primarycitizenshiptypekey = '3474' THEN 'Y'
						 WHEN seccitizenshiptypekey = '3474' THEN 'Y'
						 WHEN primarycitizenshiptypekey = 'US' THEN 'Y'
						 WHEN seccitizenshiptypekey = 'US' THEN 'Y'
						 WHEN primarycitizenshiptypekey = 'USA' THEN 'Y'
						 WHEN seccitizenshiptypekey = 'USA' THEN 'Y'
						 WHEN primarycitizenshiptypekey = '' THEN ''
						 WHEN primarycitizenshiptypekey IS NULL THEN ''
						 ELSE 'N'
					END,
					citizenalenagetypekey,
					citizenalenagetypekey,
					F_PLVALUE(primarycitizenshiptypekey,50),
					alienregistrationtext	
			INTO 	CARES_OUT_COL89,
					CARES_OUT_COL90,
					CARES_OUT_COL91,
					CARES_OUT_COL92,
					CARES_OUT_COL93
			FROM 	person
			WHERE  	person.cjamspid =  VL_CLIENT_ID
					AND person.activeflag = 1  ;

			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT CLIENT INFO FAILED FOR TB_CLIENT '||SQLERRM  ;
				RETURN;
		END ;
		
		BEGIN	
			-- CARES_OUT_COL94 to  CARES_OUT_COL107
			SELECT *
			INTO CARES_OUT_COL94,
				 CARES_OUT_COL95,
				 CARES_OUT_COL96,
				 CARES_OUT_COL97,
				 CARES_OUT_COL98,
				 CARES_OUT_COL99,
				 CARES_OUT_COL100,
				 CARES_OUT_COL101,
				 CARES_OUT_COL102,
				 CARES_OUT_COL103,
				 CARES_OUT_COL104,
				 CARES_OUT_COL105,
				 CARES_OUT_COL106,
				 CARES_OUT_COL107
			FROM
			(/* SELECT CASE WHEN statustypekey = '10220' THEN 'Y'
						WHEN statustypekey IS NULL THEN ' '
						WHEN statustypekey = '' THEN ' '
						ELSE 'N'
				   END,
				   statustypekey,
				   currentgradetypekey,
				   lastgradetypekey,
				   educationname,
				   SUBSTRING(F_PLVALUE(adrpredirtypekey,69),1,3),
				   SUBSTRING(adrstreet,1,9), -- ADR_STREET_NO
				   adrstreetname,
				   adrstreetsuffixtypekey,
				   SUBSTRING(F_PLVALUE(adrpostdirtypekey,69),1,3),
				   adrunitno,
				   adrcityname,
				   statecode,
				   SUBSTRING(COALESCE(CAST(adrzip5no AS VARCHAR),'00000'),1,5) || SUBSTRING(COALESCE(CAST(adrzip4no AS VARCHAR),'0000'),1,4) :: INTEGER
					FROM personeducation, person
					WHERE personeducation.personid = person.personid
					and person.cjamspid = VL_CLIENT_ID
					AND  personeducation.activeflag = 1
					ORDER BY personeducation.effectivedate DESC, personeducation.old_id DESC */
			SELECT CASE WHEN statustypekey IN ('10220', 'CEN') THEN 'Y'
						WHEN statustypekey IS NULL THEN ' '
						WHEN statustypekey = '' THEN ' '
						ELSE 'N'
				   END,
			   CASE WHEN statustypekey = 'CEN' THEN '10220' 
				   WHEN statustypekey = 'DRPO' THEN '1206'
				   WHEN statustypekey = 'EXPL' THEN '1207'
				   WHEN statustypekey = 'GRDD' THEN '1208'
				   WHEN statustypekey = 'PMT' THEN '33473'
				   WHEN statustypekey = 'SUSP' THEN '7818'
				   WHEN statustypekey = 'TDFCP' THEN '33475'
				   WHEN statustypekey = 'TNFD' THEN '33471'
				   WHEN statustypekey = 'UNKO' THEN '7819'
				   WHEN statustypekey = 'WDW' THEN '33472'
				   WHEN statustypekey = 'RGD' THEN '33474'
				   WHEN statustypekey = '' THEN '     '
				   END,
			  CASE WHEN currentgradetypekey = 'PSHS' THEN '1291' 
				   WHEN currentgradetypekey = 'KDGN' THEN '1292'
				   WHEN currentgradetypekey = 'GDO' THEN '3370'
				   WHEN currentgradetypekey = 'GDTW' THEN '3371'
				   WHEN currentgradetypekey = 'GDTH' THEN '3372'
				   WHEN currentgradetypekey = 'GDFO' THEN '3373'
				   WHEN currentgradetypekey = 'GDFI' THEN '3374'
				   WHEN currentgradetypekey = 'GDSI' THEN '7807'
				   WHEN currentgradetypekey = 'GDSE' THEN '7808'
				   WHEN currentgradetypekey = 'GDEI' THEN '12860'
				   WHEN currentgradetypekey = 'GDNI' THEN '12861'
				   WHEN currentgradetypekey = 'GDTE' THEN '12862'
				   WHEN currentgradetypekey = 'GDEL' THEN '12863'
				   WHEN currentgradetypekey = 'GDTWL' THEN '12864'
				   WHEN currentgradetypekey = 'PSET' THEN '13053'
				   WHEN currentgradetypekey = 'COL' THEN '13052'
				   WHEN currentgradetypekey = 'UNK' THEN '1289'
				   WHEN currentgradetypekey = 'NIS' THEN '1290'
				   WHEN currentgradetypekey = '7809' THEN '7809'
				   WHEN currentgradetypekey = '7810' THEN '7810'
				   WHEN currentgradetypekey = '' THEN '     '
				   ELSE '1289'
				  -- ELSE currentgradetypekey
				   END,
				CASE   WHEN lastgradetypekey = 'PSHS' THEN '1291' 
				   WHEN lastgradetypekey = 'KDGN' THEN '1292'
				   WHEN lastgradetypekey = 'GDO' THEN '3370'
				   WHEN lastgradetypekey = 'GDTW' THEN '3371'
				   WHEN lastgradetypekey = 'GDTH' THEN '3372'
				   WHEN lastgradetypekey = 'GDFO' THEN '3373'
				   WHEN lastgradetypekey = 'GDFI' THEN '3374'
				   WHEN lastgradetypekey = 'GDSI' THEN '7807'
				   WHEN lastgradetypekey = 'GDSE' THEN '7808'
				   WHEN lastgradetypekey = 'GDEI' THEN '12860'
				   WHEN lastgradetypekey = 'GDNI' THEN '12861'
				   WHEN lastgradetypekey = 'GDTE' THEN '12862'
				   WHEN lastgradetypekey = 'GDEL' THEN '12863'
				   WHEN lastgradetypekey = 'GDTWL' THEN '12864'
				   WHEN lastgradetypekey = 'PSET' THEN '13053'
				   WHEN lastgradetypekey = 'COL' THEN '13052'
				   WHEN lastgradetypekey = 'UNK' THEN '1289'
				   WHEN lastgradetypekey = 'NIS' THEN '1290'
				   WHEN lastgradetypekey = '7809' THEN '7809'
				   WHEN lastgradetypekey = '7810' THEN '7810'
				   WHEN lastgradetypekey = '' THEN '0'
				   ELSE '1289'
				   --ELSE lastgradetypekey
				   END,
				   SUBSTRING(educationname,1,50) as educationname,
				   SUBSTRING(F_PLVALUE(adrpredirtypekey,69),1,3),
				   SUBSTRING(adrstreet,1,9), -- ADR_STREET_NO
				   adrstreetname,
				   adrstreetsuffixtypekey,
				   SUBSTRING(F_PLVALUE(adrpostdirtypekey,69),1,3),
				   adrunitno,
				   adrcityname,
				   statecode,
				   SUBSTRING(COALESCE(CAST(adrzip5no AS VARCHAR),'00000'),1,5) || SUBSTRING(COALESCE(CAST(adrzip4no AS VARCHAR),'0000'),1,4) :: INTEGER
			FROM 	personeducation, person
			WHERE 	personeducation.personid = person.personid
					and person.cjamspid = VL_CLIENT_ID
					AND  personeducation.activeflag = 1
			ORDER BY personeducation.effectivedate DESC, personeducation.old_id DESC) AS A
			LIMIT 1 ;
		
			EXCEPTION WHEN OTHERS THEN 
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT FAILED FOR TB_CLIENT_EDUCATION '||SQLERRM  ;
				RETURN;
		END ;
		
		--- #17248 - 04.10.08 CHECK PHONE NOS FOR SPACES
		IF btrim(VS_WORKER_PHONE) = '' OR VS_WORKER_PHONE IS NULL THEN
			VS_WORKER_PHONE := '0000000000';
		END IF;
		
		IF btrim(CARES_OUT_COL62) = '' OR CARES_OUT_COL62 IS NULL THEN
			CARES_OUT_COL62 := '0000000000';
		END IF;
		
		IF btrim(CARES_OUT_COL73) = '' OR CARES_OUT_COL73 IS NULL THEN
			CARES_OUT_COL73 := '0000000000';
		END IF;
		
		IF btrim(CARES_OUT_COL87) = '' OR CARES_OUT_COL87 IS NULL THEN
			CARES_OUT_COL87 := '0000000000';
		END IF;

		-- Set Interface Data
		BEGIN		
			INSERT INTO TB_CARES_OUTBOUND_INTERFACE
			(	CARES_RECORD_ID,
				STATUS_CD,
				BATCH_SEQ_NO,
				TRANSACTION_SEQ_NO,
				TRANSACTION_TYPE_CD,
				CIS_CLIENT_ID,
				RECORD_TYPE_CD,
				TRANSACTION_TS,
				RECORD_SEQ_NO,
				CARES_OUT_COL1,
				CARES_OUT_COL2,
				CARES_OUT_COL3,
				CARES_OUT_COL4,
				CARES_OUT_COL5,
				CARES_OUT_COL6,
				CARES_OUT_COL7,
				CARES_OUT_COL8,
				CARES_OUT_COL9,
				CARES_OUT_COL10,
				CARES_OUT_COL11,
				CARES_OUT_COL12,
				CARES_OUT_COL13,
				CARES_OUT_COL14,
				CARES_OUT_COL15,
				CARES_OUT_COL16,
				CARES_OUT_COL17,
				CARES_OUT_COL18,
				CARES_OUT_COL19,
				CARES_OUT_COL20,
				CARES_OUT_COL21,
				CARES_OUT_COL22,
				CARES_OUT_COL23,
				CARES_OUT_COL24,
				CARES_OUT_COL25,
				CARES_OUT_COL26,
				CARES_OUT_COL27,
				CARES_OUT_COL28,
				CARES_OUT_COL29,
				CARES_OUT_COL30,
				CARES_OUT_COL31,
				CARES_OUT_COL32,
				CARES_OUT_COL33,
				CARES_OUT_COL34,
				CARES_OUT_COL35,
				CARES_OUT_COL36,
				CARES_OUT_COL37,
				CARES_OUT_COL38,
				CARES_OUT_COL39,
				CARES_OUT_COL40,
				CARES_OUT_COL41,
				CARES_OUT_COL42,
				CARES_OUT_COL43,
				CARES_OUT_COL44,
				CARES_OUT_COL45,
				CARES_OUT_COL46,
				CARES_OUT_COL47,
				CARES_OUT_COL48,
				CARES_OUT_COL49,
				CARES_OUT_COL50,
				CARES_OUT_COL51,
				CARES_OUT_COL52,
				CARES_OUT_COL53,
				CARES_OUT_COL54,
				CARES_OUT_COL55,
				CARES_OUT_COL56,
				CARES_OUT_COL57,
				CARES_OUT_COL58,
				CARES_OUT_COL59,
				CARES_OUT_COL60,
				CARES_OUT_COL61,
				CARES_OUT_COL62,
				CARES_OUT_COL63, 
				CARES_OUT_COL64,
				CARES_OUT_COL65,
				CARES_OUT_COL66,
				CARES_OUT_COL67,
				CARES_OUT_COL68,
				CARES_OUT_COL69,
				CARES_OUT_COL70,
				CARES_OUT_COL71,
				CARES_OUT_COL72,
				CARES_OUT_COL73,
				CARES_OUT_COL74,
				CARES_OUT_COL75,
				CARES_OUT_COL76,
				CARES_OUT_COL77,
				CARES_OUT_COL78,
				CARES_OUT_COL79,
				CARES_OUT_COL80,
				CARES_OUT_COL81,
				CARES_OUT_COL82,
				CARES_OUT_COL83,
				CARES_OUT_COL84,
				CARES_OUT_COL85,
				CARES_OUT_COL86,
				CARES_OUT_COL87,
				CARES_OUT_COL88,
				CARES_OUT_COL89,
				CARES_OUT_COL90,
				CARES_OUT_COL91,
				CARES_OUT_COL92,
				CARES_OUT_COL93,
				CARES_OUT_COL94,
				CARES_OUT_COL95,
				CARES_OUT_COL96,
				CARES_OUT_COL97,
				CARES_OUT_COL98,
				CARES_OUT_COL99,
				CARES_OUT_COL100,
				CARES_OUT_COL101,
				CARES_OUT_COL102,
				CARES_OUT_COL103,
				CARES_OUT_COL104,
				CARES_OUT_COL105,
				CARES_OUT_COL106,
				CARES_OUT_COL107)
			SELECT
				NEXTVAL ('SQ_CARES_OUTBOUND_INTERFACE'),
				'000',
				'',
				CASE WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 1 THEN '0000'||VS_TRANSACTION_SEQUENCE
					 WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 2 THEN '000'||VS_TRANSACTION_SEQUENCE
					 WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 3 THEN '00'||VS_TRANSACTION_SEQUENCE
					 WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 4 THEN '0'||VS_TRANSACTION_SEQUENCE
					 WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 5 THEN VS_TRANSACTION_SEQUENCE
				END,
				VS_TRANSACTION_TYPE_CD,
				COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)),'000000000'),
				'01',
				VD_TRANSACTION_TS,
				'001',
				COALESCE(CAST(VL_TRANSACTION_DATE AS VARCHAR),'00000000'),
				VS_PLACEMENT_STRUCTURE_ID,
				VS_PRIMARY_COUNTY_CD,
				VS_WORKER_NAME,
				COALESCE(VS_WORKER_PHONE,'0000000000'),
				-- right ( regexp_replace(VS_WORKER_PHONE::varchar, '[- ]+','','g')::varchar, 10),
				COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)),'000000000'),
				VS_CLIENT_SURNAME,
				VS_CLIENT_GIVENNAME,
				VS_CLIENT_MIDDLENAME,
				VS_CLIENT_SUFFIX,
				VS_AKA_LAST_NM,
				COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM((VL_SSN_NO))))) || LTRIM(RTRIM((VL_SSN_NO ))),'000000000'),
				COALESCE(CAST(VL_DOB_DT AS VARCHAR),'00000000'),
				VS_CLIENT_GENDER,
				VS_CLIENT_RACE,
				COALESCE(CAST(VL_PLACEMENT_START_DATE AS VARCHAR),'00000000'),
				COALESCE(CAST(VL_PLACEMENT_END_DATE AS VARCHAR),'00000000'),
				VS_PLACEMENT_NAME,
				VS_LONG_TERM_CF_INDICATOR,
						COALESCE(CAST(VL_LTCF_ADMISSION_DATE AS VARCHAR),'00000000'),
						COALESCE(CAST(VL_LTCF_DISCHARGE_DATE AS VARCHAR),'00000000'),
				VS_CLIENT_BIRTH_HOSPITAL,
				VS_CLIENT_BIRTH_CITY,
				VS_CLIENT_BIRTH_STATE,
				VS_CLIENT_MARITAL_STATUS,
				VS_CLIENT_RESIDENCY_STATUS,
				VS_CLIENT_DISABLED,
				VS_CLIENT_PHYSICAL_DISABILITY,
				VS_CLIENT_MENTAL_DISABILITY,
				VS_CLIENT_VISUAL_DISABILITY,
				VS_CLIENT_HEARING_DISABILITY,
				VS_CLIENT_MENTAL_RETARDATION,
				VS_CLIENT_LEARNING_DISABILITY,
				VS_CLIENT_COGNITIVE_DISABILITY,
				VS_CLIENT_DEV_DELAY_DISABILITY,
				VS_CLIENT_OTHER_DISABILITY,
				VS_CLIENT_MEDICAL_INSURANCE,
				CARES_OUT_COL38,
				COALESCE(CAST(CARES_OUT_COL39 AS VARCHAR),'00000000'),
				COALESCE(CAST(CARES_OUT_COL40 AS VARCHAR),'00000000'),
						COALESCE(CAST(CARES_OUT_COL41 AS VARCHAR),'00000000'),
						CASE WHEN (CARES_OUT_COL42_CONVERT = '' OR LENGTH(CARES_OUT_COL42_CONVERT) <= 0) THEN '00000000.00'
						   --  WHEN LENGTH(CARES_OUT_COL42_CONVERT) <= 0 THEN '00000000.00'
							 ELSE COALESCE(CAST(CARES_OUT_COL42_CONVERT AS VARCHAR),'00000000.00')
						END,
						CARES_OUT_COL43,
						CARES_OUT_COL44,
						CARES_OUT_COL45,
						CARES_OUT_COL46,
						CARES_OUT_COL47,
						CARES_OUT_COL48,
						CARES_OUT_COL49,
						CARES_OUT_COL50,
						CARES_OUT_COL51,
						CASE WHEN (CARES_OUT_COL52 = 0 OR CARES_OUT_COL52 IS NULL) THEN '000000000'
						--     WHEN CARES_OUT_COL52 IS NULL THEN '000000000'
							 ELSE SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(CAST(CARES_OUT_COL52 AS VARCHAR))))) || LTRIM(RTRIM(CAST(CARES_OUT_COL52 AS VARCHAR)))
						END,
						CARES_OUT_COL53,
						CARES_OUT_COL54,
						CARES_OUT_COL55,
						CARES_OUT_COL56,
						CARES_OUT_COL57,
						CARES_OUT_COL58,
						CARES_OUT_COL59,
						CARES_OUT_COL60,
						CASE WHEN (CARES_OUT_COL61 = 0 OR CARES_OUT_COL61 IS NULL) THEN '000000000'
							 --WHEN CARES_OUT_COL61 IS NULL THEN '000000000'
							 ELSE SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(CAST(CARES_OUT_COL61 AS VARCHAR))))) || LTRIM(RTRIM(CAST(CARES_OUT_COL61 AS VARCHAR)))
						END,
					   -- CARES_OUT_COL62,
						right ( regexp_replace(CARES_OUT_COL62::varchar, '[- ]+','', 'g')::varchar, 10),
						substring(CARES_OUT_COL63,1,50), 
						CARES_OUT_COL64,
						CARES_OUT_COL65,
						CARES_OUT_COL66,
						CARES_OUT_COL67,
						CARES_OUT_COL68,
						CARES_OUT_COL69,
						CARES_OUT_COL70,
						CARES_OUT_COL71,
						CASE WHEN (CARES_OUT_COL72 = 0 OR CARES_OUT_COL72 IS NULL) THEN '000000000'
							 --WHEN CARES_OUT_COL72 IS NULL THEN '000000000'
							 ELSE SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(CAST(CARES_OUT_COL72 AS VARCHAR))))) || LTRIM(RTRIM(CAST(CARES_OUT_COL72 AS VARCHAR)))
						END,
						CARES_OUT_COL73,
						CARES_OUT_COL74,
						CARES_OUT_COL75,
						CARES_OUT_COL76,
						CARES_OUT_COL77,
						CARES_OUT_COL78,
						CARES_OUT_COL79,
						CARES_OUT_COL80,
						CARES_OUT_COL81,
						CARES_OUT_COL82,
						CARES_OUT_COL83,
						CARES_OUT_COL84,
						CARES_OUT_COL85,
						CASE WHEN (CARES_OUT_COL86 = 0 OR CARES_OUT_COL86 IS NULL) THEN '000000000'
							 --WHEN CARES_OUT_COL86 IS NULL THEN '000000000'
							 ELSE SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(CAST(CARES_OUT_COL86 AS VARCHAR))))) || LTRIM(RTRIM(CAST(CARES_OUT_COL86 AS VARCHAR)))
						END,
						CARES_OUT_COL87,
						CARES_OUT_COL88,
						CARES_OUT_COL89,
						CARES_OUT_COL90,
						CARES_OUT_COL91,
						CARES_OUT_COL92,
						CARES_OUT_COL93 ,
						CARES_OUT_COL94,
						CARES_OUT_COL95,
						CARES_OUT_COL96,
						CAST(CARES_OUT_COL97 AS VARCHAR),
						CARES_OUT_COL98,
						CARES_OUT_COL99,
						CARES_OUT_COL100,
						CARES_OUT_COL101,
						CARES_OUT_COL102,
						CARES_OUT_COL103,
						CARES_OUT_COL104,
						CARES_OUT_COL105,
						CARES_OUT_COL106,
						CASE WHEN (CARES_OUT_COL107 = 0 OR CARES_OUT_COL107 IS NULL) THEN '000000000'
							 --WHEN CARES_OUT_COL107 IS NULL THEN '000000000'
							 ELSE SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(CAST(CARES_OUT_COL107 AS VARCHAR))))) || LTRIM(RTRIM(CAST(CARES_OUT_COL107 AS VARCHAR)))
						END
			   ;

				--RAISE NOTICE 'INSERT IN GEN DATA 01 SUCCESSFUL';

			EXCEPTION WHEN OTHERS THEN
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'INSERT INTO TB_CARES_OUTBOUND_INTERFACE FAILED '||SQLERRM  ;
				RETURN;
		END ;
  
	END IF; 
END 
;
$function$
;
