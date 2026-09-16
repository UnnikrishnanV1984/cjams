CREATE OR REPLACE FUNCTION cjams.f_afcars_encrypt_cjams(vs_entity_id character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created :02/25/2021 2:47 PM

-- To Encrypt the Case/Client/User IDs for Federal Reporting
-- This Procedure is for Entity IDs with length > 9  

-- Revision(s):
-- 01/05/2022 - Vineet Tirodkar - Commented RAISE NOTICEs for Log file size issue (CIDM-4132)
------------------------------------------------------------------------
Declare VL_ENCRYPT_ENTITY_ID VARCHAR(12);
Declare LS_STEP1NO  VARCHAR (14) default null;
Declare LS_STEP2NO  VARCHAR (14) default null;
Declare LS_FINALENCRPT VARCHAR (14) DEFAULT null;

Declare VENNO1  Integer default 0;
Declare VENNO2  Integer default 0;
Declare VENNO3  Integer default 0;
Declare VENNO4  Integer default 0;
Declare VENNO5  Integer default 0;
Declare VENNO6  Integer default 0;
Declare VENNO7  Integer default 0;
Declare VENNO8  Integer default 0;
Declare VENNO9  Integer default 0;
Declare VENNO10 Integer default 0;
Declare VENNO11 Integer default 0;
Declare VENNO12 Integer default 0;

Declare VENN12  Integer default 0;
Declare VENN22  Integer default 0;
Declare VENN32  Integer default 0;
Declare VENN42  Integer default 0;
Declare VENN52  Integer default 0;
Declare VENN62  Integer default 0;
Declare VENN72  Integer default 0;
Declare VENN82  Integer default 0;
Declare VENN92  Integer default 0;
Declare VENN102 Integer default 0;
Declare VENN112 Integer default 0;
Declare VENN122 Integer default 0;

Declare Uven1   VARCHAR (2) default '0';
Declare Uven2   VARCHAR (2) default '0';
Declare Uven3   VARCHAR (2) default '0';
Declare Uven4   VARCHAR (2) default '0';
Declare Uven5   VARCHAR (2) default '0';
Declare Uven6   VARCHAR (2) default '0';
Declare Uven7   VARCHAR (2) default '0';
Declare Uven8   VARCHAR (2) default '0';
Declare Uven9   VARCHAR (2) default '0';
Declare Uven10  VARCHAR (2) default '0';
Declare Uven11  VARCHAR (2) default '0';
Declare Uven12  VARCHAR (2) default '0';

Declare WENNO1  Integer default 0;
Declare WENNO2  Integer default 0;
Declare WENNO3  Integer default 0;
Declare WENNO4  Integer default 0;
Declare WENNO5  Integer default 0;
Declare WENNO6  Integer default 0;
Declare WENNO7  Integer default 0;
Declare WENNO8  Integer default 0;
Declare WENNO9  Integer default 0;
Declare WENNO10 Integer default 0;
Declare WENNO11 Integer default 0;
Declare WENNO12 Integer default 0;

Declare WENN12  Integer default 0;
Declare WENN22  Integer default 0;
Declare WENN32  Integer default 0;
Declare WENN42  Integer default 0;
Declare WENN52  Integer default 0;
Declare WENN62  Integer default 0;
Declare WENN72  Integer default 0;
Declare WENN82  Integer default 0;
Declare WENN92  Integer default 0;
Declare WENN102 Integer default 0;
Declare WENN112 Integer default 0;
Declare WENN122 Integer default 0;

Declare UWen1   VARCHAR (2) default '0';
Declare UWen2   VARCHAR (2) default '0';
Declare UWen3   VARCHAR (2) default '0';
Declare UWen4   VARCHAR (2) default '0';
Declare UWen5   VARCHAR (2) default '0';
Declare UWen6   VARCHAR (2) default '0';
Declare UWen7   VARCHAR (2) default '0';
Declare UWen8   VARCHAR (2) default '0';
Declare UWen9   VARCHAR (2) default '0';
Declare UWen10  VARCHAR (2) default '0';
Declare UWen11  VARCHAR (2) default '0';
Declare UWen12  VARCHAR (2) default '0';
	
BEGIN
    -- RAISE NOTICE 'INPUT %', vs_entity_id;
              
	IF vs_entity_id IS NULL OR vs_entity_id = '' THEN 
		LS_STEP1NO = '999' || '000000000';
	ELSE
		LS_STEP1NO := 
			(case when length(vs_entity_id) > 12 then
				substring(vs_entity_id, (length(vs_entity_id) - 12) + 1 ) 
			 else	
				vs_entity_id
			 end);
		
		LS_STEP1NO := lpad(LS_STEP1NO,12,'9');	
	END IF;
	-- RAISE NOTICE 'LS_STEP1NO INPUT %', LS_STEP1NO;
 
    --- ****  1st ENCRYPTION **** ---
	
	-- STEP #1 : SEPERATE EACH NUMBER
	VENNO1 = CAST(SUBSTRING(LS_STEP1NO,1,1) AS INT);
	VENNO2 = CAST(SUBSTRING(LS_STEP1NO,2,1) AS INT);
	VENNO3 = CAST(SUBSTRING(LS_STEP1NO,3,1) AS INT);
	VENNO4 = CAST(SUBSTRING(LS_STEP1NO,4,1) AS INT);
	VENNO5 = CAST(SUBSTRING(LS_STEP1NO,5,1) AS INT);
	VENNO6 = CAST(SUBSTRING(LS_STEP1NO,6,1) AS INT);
	VENNO7 = CAST(SUBSTRING(LS_STEP1NO,7,1) AS INT);
	VENNO8 = CAST(SUBSTRING(LS_STEP1NO,8,1) AS INT);
	VENNO9 = CAST(SUBSTRING(LS_STEP1NO,9,1) AS INT);
	VENNO10 = CAST(SUBSTRING(LS_STEP1NO,10,1) AS INT);
	VENNO11 = CAST(SUBSTRING(LS_STEP1NO,11,1) AS INT);
	VENNO12 = CAST(SUBSTRING(LS_STEP1NO,12,1) AS INT);

	-- STEP #2 : MATHEMATICAL OPERATIONS ON THE ABOVE SEPERATED NOS.
	venn12 := venno1 + 9;           -- 1st #
	venn22 := venno2 - 2;           -- 2nd #
	venn32 := venno3 - 6;           -- 3rd #
	venn42 := venno4 - 5;           -- 4th #
	venn52 := venno5 - 3;           -- 5th #
	venn62 := venno6 - 4;           -- 6th #
	venn72 := venno7 - 5;           -- 7th #
	venn82 := venno8 + 8;           -- 8th #
	venn92 := venno9 - 2;           -- 9th #
	venn102 := venno10 + 9;          -- 10th #
	venn112 := venno11 - 2;          -- 11th #
	venn122 := venno12 - 6;          -- 12th #

	-- STEP #3 : IF THE RESULT NUMBER IN STEP #2 IS >10 OR <0 THEN SUBTRACT 10 AND ADD 10 RESPECTIVELY.
	-- 1st #
	IF Venn12 < 0 Then       
		Uven1 := CAST((Venn12 + 10) AS VARCHAR);
	Elsif Venn12 > 9 Then   
		Uven1 := CAST((Venn12 - 10) AS VARCHAR);
	Elsif Venn12 >= 0 AND Venn12 <= 9 Then  
		Uven1 := CAST(Venn12 AS VARCHAR);
	End if;

	-- 2nd #
	IF Venn22 < 0 Then       
		Uven2 := CAST((Venn22 + 10) AS VARCHAR);
	Elsif Venn22 > 9 Then   
		Uven2 := CAST((Venn22 - 10) AS VARCHAR);
	Elsif Venn22 >= 0 AND Venn22 <= 9 Then  
		Uven2 := CAST(Venn22 AS VARCHAR);
	End if;

	-- 3rd #
	IF Venn32 < 0 Then       
		Uven3 := CAST((Venn32 + 10) AS VARCHAR);
	Elsif Venn32 > 9 Then   
		Uven3 := CAST((Venn32 - 10) AS VARCHAR);
	Elsif Venn32 >= 0 AND Venn32 <= 9 Then  
		Uven3 := CAST(Venn32 AS VARCHAR);
	End if;
                             
	-- 4th #
	IF Venn42 < 0 Then       
		Uven4 := CAST((Venn42 + 10) AS VARCHAR);
	Elsif Venn42 > 9 Then   
		Uven4 := CAST((Venn42 - 10) AS VARCHAR);
	Elsif Venn42 >= 0 AND Venn42 <= 9 Then  
		Uven4 := CAST(Venn42 AS VARCHAR);
	End if;

	-- 5th #
	IF Venn52 < 0 Then       
		Uven5 := CAST((Venn52 + 10) AS VARCHAR);
	Elsif Venn52 > 9 Then   
		Uven5 := CAST((Venn52 - 10) AS VARCHAR);
	Elsif Venn52 >= 0 AND Venn52 <= 9 Then  
		Uven5 := CAST(Venn52 AS VARCHAR);
	End if;

	-- 6th #
	IF Venn62 < 0 Then       
		Uven6 := CAST((Venn62 + 10) AS VARCHAR);
	Elsif Venn62 > 9 Then   
		Uven6 := CAST((Venn62 - 10) AS VARCHAR);
	Elsif Venn62 >= 0 AND Venn62 <= 9 Then  
		Uven6 := CAST(Venn62 AS VARCHAR);
	End if;

	-- 7th #
	IF Venn72 < 0 Then       
		Uven7 := CAST((Venn72 + 10) AS VARCHAR);
	Elsif Venn72 > 9 Then   
		Uven7 := CAST((Venn72 - 10) AS VARCHAR);
	Elsif Venn72 >= 0 AND Venn72 <= 9 Then  
		Uven7 := CAST(Venn72 AS VARCHAR);
	End if;

	-- 8th #
	IF Venn82 < 0 Then       
		Uven8 := CAST((Venn82 + 10) AS VARCHAR);
	Elsif Venn82 > 9 Then   
		Uven8 := CAST((Venn82 - 10) AS VARCHAR);
	Elsif Venn82 >= 0 AND Venn82 <= 9 Then  
		Uven8 := CAST(Venn82 AS VARCHAR);
	End if;

	-- 9th #
	IF Venn92 < 0 Then       
		Uven9 := CAST((Venn92 + 10) AS VARCHAR);
	Elsif Venn92 > 9 Then   
		Uven9 := CAST((Venn92 - 10) AS VARCHAR);
	Elsif Venn92 >= 0 AND Venn92 <= 9 Then  
		Uven9 := CAST(Venn92 AS VARCHAR);
	End if;
	
	-- 10th #
	IF venn102 < 0 Then       
		Uven10 := CAST((venn102 + 10) AS VARCHAR);
	Elsif venn102 > 9 Then   
		Uven10 := CAST((venn102 - 10) AS VARCHAR);
	Elsif venn102 >= 0 AND venn102 <= 9 Then  
		Uven10 := CAST(venn102 AS VARCHAR);
	End if;

	-- 11th #
	IF venn112 < 0 Then       
		Uven11 := CAST((venn112 + 10) AS VARCHAR);
	Elsif venn112 > 9 Then   
		Uven11 := CAST((venn112 - 10) AS VARCHAR);
	Elsif venn112 >= 0 AND venn112 <= 9 Then  
		Uven11 := CAST(venn112 AS VARCHAR);
	End if;

	-- 12th #
	IF venn122 < 0 Then       
		Uven12 := CAST((venn122 + 10) AS VARCHAR);
	Elsif venn122 > 9 Then   
		Uven12 := CAST((venn122 - 10) AS VARCHAR);
	Elsif venn122 >= 0 AND venn122 <= 9 Then  
		Uven12 := CAST(venn122 AS VARCHAR);
	End if;

	LS_STEP2NO = Ltrim(rtrim(UVEN1)) || Ltrim(rtrim(UVEN2)) || Ltrim(rtrim(UVEN3)) || Ltrim(rtrim(UVEN4)) ||
    Ltrim(rtrim(UVEN5)) || Ltrim(rtrim(UVEN6)) || Ltrim(rtrim(UVEN7)) || Ltrim(rtrim(UVEN8)) || Ltrim(rtrim(UVEN9)) ||
	Ltrim(rtrim(UVEN10)) || Ltrim(rtrim(UVEN11)) || Ltrim(rtrim(UVEN12));

	-- RAISE NOTICE 'LS_STEP2NO INPUT %', LS_STEP2NO;
    --====================================================================================

	--- ****  2nd ENCRYPTION **** ---

	-- STEP #1 : SEPERATE EACH NUMBER
	WENNO1 = CAST(SUBSTRING(LS_STEP2NO,1,1) AS INT);
	WENNO2 = CAST(SUBSTRING(LS_STEP2NO,2,1) AS INT);
	WENNO3 = CAST(SUBSTRING(LS_STEP2NO,3,1) AS INT);
	WENNO4 = CAST(SUBSTRING(LS_STEP2NO,4,1) AS INT);
	WENNO5 = CAST(SUBSTRING(LS_STEP2NO,5,1) AS INT);
	WENNO6 = CAST(SUBSTRING(LS_STEP2NO,6,1) AS INT);
	WENNO7 = CAST(SUBSTRING(LS_STEP2NO,7,1) AS INT);
	WENNO8 = CAST(SUBSTRING(LS_STEP2NO,8,1) AS INT);
	WENNO9 = CAST(SUBSTRING(LS_STEP2NO,9,1) AS INT);
	WENNO10 = CAST(SUBSTRING(LS_STEP2NO,10,1) AS INT);
	WENNO11 = CAST(SUBSTRING(LS_STEP2NO,11,1) AS INT);
	WENNO12 = CAST(SUBSTRING(LS_STEP2NO,12,1) AS INT);

	-- STEP #2 : MATHEMATICAL OPERATIONS ON THE ABOVE SEPERATED NOS.
	WENN12 := Wenno1 - 5;           -- 1st #
	WENN22 := Wenno2 + 7;           -- 2nd #
	WENN32 := Wenno3 - 7;           -- 3rd #
	WENN42 := Wenno4 - 3;           -- 4th #
	WENN52 := Wenno5 + 6;           -- 5th #
	WENN62 := Wenno6 + 3;           -- 6th #
	WENN72 := Wenno7 + 3;           -- 7th #
	WENN82 := Wenno8 - 3;           -- 8th #
	WENN92 := Wenno9 + 0;           -- 9th #
	WENN102 := Wenno10 - 5;         -- 10th #
	WENN112 := Wenno11 + 7;         -- 11th #
	WENN122 := Wenno12 - 7;         -- 12th #

	-- STEP #3 : IF THE RESULT NUMBER IN STEP #2 IS >10 OR <0 THEN SUBTRACT 10 AND ADD 10 RESPECTIVELY.
	-- 1st #
	IF Wenn12 < 0 Then
		UWen1 := CAST((Wenn12 + 10) AS VARCHAR);
	Elsif Wenn12 > 9 Then
		UWen1 := CAST((Wenn12 - 10) AS VARCHAR);
	Elsif Wenn12 >= 0 AND Wenn12 <= 9 Then
		UWen1 := CAST(Wenn12 AS VARCHAR);
	End if;

	-- 2nd #
	IF Wenn22 < 0 Then
		UWen2 := CAST((Wenn22 + 10) AS VARCHAR);
	Elsif Wenn22 > 9 Then
		UWen2 := CAST((Wenn22 - 10) AS VARCHAR);
	Elsif Wenn22 >= 0 AND Wenn22 <= 9 Then
		UWen2 := CAST(Wenn22 AS VARCHAR);
	End if;

	IF Wenn32 < 0 Then
		UWen3 := CAST((Wenn32 + 10) AS VARCHAR);
	Elsif Wenn32 > 9 Then
		UWen3 := CAST((Wenn32 - 10) AS VARCHAR);
	Elsif Wenn32 >= 0 AND Wenn32 <= 9 Then
		UWen3 := CAST(Wenn32 AS VARCHAR);
	End if;

	-- 4th #
	IF Wenn42 < 0 Then
		UWen4 := CAST((Wenn42 + 10) AS VARCHAR);
	Elsif Wenn42 > 9 Then
		UWen4 := CAST((Wenn42 - 10) AS VARCHAR);
	Elsif Wenn42 >= 0 AND Wenn42 <= 9 Then
		UWen4 := CAST(Wenn42 AS VARCHAR);
	End if;

	-- 5th #
	IF Wenn52 < 0 Then
		UWen5 := CAST((Wenn52 + 10) AS VARCHAR);
	Elsif Wenn52 > 9 Then
		UWen5 := CAST((Wenn52 - 10) AS VARCHAR);
	Elsif Wenn52 >= 0 AND Wenn52 <= 9 Then
		UWen5 := CAST(Wenn52 AS VARCHAR);
	End if;

	-- 6th #
	IF Wenn62 < 0 Then
		UWen6 := CAST((Wenn62 + 10) AS VARCHAR);
	Elsif Wenn62 > 9 Then
		UWen6 := CAST((Wenn62 - 10) AS VARCHAR);
	Elsif Wenn62 >= 0 AND Wenn62 <= 9 Then
		UWen6 := CAST(Wenn62 AS VARCHAR);
	End if;

	-- 7th #
	IF Wenn72 < 0 Then
		UWen7 := CAST((Wenn72 + 10) AS VARCHAR);
	Elsif Wenn72 > 9 Then
		UWen7 := CAST((Wenn72 - 10) AS VARCHAR);
	Elsif Wenn72 >= 0 AND Wenn72 <= 9 Then
		UWen7 := CAST(Wenn72 AS VARCHAR);
	End if;
                             
	-- 8th #
	IF Wenn82 < 0 Then
		UWen8 := CAST((Wenn82 + 10) AS VARCHAR);
	Elsif Wenn82 > 9 Then
		UWen8 := CAST((Wenn82 - 10) AS VARCHAR);
	Elsif Wenn82 >= 0 AND Wenn82 <= 9 Then
		UWen8 := CAST(Wenn82 AS VARCHAR);
	End if;

	-- 9th #
	IF Wenn92 < 0 Then
		UWen9 := CAST((Wenn92 + 10) AS VARCHAR);
	Elsif Wenn92 > 9 Then
		UWen9 := CAST((Wenn92 - 10) AS VARCHAR);
	Elsif Wenn92 >= 0 AND Wenn92 <= 9 Then
		UWen9 := CAST(Wenn92 AS VARCHAR);
	End if;

	-- 10th #
	IF wenn102 < 0 Then
		UWen10 := CAST((wenn102 + 10) AS VARCHAR);
	Elsif wenn102 > 9 Then
		UWen10 := CAST((wenn102 - 10) AS VARCHAR);
	Elsif wenn102 >= 0 AND wenn102 <= 9 Then
		UWen10 := CAST(wenn102 AS VARCHAR);
	End if;

	-- 11th #
	IF wenn112 < 0 Then
		UWen11 := CAST((wenn112 + 10) AS VARCHAR);
	Elsif wenn112 > 9 Then
		UWen11 := CAST((wenn112 - 10) AS VARCHAR);
	Elsif wenn112 >= 0 AND wenn112 <= 9 Then
		UWen11 := CAST(wenn112 AS VARCHAR);
	End if;
	
	-- 12th #
	IF wenn122 < 0 Then
		UWen12 := CAST((wenn122 + 10) AS VARCHAR);
	Elsif wenn122 > 9 Then
		UWen12 := CAST((wenn122 - 10) AS VARCHAR);
	Elsif wenn122 >= 0 AND wenn122 <= 9 Then
		UWen12 := CAST(wenn122 AS VARCHAR);
	End if;
	
	LS_FINALENCRPT = Ltrim(rtrim(UWEN1)) || Ltrim(rtrim(UWEN2)) || Ltrim(rtrim(UWEN3)) || Ltrim(rtrim(UWEN4)) ||
	Ltrim(rtrim(UWEN5)) || Ltrim(rtrim(UWEN6)) || Ltrim(rtrim(UWEN7)) || Ltrim(rtrim(UWEN8)) || Ltrim(rtrim(UWEN9)) || 
	Ltrim(rtrim(UWEN10)) || Ltrim(rtrim(UWEN11)) || Ltrim(rtrim(UWEN12)) ;

	-- RAISE NOTICE 'LS_FINALENCRPT  %', LS_FINALENCRPT;

	VL_ENCRYPT_ENTITY_ID = LS_FINALENCRPT;
	
	RETURN VL_ENCRYPT_ENTITY_ID;
END;

$function$
;
