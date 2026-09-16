-- FUNCTION: cjams.sp_acc_trans_rs_insert(character varying, numeric, bigint, bigint, date, date, date)

 DROP FUNCTION if exists cjams.sp_acc_trans_rs_insert(character varying, numeric, bigint, bigint, date, date, date);

CREATE OR REPLACE FUNCTION cjams.sp_acc_trans_rs_insert(
	as_trans_cd character varying,
	adc_amount numeric,
	al_payment_detail_id bigint,
	al_client_account_id bigint,
	al_benefit_start_dt date,
	al_benefit_end_dt date,
	ad_run_dt date,
	OUT al_sqlcode integer,
	OUT as_error character varying)
    RETURNS record
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Gayathri Rajkumar
-- Date of creation : '2009-05-14'
-- To create  Account transactions for restamping.

-- Revision(s)
-- 10/07/2022 - Vineet Tirodkar - To char fix for Aurora DB migration 
------------------------------------------------------------------------
--P1: BEGIN

DECLARE SQLCODE INT DEFAULT 0;--
DECLARE v_sqlcode int DEFAULT 0;--
DECLARE SQLSTATE CHAR(5) DEFAULT '00000';--
DECLARE vs_message_text VARCHAR(3000) DEFAULT '';--
DECLARE vs_Procedure_nm VARCHAR(100) DEFAULT 'SP_ACC_TRANS_RS_INSERT';--
DECLARE vs_NOTES_TX VARCHAR(500) ;--
--DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
  begin
	EXCEPTION WHEN OTHERS THEN
   -- GET DIAGNOSTICS EXCEPTION 1 vs_message_text =  MESSAGE_TEXT;--
   	GET STACKED DIAGNOSTICS vs_message_text :=  MESSAGE_TEXT;

     v_sqlcode := -1 ;--
     as_error := COALESCE(as_error ,'') || (CURRENT_TIMESTAMP::text) ||'::' || vs_Procedure_nm || '.' ;--
     as_error := COALESCE(as_error ,'') || '::RO ' || 'Client Account ID/ Payment Detail ID' || ' :: ' || COALESCE((al_client_account_id)::character varying,'') || '/ ' || COALESCE((al_payment_detail_id)::character varying,'');--
     as_error := as_error || COALESCE(vs_message_text ,'');
	--as_error:='';
END;--

    vs_NOTES_TX := 'Payment Re-Stamping' ;--
   IF As_TRANS_CD = '587' THEN -- SSI
       vs_NOTES_TX := vs_NOTES_TX || ' (SSI).'; 	--
   ELSEIF As_TRANS_CD = '586' THEN -- SSA
       vs_NOTES_TX := vs_NOTES_TX || ' (SSA).'; 	--
   ELSEIF As_TRANS_CD = '585' THEN -- Other (Cost Of Care)
       vs_NOTES_TX := vs_NOTES_TX || ' (Other [Cost Of Care]).'; 	--
   END IF;--

	   INSERT INTO
	       TB_ACCOUNT_TRANSACTION
	       (
		  TRANSACTION_ID,                  CLIENT_ACCOUNT_ID,
		  TRANSACTION_TYPE_CD,             TRANSACTION_SOURCE_CD,
		  BENEFIT_START_DT,                BENEFIT_END_DT,
		  TRANSACTION_AMOUNT_NO,           TRANSACTION_DT,
		  CREDIT_DEBIT_SW,                 NOTES_TX,
		  CREATE_TS,                       FREQUENCY_CD,
		  CREATE_USER_ID,                  UPDATE_TS,
		  UPDATE_USER_ID,                  DELETE_SW,
		  PAYMENT_DETAIL_ID
	       )
		VALUES
	       (
		 NEXTVAL('SQ_ACCOUNT_TRANSACTION'),          AL_CLIENT_ACCOUNT_ID,
		  '3444',                          '5477',
		  al_benefit_start_dt,      al_benefit_end_dt,
		  Adc_AMOUNT ,                      CURRENT_DATE,
		  'D',                             vs_NOTES_TX,
		  CURRENT_TIMESTAMP,               NULL,
		  'finance',                       CURRENT_TIMESTAMP,
		  'finance',                       'N',
		  AL_PAYMENT_DETAIL_ID
	       );--

       -- as_scource_cd hard coded as '5477'

        al_sqlcode := SQLCODE;--
       IF al_sqlcode <> 0  THEN
           as_error := 'Error in inserting Account Transaction record';--
       END IF ;--

END;

$BODY$;

