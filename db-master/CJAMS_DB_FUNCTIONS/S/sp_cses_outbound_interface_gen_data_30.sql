CREATE OR REPLACE FUNCTION cjams.sp_cses_outbound_interface_gen_data_30(vl_client_id integer, vl_other_id bigint, vs_transaction_type_cd character varying, vl_transaction_sequence integer, vd_transaction_ts timestamp without time zone, OUT vs_message character varying, OUT vl_output_sqlcode character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Benny||Ruban||Ram
-- Date Created :08/01/2005
-- modified :05-06-2019
-- generates Cares Interface Outbound Data
-- #12329 02/16/07 - sandhya - added distinct to fetch unique records in cursor select 
------------------------------------------------------------------------
 

DECLARE
  
    VS_RECORD_TYPE VARCHAR(2);
    VS_OUTPUT_STATE VARCHAR(5) DEFAULT '00000';
    VL_RECORD_SEQUENCE INTEGER DEFAULT 000;
    VS_TRANSACTION_SEQUENCE VARCHAR(5);
    VS_RECORD_SEQUENCE VARCHAR(3);
    -- Client Variables
    VS_CIS_CLIENT_ID VARCHAR(10);      --  CARES_OUT_COL6
    VL_COURT_HEARING_ID uuid;
    CSES_OUT_CINA_COL1  INTEGER;
    CSES_OUT_CINA_COL2 CHAR(2);
    CSES_OUT_CINA_COL3 CHAR(5);
    CSES_OUT_CINA_COL4 CHAR(5);
    CSES_OUT_CINA_COL5 CHAR(5);
    CSES_OUT_CINA_COL6 CHAR(5);
    CSES_OUT_CINA_COL7 CHAR(5);
    VL_COURT_ORD_PKLIST_ID_1 INTEGER;
    VL_COURT_ORD_PKLIST_ID_2 INTEGER;
    VL_COURT_ORD_PKLIST_ID_3 INTEGER;
    VL_COURT_ORD_PKLIST_ID_4 INTEGER;
    VL_COURT_ORD_PKLIST_ID_5 INTEGER;
    VL_COURT_ORDER_ID uuid;
	
	
	
	DECLARE CURSOR_CINA  CURSOR FOR	
   /*  select 
	 distinct itch.intakeservicerequestcourthearingid COURT_HEARING_ID
		from (select trim(value_tx)value_tx,delete_sw,description_tx from tb_picklist_values 
				where Trim(picklist_value_cd):: character varying in('1310','3931','1311','6253','7331') 
				and picklist_type_id=95
				and 
				delete_sw='N')pick,
			 hearingtype ht ,
			 Intakeservicerequestcourthearing itch,
			 intakeservreqpetitionhearingconfig itcg,  			 
			 intakeservicerequestpetition itp,
			 intakeservicerequestpetitionactor itpa,
		 	 intakeservicerequestactor ita,
		 	 actor a,
		 	 person p
	where   pick.value_tx=trim(ht.description)
		 	and trim(ht.hearingtypekey)=trim(itch.hearingtypekey)
	  		and ht.activeflag=1
	  		and itch.activeflag=1
	  		and itcg.activeflag=1
	  		and itch.intakeservicerequestcourthearingid=itcg.intakeservicerequestcourthearingid	  	  	      
		 	and itcg.intakeservicerequestpetitionid=itp.intakeservicerequestpetitionid 
	 	  	and itp.intakeservicerequestpetitionid=itpa.intakeservicerequestpetitionid 
	   	  	and itpa.intakeservicerequestactorid=ita.intakeservicerequestactorid
  		  	and ita.actorid=a.actorid
		 	and a.personid=p.personid 
		  	and p.cjamspid=VL_CLIENT_ID
		    and itp.activeflag=1 and itpa.activeflag=1 and ita.activeflag=1 and  p.activeflag=1 ; */
			
			
		 		
	Select 	distinct itch.intakeservicerequestcourthearingid COURT_HEARING_ID
	
	from 	(select trim(value_tx)value_tx,delete_sw,description_tx from tb_picklist_values 
				where Trim(picklist_value_cd):: character varying in('1310','3931','1311','6253','7331') 
				and picklist_type_id=95
				and 
				delete_sw='N')pick
			join hearingtype ht  on pick.value_tx=trim(ht.description)
			join Intakeservicerequestcourthearing itch on itch.hearingtype ? ht.hearingtypekey
			join hearingclients hc on  itch.intakeservicerequestcourthearingid = hc.courthearingid
			join person pr on pr.personid = hc.personid and pr.cjamspid = VL_CLIENT_ID
	where 	ht.activeflag=1
	  		and itch.activeflag=1
	  		and pr.activeflag=1;--
	
BEGIN

	VL_OUTPUT_SQLCODE := '00000'; 
    -- SET transaction sequence
    VS_TRANSACTION_SEQUENCE := LTRIM(RTRIM(CAST(VL_TRANSACTION_SEQUENCE AS VARCHAR))) ;--

	BEGIN
			-- Get CIS_CLIENT_ID
			SELECT  person.cisclientid
			INTO    VS_CIS_CLIENT_ID
			FROM    person  	
			WHERE   person.cjamspid =  VL_CLIENT_ID
			AND     person.activeflag = 1;--
			
			EXCEPTION WHEN OTHERS THEN
			 VL_OUTPUT_SQLCODE  :=  SQLSTATE;
			 VS_MESSAGE := 'SELECT CIS_CLIENT_ID FAILED FOR PERSON '  || SQLERRM  ;
			 RETURN;
			   -- GOTO ERROR_SECTION ;--
    END ;
    -- Generate records for record type 30
 	
    VS_RECORD_TYPE := '30'; 	
    VL_RECORD_SEQUENCE := 000 ;
    VS_RECORD_SEQUENCE := '';

    IF  VS_RECORD_TYPE = '30' THEN
	
	raise notice 'VS_RECORD_TYPE=30';
	raise notice '%',VS_RECORD_TYPE;

        OPEN CURSOR_CINA;
        <<CURS_CINA>>
        WHILE VL_OUTPUT_SQLCODE = '00000'  LOOP
            FETCH CURSOR_CINA INTO VL_COURT_HEARING_ID ;
            
            EXIT CURS_CINA WHEN NOT FOUND;           

			VL_RECORD_SEQUENCE := VL_RECORD_SEQUENCE + 1 ;	
			VS_RECORD_SEQUENCE := LTRIM(RTRIM((VL_RECORD_SEQUENCE ::VARCHAR)));
		
	begin
		raise notice 'CURSOR LOOPS %',VL_COURT_HEARING_ID;
		--CSES_OUT_CINA_COL1, CSES_OUT_CINA_COL2
        select
			to_char(itch.hearingdatetime::DATE, 'YYYYMMDD') HEARING_DT, 
			-- SUBSTRING(to_char(itch.hearingdatetime,'dd-mm-yyyy HH12:MI:SS'),7,4)||
			-- SUBSTRING(to_char(itch.hearingdatetime,'dd-mm-yyyy HH12:MI:SS'),1,2)||
			-- SUBSTRING(to_char(itch.hearingdatetime,'dd-mm-yyyy HH12:MI:SS'),4,2) HEARING_DT,
			--TO_CHAR(itch.hearingdatetime,'yyyymmdd')::INTEGER,
			CASE 
				 WHEN pick.picklist_value_cd = '1310' THEN 'AD'
				 WHEN pick.picklist_value_cd = '3931' THEN 'CI'
				 WHEN pick.picklist_value_cd = '1311' THEN 'DI'
				 WHEN pick.picklist_value_cd = '6253' THEN 'MH'
				 WHEN pick.picklist_value_cd = '7331' THEN 'CC'
			END PICKLIST_VALUE	
			INTO CSES_OUT_CINA_COL1, CSES_OUT_CINA_COL2
		from (select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd from tb_picklist_values 
				where trim(picklist_value_cd)::character varying in('1310','3931','1311','6253','7331') 
				and picklist_type_id=95
				and delete_sw='N')pick
			 join hearingtype ht on TRIM(pick.value_tx)=TRIM(ht.description)
			 join Intakeservicerequestcourthearing itch on itch.hearingtype ? TRIM(ht.hearingtypekey)  
		 where ht.activeflag=1
	      and itch.activeflag=1
		  and itch.intakeservicerequestcourthearingid=VL_COURT_HEARING_ID	
	  	  and pick.picklist_type_id=(select max(pick.picklist_type_id)
									from (select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd from tb_picklist_values 
											where trim(picklist_value_cd)::character varying in('1310','3931','1311','6253','7331') 
											and picklist_type_id=95
											and delete_sw='N')pick
										 join hearingtype ht on TRIM(pick.value_tx)=TRIM(ht.description)
										 join Intakeservicerequestcourthearing itch on itch.hearingtype ? TRIM(ht.hearingtypekey)  
									 where 
									  ht.activeflag=1
									  and itch.activeflag=1
									  and itch.intakeservicerequestcourthearingid=VL_COURT_HEARING_ID);

         EXCEPTION WHEN OTHERS THEN
	     VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
	     VS_MESSAGE := 'SELECT  FAILED FOR TB_COURT_HEARINGS '  || SQLERRM  ;--
		 RETURN;
	        -- GOTO ERROR_SECTION ;--
	    END ;--
	BEGIN
		-- CSES_OUT_CINA_COL3, VL_COURT_ORD_PKLIST_ID_1 , VL_COURT_ORDER_ID
	    select 	(rv.ref_key) COURT_ORDER_PICKLIST_ID,
				plv.picklist_value_cd PICKLIST_VALUE_CD,
				itc.intakeservreqcourtorderid COURT_ORDER_ID
				INTO  CSES_OUT_CINA_COL3, VL_COURT_ORD_PKLIST_ID_1 , VL_COURT_ORDER_ID
		from 	
			referencetype rt,
			referencevalues rv,
			intakeservreqcohearingoutcome ich,
			intakeservreqcourtorder itc,
			(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
				from tb_picklist_values tp, hearingtype ht
				where 
				TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv,		
			Intakeservicerequestcourthearing itch
		where  	
			rt.referencetypeid=rv.referencetypeid
			and (rt.referencetypeid=94 and rv.activeflag=1)
			and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
			and ich.activeflag=1
			and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
			and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid		
			and itc.intakeservicerequesthearingid=VL_COURT_HEARING_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb'
			and TRIM(plv.hearingtypekey)=TRIM(itch.hearingtypekey)
			and itc.activeflag=1
			and itch.activeflag=1
			and plv.picklist_value_cd= (select max(plv.picklist_value_cd)picklist_value_cd	
									from 	referencetype rt,
											referencevalues rv,
											intakeservreqcohearingoutcome ich,
											intakeservreqcourtorder itc,
											Intakeservicerequestcourthearing itch,
											(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
												from tb_picklist_values tp, hearingtype ht
												where 
												TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv
									where  	rt.referencetypeid=rv.referencetypeid
											and (rt.referencetypeid=94 and rv.activeflag=1)
											and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
											and ich.activeflag=1
											and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
											and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid									
											and itc.intakeservicerequesthearingid=VL_COURT_HEARING_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb'
											and trim(plv.hearingtypekey)=trim(itch.hearingtypekey) 
											and itc.activeflag=1
											and itch.activeflag=1
										);							   
											
	
	     EXCEPTION WHEN OTHERS THEN
	     VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
	        VS_MESSAGE := 'SELECT DISPOSITION 1 FAILED FOR TB_COURT_ORDER '  || SQLERRM  ;--
			RETURN;
	        -- GOTO ERROR_SECTION ;--
	    END ;  	--
	BEGIN
--CSES_OUT_CINA_COL4, VL_COURT_ORD_PKLIST_ID_2
	   select 	(rv.ref_key) COURT_ORDER_PICKLIST_ID,
				plv.picklist_value_cd PICKLIST_VALUE_CD
				INTO  CSES_OUT_CINA_COL4, VL_COURT_ORD_PKLIST_ID_2
		from 	
			referencetype rt,
			referencevalues rv,
			intakeservreqcohearingoutcome ich,
			intakeservreqcourtorder itc,
			(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
				from tb_picklist_values tp, hearingtype ht
				where 
				TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv,		
			Intakeservicerequestcourthearing itch
		where  	
			rt.referencetypeid=rv.referencetypeid
			and (rt.referencetypeid=94 and rv.activeflag=1)
			and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
			and ich.activeflag=1
			and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
			and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid		
			and itc.intakeservicerequesthearingid=VL_COURT_ORDER_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb'  e219d1a1-e9ef-49b4-84ca-47ea3627c289
			and TRIM(plv.hearingtypekey)=TRIM(itch.hearingtypekey)
			and itc.activeflag=1
			and itch.activeflag=1
			and plv.picklist_value_cd= (select max(plv.picklist_value_cd)picklist_value_cd		
									from 	referencetype rt,
											referencevalues rv,
											intakeservreqcohearingoutcome ich,
											intakeservreqcourtorder itc,
											Intakeservicerequestcourthearing itch,
											(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
												from tb_picklist_values tp, hearingtype ht
												where 
												TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv
									where  	rt.referencetypeid=rv.referencetypeid
											and (rt.referencetypeid=94 and rv.activeflag=1)
											and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
											and ich.activeflag=1
											and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
											and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid									
											and itc.intakeservicerequesthearingid=VL_COURT_ORDER_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb' e219d1a1-e9ef-49b4-84ca-47ea3627c289
											and trim(plv.hearingtypekey)=trim(itch.hearingtypekey) 
											and itc.activeflag=1
											and itch.activeflag=1
											and plv.picklist_value_cd::INTEGER < VL_COURT_ORD_PKLIST_ID_1
										);	
	
	     EXCEPTION WHEN OTHERS THEN
	     VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
	     VS_MESSAGE := 'SELECT DISPOSITION 2 FAILED FOR TB_COURT_ORDER ' || SQLERRM   ;--
		 RETURN;
	        -- GOTO ERROR_SECTION ;--
	    END ; 	--
	BEGIN
		 --CSES_OUT_CINA_COL5, VL_COURT_ORD_PKLIST_ID_3
	     select (rv.ref_key) COURT_ORDER_PICKLIST_ID,
				plv.picklist_value_cd PICKLIST_VALUE_CD
				INTO  CSES_OUT_CINA_COL5, VL_COURT_ORD_PKLIST_ID_3
		from 	
			referencetype rt,
			referencevalues rv,
			intakeservreqcohearingoutcome ich,
			intakeservreqcourtorder itc,
			(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
				from tb_picklist_values tp, hearingtype ht
				where 
				TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv,		
			Intakeservicerequestcourthearing itch
		where  	
			rt.referencetypeid=rv.referencetypeid
			and (rt.referencetypeid=94 and rv.activeflag=1)
			and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
			and ich.activeflag=1
			and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
			and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid		
			and itc.intakeservicerequesthearingid=VL_COURT_ORDER_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb'
			and TRIM(plv.hearingtypekey)=TRIM(itch.hearingtypekey)
			and itc.activeflag=1
			and itch.activeflag=1
			and plv.picklist_value_cd= (select max(plv.picklist_value_cd)picklist_value_cd		
									from 	referencetype rt,
											referencevalues rv,
											intakeservreqcohearingoutcome ich,
											intakeservreqcourtorder itc,
											Intakeservicerequestcourthearing itch,
											(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
												from tb_picklist_values tp, hearingtype ht
												where 
												TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv
									where  	rt.referencetypeid=rv.referencetypeid
											and (rt.referencetypeid=94 and rv.activeflag=1)
											and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
											and ich.activeflag=1
											and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
											and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid									
											and itc.intakeservicerequesthearingid=VL_COURT_ORDER_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb' e219d1a1-e9ef-49b4-84ca-47ea3627c289
											and trim(plv.hearingtypekey)=trim(itch.hearingtypekey) 
											and itc.activeflag=1
											and itch.activeflag=1
											and plv.picklist_value_cd::INTEGER < VL_COURT_ORD_PKLIST_ID_2
										);	
	
	     EXCEPTION WHEN OTHERS THEN
	     VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
	     VS_MESSAGE := 'SELECT DISPOSITION 3 FAILED FOR TB_COURT_ORDER '  || SQLERRM  ;--
		 RETURN;
	        -- GOTO ERROR_SECTION ;--
	    END ;--
	BEGIN
		-- CSES_OUT_CINA_COL6, VL_COURT_ORD_PKLIST_ID_4
	    select (rv.ref_key) COURT_ORDER_PICKLIST_ID,
				plv.picklist_value_cd PICKLIST_VALUE_CD
				INTO  CSES_OUT_CINA_COL6, VL_COURT_ORD_PKLIST_ID_4
		from 	
			referencetype rt,
			referencevalues rv,
			intakeservreqcohearingoutcome ich,
			intakeservreqcourtorder itc,
			(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
				from tb_picklist_values tp, hearingtype ht
				where 
				TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv,		
			Intakeservicerequestcourthearing itch
		where  	
			rt.referencetypeid=rv.referencetypeid
			and (rt.referencetypeid=94 and rv.activeflag=1)
			and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
			and ich.activeflag=1
			and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
			and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid		
			and itc.intakeservicerequesthearingid=VL_COURT_ORDER_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb'
			and TRIM(plv.hearingtypekey)=TRIM(itch.hearingtypekey)
			and itc.activeflag=1
			and itch.activeflag=1
			and plv.picklist_value_cd= (select max(plv.picklist_value_cd)picklist_value_cd		
									from 	referencetype rt,
											referencevalues rv,
											intakeservreqcohearingoutcome ich,
											intakeservreqcourtorder itc,
											Intakeservicerequestcourthearing itch,
											(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
												from tb_picklist_values tp, hearingtype ht
												where 
												TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv
									where  	rt.referencetypeid=rv.referencetypeid
											and (rt.referencetypeid=94 and rv.activeflag=1)
											and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
											and ich.activeflag=1
											and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
											and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid									
											and itc.intakeservicerequesthearingid=VL_COURT_ORDER_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb' e219d1a1-e9ef-49b4-84ca-47ea3627c289
											and trim(plv.hearingtypekey)=trim(itch.hearingtypekey) 
											and itc.activeflag=1
											and itch.activeflag=1
											and plv.picklist_value_cd::INTEGER < VL_COURT_ORD_PKLIST_ID_3
										);	
	     
		 EXCEPTION WHEN OTHERS THEN
	     VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
	        VS_MESSAGE := 'SELECT DISPOSITION 4 FAILED FOR TB_COURT_ORDER '   || SQLERRM ;--
			RETURN;
	        -- GOTO ERROR_SECTION ;--
	    END ;--
	BEGIN
		-- CSES_OUT_CINA_COL7, VL_COURT_ORD_PKLIST_ID_5 
	    select (rv.ref_key) COURT_ORDER_PICKLIST_ID,
				plv.picklist_value_cd PICKLIST_VALUE_CD
				INTO  CSES_OUT_CINA_COL7, VL_COURT_ORD_PKLIST_ID_5 
		from 	
			referencetype rt,
			referencevalues rv,
			intakeservreqcohearingoutcome ich,
			intakeservreqcourtorder itc,
			(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
				from tb_picklist_values tp, hearingtype ht
				where 
				TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv,		
			Intakeservicerequestcourthearing itch
		where  	
			rt.referencetypeid=rv.referencetypeid
			and (rt.referencetypeid=94 and rv.activeflag=1)
			and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
			and ich.activeflag=1
			and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
			and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid		
			and itc.intakeservicerequesthearingid=VL_COURT_ORDER_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb'
			and TRIM(plv.hearingtypekey)=TRIM(itch.hearingtypekey)
			and itc.activeflag=1
			and itch.activeflag=1
			and plv.picklist_value_cd= (select max(plv.picklist_value_cd)picklist_value_cd		
									from 	referencetype rt,
											referencevalues rv,
											intakeservreqcohearingoutcome ich,
											intakeservreqcourtorder itc,
											Intakeservicerequestcourthearing itch,
											(select value_tx,delete_sw,description_tx,picklist_type_id,picklist_value_cd,hearingtypekey
												from tb_picklist_values tp, hearingtype ht
												where 
												TRIM(tp.value_tx)=TRIM(ht.description) and delete_sw='N' and ht.activeflag=1)plv
									where  	rt.referencetypeid=rv.referencetypeid
											and (rt.referencetypeid=94 and rv.activeflag=1)
											and trim(ich.hearingoutcometypekey)=trim(rv.ref_key)
											and ich.activeflag=1
											and ich.intakeservreqcourtorderid=itc.intakeservreqcourtorderid
											and itc.intakeservicerequesthearingid=itch.intakeservicerequestcourthearingid									
											and itc.intakeservicerequesthearingid=VL_COURT_ORDER_ID --'a870d895-cb7d-4af3-a51d-ead5d00ec8bb' e219d1a1-e9ef-49b4-84ca-47ea3627c289
											and trim(plv.hearingtypekey)=trim(itch.hearingtypekey) 
											and itc.activeflag=1
											and itch.activeflag=1
											and plv.picklist_value_cd::INTEGER < VL_COURT_ORD_PKLIST_ID_4
										);	
		EXCEPTION WHEN OTHERS THEN
	     VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
	        VS_MESSAGE := 'SELECT DISPOSITION 5 FAILED FOR TB_COURT_ORDER '  || SQLERRM  ;--
			RETURN;
	        -- GOTO ERROR_SECTION ;--
	    END ; 	--
	BEGIN
	    -- Set Interface Data
		raise notice 'INSERT INTO csesoutboundinterface';
	    INSERT INTO csesoutboundinterface
					(	csesoutboundinterfaceid,
						statustypekey,
						transactionseqno,
						transactiontypekey,
						cisclientid,
						recordtypekey,
						transactionon,
						recordseqno,
						CSESOUTCOL1,
						CSESOUTCOL2,
						CSESOUTCOL3,
						CSESOUTCOL4,
						CSESOUTCOL5,
						CSESOUTCOL6,
						CSESOUTCOL7
					)		
	    SELECT
		NEXTVAL ('SQ_CSES_OUTBOUND_INTERFACE'),
		'000',
		CASE WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 1 THEN '0000'||VS_TRANSACTION_SEQUENCE
		     WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 2 THEN '000'||VS_TRANSACTION_SEQUENCE
		     WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 3 THEN '00'||VS_TRANSACTION_SEQUENCE
		     WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 4 THEN '0'||VS_TRANSACTION_SEQUENCE
		     WHEN LENGTH(VS_TRANSACTION_SEQUENCE) = 5 THEN VS_TRANSACTION_SEQUENCE
		     END,
		VS_TRANSACTION_TYPE_CD,
		COALESCE(SUBSTRING('000000000',1,9 - LENGTH(LTRIM(RTRIM(VS_CIS_CLIENT_ID)))) || LTRIM(RTRIM(VS_CIS_CLIENT_ID)),'000000000'),
		'30',
		VD_TRANSACTION_TS,
		CASE WHEN LENGTH(VS_RECORD_SEQUENCE) = 1 THEN '00'||VS_RECORD_SEQUENCE
		     WHEN LENGTH(VS_RECORD_SEQUENCE) = 2 THEN '0'||VS_RECORD_SEQUENCE
		     WHEN LENGTH(VS_RECORD_SEQUENCE) = 3 THEN VS_RECORD_SEQUENCE
		     END,
		COALESCE((CSES_OUT_CINA_COL1 :: varchar),'00000000'),
				CSES_OUT_CINA_COL2,
                CSES_OUT_CINA_COL3,
                CSES_OUT_CINA_COL4,
                CSES_OUT_CINA_COL5,
                CSES_OUT_CINA_COL6,
                CSES_OUT_CINA_COL7;
           --  FROM sysibm.sysdummy1 ;		--
	
				 CSES_OUT_CINA_COL1 := NULL;--
				 CSES_OUT_CINA_COL2 := NULL;--
				 CSES_OUT_CINA_COL3 := NULL;--
				 CSES_OUT_CINA_COL4 := NULL;--
				 CSES_OUT_CINA_COL5 := NULL;--
				 CSES_OUT_CINA_COL6 := NULL;--
				 CSES_OUT_CINA_COL7 := NULL;--

				 VL_COURT_ORD_PKLIST_ID_1 := NULL;--
				 VL_COURT_ORD_PKLIST_ID_2 := NULL;--
				 VL_COURT_ORD_PKLIST_ID_3 := NULL;--
				 VL_COURT_ORD_PKLIST_ID_4 := NULL;--
				 VL_COURT_ORD_PKLIST_ID_5 := NULL;--
				 VL_COURT_ORDER_ID := NULL;--
			 
	 EXCEPTION WHEN OTHERS THEN
        VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
	    VS_MESSAGE := 'TABLE INSERT 30 FAILED FOR TB_CSES_OUTBOUND_INTERFACE ' || SQLERRM  ;--
		RETURN;
	    -- GOTO ERROR_SECTION ;--
		RETURN;
       END ;--
raise notice 'INSERTED DATA_30';	
  END LOOP;
 CLOSE CURSOR_CINA;--
	   
 END IF;--
  VS_MESSAGE:= 'Procedure ran sucessfully';
  RETURN  ;--
	
END;
$function$;
