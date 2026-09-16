CREATE OR REPLACE FUNCTION cjams.sp_cses_outbound_interface_gen_data_20(vl_client_id integer, vl_other_id bigint, vs_transaction_type_cd character varying, vl_transaction_sequence integer, vd_transaction_ts timestamp without time zone, OUT vs_message character varying, OUT vl_output_sqlcode character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Sudhin
-- Date Created :08/01/2005
-- Generates CSES Interface Outbound Data

-- Revision(s)
-- 02/08/2007 - #12329 - Sandhya -- added condition for transaction type ='15' (subsidy guardianship)
-- 04.14.2010 - GAYATHRI RAJKUMAR MAPPED DECLINED RACE TO UNKNOWN.
-- 17-06-2019  -- Swaraj -- Migrations to Postgresql
-- 06/24/2020 Vineet Tirodkar - To modify logic to send Gender as 'U' for all other types than Male & Female 
-- 06/30/2020 Vineet Tirodkar - Modifications to map personmilitaryservices codes with MD CHESSIE Codes 
-- and to send 'Unknown' for racetypekey 'Other' ro any not known code to MD CHESSIE 
-- 07/06/2020 Vineet Tirodkar - To report Person's Insurance info use personhealthinsurance table (Instead of personinsurance)
-- 07/26/2020 Vineet Tirodkar - Modification to Person's Insurance query to join personid (uuid) with parent id
-- 08/20/2020 Vineet Tirodkar - Modifications to send only Valid (Numeric) SSN attribute values (CDM-3270)
-- 03/05/2021 Vineet Tirodkar - Modifications to send workphone as numeric value & person name suffix logic fix (CIDM-2204)
-- 08/03/2021 Vineet Tirodkar - Modifications to send Client Person First/Last Names first 20 characters only 
--								and Middle Name first 10 characters (CDM-15668)

------------------------------------------------------------------------
DECLARE
	VS_RECORD_TYPE VARCHAR(2);
	VS_OUTPUT_STATE VARCHAR(5) DEFAULT '00000';
	VL_RECORD_SEQUENCE INTEGER DEFAULT 000;
	VS_TRANSACTION_SEQUENCE VARCHAR(5);
	VS_RECORD_SEQUENCE VARCHAR(3);
	-- Client Variables
	VS_CIS_CLIENT_ID VARCHAR(10); -- CSES_OUT_COL6

	VL_PARENT_ID UUID;
	VL_NEW_PARENT_ID UUID;
	VL_PARENT_EMPLOYMENT_ID INTEGER;

	CSES_OUT_PARENT_COL1 CHAR(1);
	CSES_OUT_PARENT_COL2 VARCHAR(9);

	CSES_OUT_PARENT_COL3 CHAR(100);
	CSES_OUT_PARENT_COL4 CHAR(1);
	CSES_OUT_PARENT_COL5 INTEGER;

	CSES_OUT_PARENT_COL6  VARCHAR(100);
	CSES_OUT_PARENT_COL7  VARCHAR(100);
	CSES_OUT_PARENT_COL8  VARCHAR(100);
	CSES_OUT_PARENT_COL9  CHAR(100);

	CSES_OUT_PARENT_COL10  VARCHAR(20);

	CSES_OUT_PARENT_COL11  INTEGER;
	CSES_OUT_PARENT_COL12  CHAR(1);
	VD_CLIENT_DOB DATE;
	CSES_OUT_PARENT_COL13  INTEGER;
	CSES_OUT_PARENT_COL14  CHAR(100);

	CSES_OUT_PARENT_COL15 CHAR(15);
	CSES_OUT_PARENT_COL16 VARCHAR(9); -- INTEGER;
	CSES_OUT_PARENT_COL17 VARCHAR(100);
	CSES_OUT_PARENT_COL18 CHAR(5);
	CSES_OUT_PARENT_COL19 CHAR(15);
	CSES_OUT_PARENT_COL20 CHAR(5);
	CSES_OUT_PARENT_COL21 VARCHAR(100);
	CSES_OUT_PARENT_COL22 CHAR(20);
	CSES_OUT_PARENT_COL23 VARCHAR(100);
	CSES_OUT_PARENT_COL24 VARCHAR(100);
	CSES_OUT_PARENT_COL25 VARCHAR(100);

	CSES_OUT_PARENT_COL26 VARCHAR(100);
	CSES_OUT_PARENT_COL27 VARCHAR(100);
	CSES_OUT_PARENT_COL28 CHAR(2);

	CSES_OUT_PARENT_COL29 date;

	CSES_OUT_PARENT_COL30 VARCHAR(100);
	CSES_OUT_PARENT_COL31 CHAR(3);
	CSES_OUT_PARENT_COL32 VARCHAR(9); -- INTEGER;
	CSES_OUT_PARENT_COL33 VARCHAR(100);
	CSES_OUT_PARENT_COL34 CHAR(5);
	CSES_OUT_PARENT_COL35 CHAR(3);
	CSES_OUT_PARENT_COL36 CHAR(5);
	CSES_OUT_PARENT_COL37 VARCHAR(100);
	CSES_OUT_PARENT_COL38 CHAR(2);
	CSES_OUT_PARENT_COL39 INTEGER;
	CSES_OUT_PARENT_COL40 VARCHAR(500);
	CSES_OUT_PARENT_COL41 INTEGER;

	CSES_OUT_PARENT_COL42 CHAR(5);
	CSES_OUT_PARENT_COL43 INTEGER;
	CSES_OUT_PARENT_COL44 INTEGER;
	CSES_OUT_PARENT_COL45 VARCHAR(100);

	CSES_OUT_PARENT_COL46 CHAR(1);
	CSES_OUT_PARENT_COL47 INTEGER;
	CSES_OUT_PARENT_COL48 INTEGER;
	CSES_OUT_PARENT_COL49 CHAR(5);

DECLARE CURSOR_PARENT CURSOR FOR
	SELECT DISTINCT act.person2id
		FROM actorrelationship act , person p
	WHERE act.person1id = p.personid
		AND p.cjamspid =  VL_CLIENT_ID
		AND   act.relationshiptypekey IN ('3447','3449','BGCHLD')
		AND   act.activeflag = 1;	

BEGIN
	--raise notice '1';
	VL_OUTPUT_SQLCODE := '00000';
	-- SET transaction sequence
	VS_TRANSACTION_SEQUENCE := LTRIM(RTRIM(CAST(VL_TRANSACTION_SEQUENCE AS VARCHAR))) ;

	-- Get CIS_CLIENT_ID
	BEGIN
		--raise notice '2';
		SELECT  person.cisclientid
			INTO VS_CIS_CLIENT_ID
		FROM person  	
		WHERE person.cjamspid = VL_CLIENT_ID
			AND person.activeflag  = 1;

		EXCEPTION WHEN OTHERS THEN
			VL_OUTPUT_SQLCODE  :=  SQLSTATE;
			VS_MESSAGE := 'SELECT CIS_CLIENT_ID FAILED FOR TB_CLIENT'|| SQLERRM  ;
			---- GOTO ERROR_SECTION ;
			RETURN;
    END ;
	
	--raise notice '2A';
	-- Generate records for record type 20
	VS_RECORD_TYPE := '20';
	VL_RECORD_SEQUENCE := 000 ;
	VS_RECORD_SEQUENCE := '';

	IF  VS_RECORD_TYPE = '20' THEN
		IF VS_TRANSACTION_TYPE_CD IN ('10','15','20','30','40','43','44','45','70') THEN  -- #12329
			CSES_OUT_PARENT_COL1 := 'X';
		ELSIF VS_TRANSACTION_TYPE_CD IN ('41') THEN
			CSES_OUT_PARENT_COL1 := 'N';
		ELSIF VS_TRANSACTION_TYPE_CD IN ('42')  THEN
			CSES_OUT_PARENT_COL1 := 'E';
		END IF ;

		OPEN CURSOR_PARENT;
		<<CURS_PARENT>>
		WHILE VL_OUTPUT_SQLCODE = '00000'  LOOP
			--raise notice 'pre1 3';
			FETCH CURSOR_PARENT INTO VL_PARENT_ID ;
			raise notice 'VL_PARENT_ID%', VL_PARENT_ID;
			EXIT CURS_PARENT WHEN NOT FOUND;
	   
			VL_RECORD_SEQUENCE := VL_RECORD_SEQUENCE + 1 ;
	
			VS_RECORD_SEQUENCE := LTRIM(RTRIM((VL_RECORD_SEQUENCE :: varchar)));
	
	
			IF VS_TRANSACTION_TYPE_CD IN ('10','15','20','30','40','43','44','45','70') THEN    -- #12329
				CSES_OUT_PARENT_COL1 := 'X';
			ELSIF VS_TRANSACTION_TYPE_CD IN ('41') THEN
			
				BEGIN
					--raise notice '3';
					SELECT  person2id
						INTO VL_NEW_PARENT_ID
					FROM actorrelationship act ,servicecase sc ,person p
					WHERE act.servicecaseid = sc.servicecaseid
						AND sc.servicecasenumber:: BIGINT = VL_OTHER_ID
						AND act.person1id  = p.personid
						AND P.CJAMSPID = VL_CLIENT_ID;

					EXCEPTION WHEN OTHERS THEN
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;
						VS_MESSAGE := 'SELECT  FAILED FOR NEW PARENT FOR actorrelationship'|| SQLERRM  ;
						 -- GOTO ERROR_SECTION ;
						RETURN;
				END;
	      

				IF VL_NEW_PARENT_ID = VL_PARENT_ID THEN
					CSES_OUT_PARENT_COL1 := 'N';
				ELSE
					CSES_OUT_PARENT_COL1 := 'X';
				END IF;
				/* ELSIF VS_TRANSACTION_TYPE_CD IN ('42')  THEN
					IF VL_OTHER_ID = VL_PARENT_ID THEN
						CSES_OUT_PARENT_COL1 := 'E';
					ELSE
						CSES_OUT_PARENT_COL1 := 'X';
					END IF; */  
			END IF ; 
			
			BEGIN
				--raise notice 'COL3-5';
				-- SELECT *
				-- INTO CSES_OUT_PARENT_COL3,CSES_OUT_PARENT_COL4, CSES_OUT_PARENT_COL5
				-- FROM 	(	select	irv.cheesiecode,
									-- CASE 	WHEN act.paternityestdflag = 1 THEN 'Y'
										-- WHEN act.paternityestdflag = 0 THEN  'N'
								-- ELSE ' '
								-- END ,
								-- TO_CHAR(act.paternityestddate,'yyyymmdd')::INTEGER	
						-- FROM 	actorrelationship act, 
								-- person p,
								-- interfacereferencevalues irv 
						-- WHERE 	act.person1id = p.personid
								-- and irv.desctypekey = act.relationshiptypekey
								-- and irv.referencetype = 'relations'
								-- and (irv.desclevel2typekey = 'MFU' or p.gendertypekey = irv.desclevel2typekey) 
								-- and act.relationshiptypekey in (	SELECT 	act.relationshiptypekey
																	-- FROM 	actorrelationship act, 
																			-- person p
																	-- where	act.person1id = p.personid
																			-- and p.cjamspid = VL_CLIENT_ID
																			-- AND act.person2id = VL_PARENT_ID
																			-- AND act.activeflag = 1
																		-- ORDER BY act.startdate desc) )AS A
				-- limit 1 ;			


				SELECT 	*
				INTO 	CSES_OUT_PARENT_COL3,CSES_OUT_PARENT_COL4, CSES_OUT_PARENT_COL5
				FROM    (  	select 	irv.cheesiecode,
							CASE 	WHEN act.paternityestdflag = 1 THEN 'Y'
									WHEN act.paternityestdflag = 0 THEN  'N'
									ELSE ' '
							END ,
							TO_CHAR(act.paternityestddate,'yyyymmdd')::INTEGER      
					FROM   	actorrelationship act, 
							person p,
							interfacereferencevalues irv 
					WHERE   act.person1id = p.personid 
							and p.personid = VL_PARENT_ID
							and irv.desctypekey = act.relationshiptypekey
							and irv.referencetype = 'relations'
							and (irv.desclevel2typekey = 'MFU' or p.gendertypekey = irv.desclevel2typekey) 
							and act.person2id =  ( 	SELECT  personid
													FROM    person p
													where 	p.cjamspid = VL_CLIENT_ID
															AND act.activeflag = 1 )  )AS A         
				limit 1    ;                                                                

		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT relationshiptypekey FAILED FOR actorrelationship'  || SQLERRM ;
					 -- GOTO ERROR_SECTION s
					RETURN;
			END ;

			BEGIN
				--raise notice 'COL2-6-7-14';	
				SELECT  p.cisclientid,
					COALESCE(substring(p.lastname, 1, 20),''),
					COALESCE(substring(p.firstname, 1, 20),''),
					COALESCE(substring(btrim(P.middlename), 1, 10),''),
					-- CIDM-2204
					substring((select value_text 
						from cjams.referencevalues rf  
					where rf.referencetypeid = 302
						and rf.activeflag = 1 
						and rf.value_text not in ('Ret.')
						and rf.ref_key = p.suffix ),1,5
					) as suffix,
					-- SUBSTRING(F_PLVALUE(p.suffix,214),1,5),
					( CASE WHEN gendertypekey = '1281' THEN 'F'	-- IF DATA COMES AS CHESSIE CODES
						WHEN gendertypekey = 'F' THEN 'F'
						WHEN gendertypekey = '1282' THEN 'M' -- IF DATA COMES AS CHESSIE CODES
						WHEN gendertypekey = 'M' THEN 'M'
						ELSE 'U' 
					END) as gendertypekey, 
					to_char(p.dob,'yyyymmdd')::INTEGER,
					( CASE WHEN p.racetypekey LIKE '%WH%' THEN '1806'
						WHEN  p.racetypekey LIKE '%AI%' THEN '1803'
						WHEN  p.racetypekey LIKE '%AN%' THEN '1802'
						WHEN  p.racetypekey LIKE '%BA%' THEN '1801'
						WHEN  p.racetypekey LIKE '%AS%' THEN '6310'
						WHEN  p.racetypekey LIKE '%PI%' THEN '6311'
						ELSE '6312'
					END ) as racetypekey
				INTO CSES_OUT_PARENT_COL2,
					CSES_OUT_PARENT_COL6,
					CSES_OUT_PARENT_COL7,
					CSES_OUT_PARENT_COL8,
					CSES_OUT_PARENT_COL9,
					CSES_OUT_PARENT_COL12,
					CSES_OUT_PARENT_COL13,
					CSES_OUT_PARENT_COL14
				FROM person p 
				WHERE  p.personid  = VL_PARENT_ID
					AND p.activeflag = 1;
	
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT  FAILED FOR PARENT FOR person'  || SQLERRM ;
					-- GOTO ERROR_SECTION ;
					RETURN;
	        END ;
			
			
	        ---GAYATHRI MAPPED DECLINED TO UNKNOWN - APRIL 14-2010
			IF LTRIM(RTRIM(CSES_OUT_PARENT_COL14))  = '6314' THEN
				CSES_OUT_PARENT_COL14 := '6312';
			END IF;
			
			SELECT ( CASE WHEN (pi.personidentifiervalue ~ '^([0-9]+[.]?[0-9]*|[.][0-9]+)$') = false then 
						NULL 
					 ELSE 
						pi.personidentifiervalue
					END )
				-- personidentifiervalue::varchar 
				INTO CSES_OUT_PARENT_COL11
			FROM person p , personidentifier pi
			WHERE  p.personid = pi.personid
				and pi.personidentifiertypekey = 'SSN'
				and p.personid = VL_PARENT_ID
				AND p.activeflag = 1
				AND pi.activeflag = 1 ;
					
			BEGIN
				--raise notice 'COL10';
				SELECT * 	
					INTO  CSES_OUT_PARENT_COL10
				FROM
				(SELECT COALESCE(substring(ali.lastname, 1, 20),'') 
				 FROM  alias ali, person p
				 WHERE ali.personid = p.personid
				 and p.personid = VL_PARENT_ID
				 AND ali.activeflag = 1
				 AND ali.akatypetypekey = 'Maiden'
				 ORDER BY ali.insertedon DESC) AS A
				 limit 1 ;

	
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT PARENT AKA FAILED FOR alias' || SQLERRM ;
					-- GOTO ERROR_SECTION ;
					RETURN;
			END ;	
			
			BEGIN
				--raise notice 'COL15-25';
				SELECT *
					INTO CSES_OUT_PARENT_COL15,
					CSES_OUT_PARENT_COL16,
					CSES_OUT_PARENT_COL17,
					CSES_OUT_PARENT_COL18,
					CSES_OUT_PARENT_COL19,
					CSES_OUT_PARENT_COL20,
					CSES_OUT_PARENT_COL21,
					CSES_OUT_PARENT_COL22,
					CSES_OUT_PARENT_COL23,
					CSES_OUT_PARENT_COL25
				FROM
		
				(SELECT SUBSTRING(F_PLVALUE(personaddress.adrpredirtypekey,69),1,3),
				   SUBSTRING(personaddress.personaddresstypekey,1,9), -- personaddress.ADR_STREET_NO
				   personaddress.address,
				   personaddress.adrstreetsuffixtypekey,
				   SUBSTRING(F_PLVALUE(personaddress.adrpostdirtypekey,69),1,3),
				   personaddress.adrunitno,
				   personaddress.city,
				   personaddress.state,
				   (SUBSTRING(COALESCE((personaddress.zipcode::VARCHAR),'00000'),1,5) || SUBSTRING(COALESCE((personaddress.adrzip4no::VARCHAR),'0000'),1,4))::INTEGER,
						  TO_CHAR(personaddress.personadrstartdate,'yyyymmdd')::INTEGER
					 FROM  personaddress 
						where    personid  = VL_PARENT_ID
						AND   personaddress.personadrstartdate IS NOT NULL
						AND   personaddress.personadrenddate IS NULL
						AND   personaddress.activeflag = 1
						ORDER BY personadrstartdate DESC) AS A
						limit 1 ;				
	   							
		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT CLIENT CURRENT ADDRESS FOR PARENT FAILED FOR personaddress' || SQLERRM ;
					-- GOTO ERROR_SECTION ;
					RETURN;
			END ; 								
		
			BEGIN		
				--raise notice 'COL24';
				SELECT *
					INTO  CSES_OUT_PARENT_COL24
				FROM
				(SELECT SUBSTRING(personphonenumber.phonenumber,1,10)
				 FROM personphonenumber, person 
				 WHERE  personphonenumber.personid =  person.personid
				and person.personid = VL_PARENT_ID
				AND personphonenumber.personphonetypekey IN ('1663','1664','1667','1672','P')
				 AND personphonenumber.effectivedate IS NOT NULL
				 AND personphonenumber.expirationdate IS NULL
				 AND personphonenumber.activeflag = 1
				 ORDER BY personphonenumber.effectivedate DESC) AS A
				 limit 1 ;
			
				EXCEPTION WHEN OTHERS THEN						
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT CLIENT CURRENT CONTACT INFO FOR PARENT FAILED FOR personphonenumber' || SQLERRM ;
				 -- GOTO ERROR_SECTION ;
				RETURN;
			END ; 							
		
			BEGIN
				--raise notice 'COL26-28';
				SELECT *
				INTO CSES_OUT_PARENT_COL26,
					 CSES_OUT_PARENT_COL27,
					 CSES_OUT_PARENT_COL28
					FROM	
				(SELECT clientunder5yearsinfo.hospitalname,
					   clientunder5yearsinfo.cityname,
						clientunder5yearsinfo.statetypekey
				 FROM clientunder5yearsinfo, person
				 WHERE clientunder5yearsinfo.personid = person.personid
				 and person.cjamspid = VL_CLIENT_ID
				 AND clientunder5yearsinfo.activeflag = 1
				 ORDER BY clientunder5yearsinfo.insertedon DESC, clientunder5yearsinfo.old_id DESC ) AS A
				 limit 1 ;
		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT CLIENT DETAILS FOR PARENT FAILED FOR clientunder5yearsinfo ' || SQLERRM ;
					 -- GOTO ERROR_SECTION 
					RETURN;
					
			END ; 	
		
			BEGIN
				--raise notice 'COL29';
				--SELECT to_char(p.dateofdeath, 'yyyymmdd')  -- Fix on 12042019
				SELECT p.dateofdeath
					INTO CSES_OUT_PARENT_COL29   
				FROM person p
				WHERE p.personid = VL_PARENT_ID
				AND  p.activeflag = 1 ;
		
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT CLIENT DEATH DETAILS FOR PARENT FAILED FOR person' || SQLERRM  ;
					 -- GOTO ERROR_SECTION ;
					RETURN;
			END ; 	
		
			BEGIN
				--raise notice 'COL30-41';
				SELECT *
					INTO CSES_OUT_PARENT_COL30,
					CSES_OUT_PARENT_COL31,
					CSES_OUT_PARENT_COL32,
					CSES_OUT_PARENT_COL33,
					CSES_OUT_PARENT_COL34,
					CSES_OUT_PARENT_COL35,
					CSES_OUT_PARENT_COL36,
					CSES_OUT_PARENT_COL37,
					CSES_OUT_PARENT_COL38,
					CSES_OUT_PARENT_COL39,
					CSES_OUT_PARENT_COL40,
					CSES_OUT_PARENT_COL41
				FROM
				(SELECT personemployment.employername,
				   SUBSTRING(F_PLVALUE(personemployment.predirtypekey,69),1,3),
				   SUBSTRING(personemployment.streetnotes,1,9), -- TB_CLIENT_EMPLOYMENT.ADR_STREET_NO
				   personemployment.streetname,
				   personemployment.streetsuffixtypekey,
				   SUBSTRING(F_PLVALUE(personemployment.postdirtypekey,69),1,3),
				   personemployment.unitnumbertx,
				   personemployment.cityname,
				   personemployment.statetypekey,
				   (SUBSTRING(COALESCE((personemployment.zip5no::VARCHAR),'00000'),1,5)||SUBSTRING(COALESCE((personemployment.zip4no::VARCHAR),'0000'),1,4))::INTEGER,
				   -- CIDM-2204
				   -- personemployment.workphone,
				   (case when personemployment.workphone::character varying like '[{%' then   
						(personemployment.workphone::json -> 0 ->> lower('phoneNumber'))::character varying
					else		
						personemployment.workphone::character varying
					end ) as workphone,
				   TO_CHAR(personemployment.enddate,'yyyymmdd')::INTEGER  	
				FROM personemployment, person 
				WHERE personemployment.personid = person.personid 
					AND person.personid = VL_PARENT_ID
					AND  personemployment.activeflag = 1
					AND personemployment.startdate IS NOT NULL
				ORDER BY personemployment.startdate DESC) AS A
				limit 1 ;
				
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT CURRENT EMPLOYMENT DETAILS FOR PARENT FAILED FOR personemployment'|| SQLERRM;
					 -- GOTO ERROR_SECTION ;
					RETURN;
				
			END ;
			
			BEGIN
				--raise notice 'COL42-45';
				SELECT *
				INTO CSES_OUT_PARENT_COL42,
					 CSES_OUT_PARENT_COL43,
					 CSES_OUT_PARENT_COL44,
					 CSES_OUT_PARENT_COL45
				FROM
				(SELECT  CASE WHEN statustypekey = '99' THEN '7791'
							WHEN UPPER(statustypekey) = 'DV' THEN '1568'
							WHEN UPPER(statustypekey) = 'LS' THEN '1570'
							WHEN UPPER(statustypekey) = 'MR' THEN '1569'
							WHEN UPPER(statustypekey) = 'SG' THEN '1571'
							WHEN UPPER(statustypekey) = 'UK' THEN '7791'
							WHEN UPPER(statustypekey) = 'WD' THEN '3673'
							ELSE ' '
					END ,
					TO_CHAR(CMS.startdate,'yyyymmdd')::INTEGER,
					TO_CHAR(CMS.enddate,'yyyymmdd')::INTEGER  ,
						divorceplace 
					FROM personmaritalstatus CMS, person p
				WHERE CMS.personid = p.personid
					and p.personid = VL_PARENT_ID
					--   AND CMS.statustypekey = '1569'
					AND CMS.activeflag = 1
				ORDER BY CMS.startdate DESC) AS A
				limit 1 ;      					
						
				EXCEPTION WHEN OTHERS THEN			
				VL_OUTPUT_SQLCODE  :=  SQLSTATE;
				VS_MESSAGE := 'SELECT MARRIAGE INFO FOR PARENT FAILED FOR TB_CLIENT_MARITAL_STATUS'  || SQLERRM ;
				-- GOTO ERROR_SECTION ;
				RETURN;
			END ;   	
		
			BEGIN
				--raise notice 'COL47-49';
				SELECT *
				INTO CSES_OUT_PARENT_COL47,
				CSES_OUT_PARENT_COL48,
				CSES_OUT_PARENT_COL49
				FROM
				(SELECT TO_CHAR(pms.startdate,'yyyymmdd')::INTEGER ,
					 TO_CHAR(pms.enddate,'yyyymmdd')::INTEGER   ,
					(	CASE WHEN branchkey = 'UAF' THEN '1586' -- US Air Force
							WHEN branchkey = 'UA' THEN '1587' -- US Army
							WHEN branchkey = 'UCG' THEN '1588' -- US Coast Guard
							WHEN branchkey = 'UM' THEN '1589' -- US Marines
							WHEN branchkey = 'UN' THEN '1590' -- US Navy
							WHEN branchkey = 'NG' THEN '7824' -- National Guard
							ELSE NULL
						END 
					) as branchkey
				FROM personmilitaryservices pms, person p
				WHERE  pms.personid = p.personid
				and p.personid = VL_PARENT_ID
				AND p.activeflag = 1
				ORDER BY pms.startdate DESC) AS A
				limit 1 ;
				
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT PARENT DETAILS FOR PARENT FAILED FOR TB_CLIENT_MILITARY_SERVICES' || SQLERRM ;
					-- GOTO ERROR_SECTION ;
					RETURN;
			END ;
		
			BEGIN
				--raise notice 'COL46';
				SELECT ( CASE WHEN COUNT(*) > 0 THEN
							'Y'
						 ELSE 
							'N'
						END )
					INTO CSES_OUT_PARENT_COL46
				FROM personhealthinsurance phlt, 
					person pr
				WHERE phlt.personid = pr.personid 
					and pr.cjamspid = VL_CLIENT_ID
					and btrim(lower(phlt.policyholdername)) 
						=  btrim((select lower(pr1.firstname || ' ' || pr1.lastname) 
								from person pr1 
							where pr1.personid = VL_PARENT_ID 
								and pr1.activeflag = 1
							))
					and phlt.activeflag = 1
					and phlt.insurancetype <> 'HOWN'  -- 1371 - Homeowners Insurance
					and phlt.caresauno IS NULL 
					and phlt.effectivedate IS NOT NULL  
					and ( phlt.expirationdate IS NULL OR phlt.expirationdate > phlt.effectivedate );
				
				/*
					SELECT  CASE WHEN COUNT(*) > 0 THEN 'Y'
						ELSE 'N'
						END
					INTO    CSES_OUT_PARENT_COL46
					FROM    personinsurance, person
					WHERE   personinsurance.personinsuranceid =  VL_PARENT_ID
					and    person.cjamspid =  VL_CLIENT_ID
					AND     personinsurance.activeflag = 1
					AND     personinsurance.typekey <> '1371'
					AND     personinsurance.startdate IS NOT NULL
					AND     (personinsurance.enddate IS NULL
					OR      personinsurance.enddate > personinsurance.startdate);
				*/
				
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'SELECT  FAILED FOR personhealthinsurance'  || SQLERRM ;
					-- GOTO ERROR_SECTION ;
					RETURN;
			END ; 	
			
				/* 	
			raise notice 'inserting';
			raise notice 'VS_CIS_CLIENT_ID%',VS_CIS_CLIENT_ID;
			raise notice 'CSES_OUT_PARENT_COL2%', CSES_OUT_PARENT_COL2;
			raise notice 'CSES_OUT_PARENT_COL11%', CSES_OUT_PARENT_COL11 ;
			raise notice 'CSES_OUT_PARENT_COL23%', CSES_OUT_PARENT_COL23 ;
			raise notice 'CSES_OUT_PARENT_COL39%', CSES_OUT_PARENT_COL39 ;
				 */
				 
			-- Set Interface Data
			BEGIN
				-- CIDM-2204	
				IF CSES_OUT_PARENT_COL40 is null or btrim(CSES_OUT_PARENT_COL40) = '' THEN
					CSES_OUT_PARENT_COL40 :=  '0000000000';
				END IF;		

			
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
					csesoutcol17,
					csesoutcol18,
					csesoutcol19,
					csesoutcol20,
					csesoutcol21,
					csesoutcol22,
					csesoutcol23,
					csesoutcol24,
					csesoutcol25,
					csesoutcol26,
					csesoutcol27,
					csesoutcol28,
					csesoutcol29,
					csesoutcol30,
					csesoutcol31,
					csesoutcol32,
					csesoutcol33,
					csesoutcol34,
					csesoutcol35,
					csesoutcol36,
					csesoutcol37,
					csesoutcol38,
					csesoutcol39,
					csesoutcol40,
					csesoutcol41,
					csesoutcol42,
					csesoutcol43,
					csesoutcol44,
					csesoutcol45,
					csesoutcol46,
					csesoutcol47,
					csesoutcol48,
					csesoutcol49
				)	
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
					COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)),'000000000'),
					'20',
					VD_TRANSACTION_TS,
					CASE WHEN LENGTH(VS_RECORD_SEQUENCE) = 1 THEN '00'||VS_RECORD_SEQUENCE
						 WHEN LENGTH(VS_RECORD_SEQUENCE) = 2 THEN '0'||VS_RECORD_SEQUENCE
						 WHEN LENGTH(VS_RECORD_SEQUENCE) = 3 THEN VS_RECORD_SEQUENCE::varchar
						 END,
					CSES_OUT_PARENT_COL1,
					COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(CSES_OUT_PARENT_COL2)))) || LTRIM(RTRIM(CSES_OUT_PARENT_COL2)),'000000000'),
					CSES_OUT_PARENT_COL3,
					CSES_OUT_PARENT_COL4,
					COALESCE(cast(CSES_OUT_PARENT_COL5 as varchar),'00000000'),
					CSES_OUT_PARENT_COL6,
					CSES_OUT_PARENT_COL7,
					CSES_OUT_PARENT_COL8,
					CSES_OUT_PARENT_COL9,
					CSES_OUT_PARENT_COL10,
					COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(cast(CSES_OUT_PARENT_COL11 as varchar))))) || LTRIM(RTRIM(cast(CSES_OUT_PARENT_COL11 as varchar))),'000000000'),
					CSES_OUT_PARENT_COL12,
					COALESCE(cast(CSES_OUT_PARENT_COL13 as varchar ),'00000000'),
					CSES_OUT_PARENT_COL14,
					CSES_OUT_PARENT_COL15,
					CSES_OUT_PARENT_COL16,
					CSES_OUT_PARENT_COL17,
					CSES_OUT_PARENT_COL18,
					CSES_OUT_PARENT_COL19,
					CSES_OUT_PARENT_COL20,
					CSES_OUT_PARENT_COL21,
					CSES_OUT_PARENT_COL22,
					CASE WHEN CSES_OUT_PARENT_COL23 = '0' THEN '000000000'
						 WHEN CSES_OUT_PARENT_COL23 IS NULL THEN '000000000'
						 ELSE SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(cast(CSES_OUT_PARENT_COL23 as varchar))))) || LTRIM(RTRIM(cast(CSES_OUT_PARENT_COL23 as varchar)))
					END,
					COALESCE(cast(CSES_OUT_PARENT_COL24 as varchar),'0000000000'),
					COALESCE(cast(CSES_OUT_PARENT_COL25 as varchar),'00000000'),
					CSES_OUT_PARENT_COL26,
					CSES_OUT_PARENT_COL27,
					CSES_OUT_PARENT_COL28,
					--COALESCE(cast(CSES_OUT_PARENT_COL29 as varchar),'00000000'),
					COALESCE(to_char(CSES_OUT_PARENT_COL29, 'yyyymmdd'),'00000000'),	--12042019 Fix bad format
					CSES_OUT_PARENT_COL30,
					CSES_OUT_PARENT_COL31,
					CSES_OUT_PARENT_COL32,
					CSES_OUT_PARENT_COL33,
					CSES_OUT_PARENT_COL34,
					CSES_OUT_PARENT_COL35,
					CSES_OUT_PARENT_COL36,
					CSES_OUT_PARENT_COL37,
					CSES_OUT_PARENT_COL38,
					CASE WHEN CSES_OUT_PARENT_COL39 = '0' THEN '000000000'
						 WHEN CSES_OUT_PARENT_COL39  IS NULL THEN '000000000'
						 ELSE SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(cast(CSES_OUT_PARENT_COL39 as varchar))))) || LTRIM(RTRIM(cast(CSES_OUT_PARENT_COL39 as varchar)))
					END,
				    -- COALESCE(cast(CSES_OUT_PARENT_COL40 as varchar),'0000000000'),
					-- CIDM-2204
					-- COALESCE(right ( regexp_replace(CSES_OUT_PARENT_COL40::varchar, '[- ]+','')::varchar, 10),'0000000000'), 
					CSES_OUT_PARENT_COL40,
					COALESCE(cast(CSES_OUT_PARENT_COL41 as varchar),'00000000'),
					CSES_OUT_PARENT_COL42,
					COALESCE(cast(CSES_OUT_PARENT_COL43 as varchar),'00000000'),
					COALESCE(cast(CSES_OUT_PARENT_COL44 as varchar),'00000000'),
					CSES_OUT_PARENT_COL45,
					CSES_OUT_PARENT_COL46,
					COALESCE(cast(CSES_OUT_PARENT_COL47 as varchar),'00000000'),
					COALESCE(cast(CSES_OUT_PARENT_COL48 as varchar),'00000000'),
					CSES_OUT_PARENT_COL49;
				--  FROM sysibm.sysdummy1 ;		
			   
				raise notice 'inserted';
				VL_PARENT_ID := NULL;
				VL_NEW_PARENT_ID := NULL;
				VL_PARENT_EMPLOYMENT_ID := NULL;
				CSES_OUT_PARENT_COL1 :=  NULL;
				CSES_OUT_PARENT_COL2  := NULL;
				CSES_OUT_PARENT_COL3 := NULL;
				CSES_OUT_PARENT_COL4  := NULL;
				CSES_OUT_PARENT_COL5  := NULL;
				CSES_OUT_PARENT_COL6  := NULL;
				CSES_OUT_PARENT_COL7  := NULL;
				CSES_OUT_PARENT_COL8  := NULL;
				CSES_OUT_PARENT_COL9  := NULL;
				CSES_OUT_PARENT_COL10  := NULL;
				CSES_OUT_PARENT_COL11  := NULL;
				CSES_OUT_PARENT_COL12  := NULL;
				VD_CLIENT_DOB := NULL;
				CSES_OUT_PARENT_COL13  := NULL;
				CSES_OUT_PARENT_COL14  := NULL;
				CSES_OUT_PARENT_COL15  := NULL;
				CSES_OUT_PARENT_COL16  := NULL ;
				CSES_OUT_PARENT_COL17  := NULL;
				CSES_OUT_PARENT_COL18  := NULL;
				CSES_OUT_PARENT_COL19 := NULL;
				CSES_OUT_PARENT_COL20 := NULL;
				CSES_OUT_PARENT_COL21 := NULL;
				CSES_OUT_PARENT_COL22 := NULL;
				CSES_OUT_PARENT_COL23 := NULL;
				CSES_OUT_PARENT_COL24 := NULL;
				CSES_OUT_PARENT_COL25 := NULL;
				CSES_OUT_PARENT_COL26 := NULL;
				CSES_OUT_PARENT_COL27 := NULL;
				CSES_OUT_PARENT_COL28 := NULL;
				CSES_OUT_PARENT_COL29 := NULL;
				CSES_OUT_PARENT_COL30 := NULL;
				CSES_OUT_PARENT_COL31 := NULL;
				CSES_OUT_PARENT_COL32 := NULL;
				CSES_OUT_PARENT_COL33 := NULL;
				CSES_OUT_PARENT_COL34 := NULL;
				CSES_OUT_PARENT_COL35 := NULL;
				CSES_OUT_PARENT_COL36 := NULL;
				CSES_OUT_PARENT_COL37 := NULL;
				CSES_OUT_PARENT_COL38 := NULL;
				CSES_OUT_PARENT_COL39 := NULL;
				CSES_OUT_PARENT_COL40 := NULL;

				CSES_OUT_PARENT_COL41 := NULL;
				CSES_OUT_PARENT_COL42  := NULL;

				CSES_OUT_PARENT_COL43 := NULL;
				CSES_OUT_PARENT_COL44 := NULL;
				CSES_OUT_PARENT_COL45 := NULL;
				CSES_OUT_PARENT_COL46 := NULL;

				CSES_OUT_PARENT_COL47 := NULL;
				CSES_OUT_PARENT_COL48 := NULL;
				CSES_OUT_PARENT_COL49 := NULL;
				 
				EXCEPTION WHEN OTHERS THEN
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;
					VS_MESSAGE := 'TABLE INSERT FAILED FOR TB_CSES_OUTBOUND_INTERFACE' || SQLERRM ;
					-- GOTO ERROR_SECTION ;
					RETURN;
			END;
			--raise notice 'INSERTED DATA_20';
		END LOOP;
		CLOSE CURSOR_PARENT;
    END IF ;
	
	VS_MESSAGE := 'Procedure ran succesfully';
	RETURN  ;
	
END ;
  $function$
;
