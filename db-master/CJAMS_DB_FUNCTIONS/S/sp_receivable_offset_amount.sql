CREATE OR REPLACE FUNCTION cjams.sp_receivable_offset_amount(	al_offset_amt numeric, 
																al_provider_id bigint, 
																al_payment_id bigint, 
																OUT al_sqlcode integer
															)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Stored Procedure to Offset Amount against the Fostercare Payments

-- Revision(s)
-- 03/12/2021 Vineet Tirodkar - Modifications to update the audit columns of AR tables (CDM-8396)
------------------------------------------------------------------------
-- Declare variables
DECLARE sqlcode_tmp INT DEFAULT 0;
	vd_total_receivable decimal(10,2);
	vl_row_cnt INT DEFAULT 0;
	vl_counter INT DEFAULT 0;
	vs_collection_status_cd CHAR(5);
	vl_array_cnt INT DEFAULT 0;
	vd_collected_amt decimal(10,2);
	vd_receivable_bal_amt decimal(10,2);
	vl_rcvbl_liquidation_id BIGINT DEFAULT 0;
	vl_receivable_detail_id INT DEFAULT 0;
	vl_payment_detail_id INT DEFAULT 0;
	vl_receivable_id BIGINT DEFAULT 0;
	vd_amount_no decimal(10,2);
	vd_receivable_balance_no decimal(10,2);
	vs_approval_status_cd CHAR(5);
	vs_payment_method_cd CHAR(5);
	vs_rcvbl_liquidation_id VARCHAR(40) DEFAULT 'RCVBL_LIQUIDATION_ID';
	vs_sq_name VARCHAR(40) DEFAULT 'sq_receivable_liquidation';
	--DECLARE not_found CONDITION FOR SQLSTATE '02000';--
	vs_sq_name1 VARCHAR(40) DEFAULT 'sq_receivable_offset';
	vl_offset_id BIGINT DEFAULT 0;
	vs_sq_off VARCHAR(40) DEFAULT 'OFF';
	vl_transaction_amt decimal(10,2);
	vl_sqlcode INT DEFAULT 0;
	DECLARE SQLCODE INTEGER DEFAULT 0;

-- Declare a CURSOR
DECLARE cursor_detail CURSOR FOR
	SELECT A.RECEIVABLE_DETAIL_ID,
		A.PAYMENT_DETAIL_ID,
		A.RECEIVABLE_ID,
		A.AMOUNT_NO,
		A.RECEIVABLE_BALANCE_NO,
		A.APPROVAL_STATUS_CD
	FROM tb_RECEIVABLE_DETAIL A,
		tb_RECEIVABLE_HEADER B,
		tb_PAYMENT_DETAIL C
	WHERE A.RECEIVABLE_ID = B.RECEIVABLE_ID
		AND A.PAYMENT_DETAIL_ID = C.PAYMENT_DETAIL_ID
		AND A.DELETE_SW = 'N'
		AND B.DELETE_SW = 'N'
		AND C.DELETE_SW = 'N'     
		AND ((A.MANUAL_SW = 'N')
		OR 
		(A.MANUAL_SW = 'Y' AND A.APPROVAL_STATUS_CD = '3047')
		)
		AND B.PROVIDER_ID = al_provider_id
		AND C.SUBSIDY_AGREEMENT_ID IS NULL -- Excluding A/R for GAP & Adoption Subsidy 
	ORDER BY A.RECEIVABLE_DETAIL_ID ;
 
BEGIN      

	vl_transaction_amt := al_offset_amt;  
    
	-- Insert Into tb_RECEIVABLE_OFFSET
	-- Generate Key ID
	-- CALL CHESSIE_MASK_FIN.sp_nextid( vs_sq_name1,vl_offset_id ); -- generating new id
	SELECT SP_nextid(vs_sq_name1::character varying) into vl_offset_id;

	IF vl_offset_id <> -1 THEN
		INSERT INTO tb_RECEIVABLE_OFFSET
			(	OFFSET_ID,
				OFFSET_DT,
				OFFSET_AMOUNT_NO,
				PAYMENT_ID,
				CREATE_TS,
				CREATE_USER_ID,
				UPDATE_TS,
				UPDATE_USER_ID,
				DELETE_SW 
			)
		VALUES 
			( 	vl_offset_id,
				CURRENT_DATE,
				al_offset_amt,
				al_payment_id ,
				CURRENT_TIMESTAMP,
				'finance',
				CURRENT_TIMESTAMP,
				'finance',
				'N' 
			);

		IF SQLCODE <> 0 THEN
			al_sqlcode := SQLCODE;
		ELSE
			al_sqlcode := 0;
		END IF;
	ELSE
		al_sqlcode := -1;
	END IF;

	IF al_sqlcode = 0 THEN
		-- Cursor left open for client application
		OPEN cursor_detail;
			--fetch_loop:

			SELECT COUNT(*)
				INTO vl_row_cnt
			FROM tb_RECEIVABLE_DETAIL A,
				tb_RECEIVABLE_HEADER B,
				tb_PAYMENT_DETAIL C
			WHERE A.RECEIVABLE_ID = B.RECEIVABLE_ID
				AND A.PAYMENT_DETAIL_ID = C.PAYMENT_DETAIL_ID
				AND A.DELETE_SW = 'N'
				AND B.DELETE_SW = 'N'
				AND C.DELETE_SW = 'N'     
				AND ((A.MANUAL_SW = 'N')
				OR 
				(A.MANUAL_SW = 'Y'AND A.APPROVAL_STATUS_CD = '3047')
				)
				AND B.PROVIDER_ID = al_provider_id
				AND C.SUBSIDY_AGREEMENT_ID IS NULL  -- Excluding A/R for GAP & Adoption Subsidy
			;
  
		--Loop Start Here
		WHILE (vl_row_cnt > vl_counter)     LOOP
			-- Fetch Rows
			-- LOOP
			FETCH  cursor_detail 
				INTO vl_receivable_detail_id,
					vl_payment_detail_id,
					vl_receivable_id,
					vd_amount_no,
					vd_receivable_balance_no,
					vs_approval_status_cd;

			SELECT B.COLLECTION_STATUS_CD
				INTO vs_collection_status_cd
			FROM tb_RECEIVABLE_DETAIL A,
				tb_RECEIVABLE_COLLECTION_STATUS B
			WHERE A.RECEIVABLE_DETAIL_ID = B.RECEIVABLE_DETAIL_ID
				AND B.RECEIVABLE_DETAIL_ID = vl_receivable_detail_id
				AND B.ACTIVE_SW = 'Y'
				AND B.DELETE_SW = 'N'
				AND ((A.MANUAL_SW = 'N')
				OR 
				(A.MANUAL_SW = 'Y' AND A.APPROVAL_STATUS_CD = '3047')
				) ;
  
			IF SQLCODE <> 0 THEN
				al_sqlcode := SQLCODE;
			ELSE
				al_sqlcode := 0;
			END IF;

			-- # 18623 / CIS-18123 II
			-- IF  al_sqlcode = 0  AND vs_collection_status_cd = '779' THEN
			IF al_sqlcode = 0  AND vs_collection_status_cd <> '775' THEN
				--Payment Procedure for each Child
				IF vd_receivable_balance_no > 0 AND al_offset_amt > 0 THEN

					CASE WHEN al_offset_amt > vd_receivable_balance_no THEN
						-- Payment Greater Then Receivable Balance
						al_offset_amt := al_offset_amt - vd_receivable_balance_no;
						vd_collected_amt := vd_receivable_balance_no;
						vd_receivable_bal_amt := 0;
					WHEN al_offset_amt = vd_receivable_balance_no THEN
						-- Payment equal Then Receivable Balance
						al_offset_amt := 0;
						vd_receivable_bal_amt := 0;
						vd_collected_amt := vd_receivable_balance_no;
					WHEN al_offset_amt < vd_receivable_balance_no THEN
						-- Payment Less Then Receivable Balance
						vd_collected_amt := al_offset_amt;
						vd_receivable_bal_amt := vd_receivable_balance_no - al_offset_amt;
						al_offset_amt := 0;
					END CASE;

					--Update each child balance amount
					UPDATE tb_RECEIVABLE_DETAIL
						SET RECEIVABLE_BALANCE_NO = vd_receivable_bal_amt,
							update_ts = current_timestamp,
							update_user_id = 'finance'
					WHERE RECEIVABLE_DETAIL_ID = vl_receivable_detail_id;


					IF SQLCODE <> 0 THEN
						al_sqlcode := SQLCODE;
					ELSE
						al_sqlcode := 0;
					END IF;

					IF al_sqlcode = 0 THEN
						-- Status Changed to PIF
						IF vd_receivable_bal_amt = 0 THEN
							UPDATE tb_RECEIVABLE_DETAIL
								SET RECEIVABLE_STATUS_CD = '20',
									update_ts = current_timestamp,
									update_user_id = 'finance'
							WHERE RECEIVABLE_DETAIL_ID = vl_receivable_detail_id;

							IF SQLCODE <> 0 THEN
								al_sqlcode := SQLCODE;
							ELSE
								al_sqlcode := 0;
							END IF;
						END IF;

						IF al_sqlcode = 0 THEN
							-- Generate Key ID
							-- CALL  sp_nextid (vs_sq_name,vl_rcvbl_liquidation_id ); -- generating new id
							SELECT SP_nextid(vs_sq_name::character varying) into vl_rcvbl_liquidation_id;

							IF vl_rcvbl_liquidation_id <> -1 THEN
								-- Insert a Row in tb_RECEIVABLE_LIQUIDATION
								INSERT INTO tb_RECEIVABLE_LIQUIDATION
								(	RCVBL_LIQUIDATION_ID,
									COLLECTED_AMOUNT_NO,
									RECEIVABLE_DETAIL_ID,
									OFFSET_ID,
									CREATE_TS,
									CREATE_USER_ID,
									UPDATE_TS,
									UPDATE_USER_ID,
									DELETE_SW
								)
								VALUES
								(   vl_rcvbl_liquidation_id,
									vd_collected_amt,
									vl_receivable_detail_id,
									vl_offset_id,
									CURRENT_TIMESTAMP,
									'finance',
									CURRENT_TIMESTAMP,
									'finance',
									'N'
								);
                
								IF SQLCODE <> 0 THEN
									al_sqlcode := SQLCODE;
									-- ROLLBACK;--
								ELSE
									al_sqlcode := 0;
									-- COMMIT;--
								END IF;
							ELSE
								al_sqlcode := -1;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
    
			vl_counter := vl_counter + 1;
			-- END LOOP fetch_loop;--
			-- Loop Ends
		END LOOP;

		--Sum all balance
		SELECT SUM(A.RECEIVABLE_BALANCE_NO)
			INTO vd_total_receivable
		FROM tb_RECEIVABLE_DETAIL A,
			tb_RECEIVABLE_COLLECTION_STATUS B
		WHERE A.RECEIVABLE_DETAIL_ID = B.RECEIVABLE_DETAIL_ID
			AND A.RECEIVABLE_ID = vl_receivable_id
			AND B.ACTIVE_SW = 'Y'
			AND B.DELETE_SW = 'N'
			AND A.DELETE_SW = 'N'
			AND A.RECEIVABLE_STATUS_CD IN ('19','22')
			AND ((A.MANUAL_SW = 'N')
			OR 
			(A.MANUAL_SW = 'Y' AND A.APPROVAL_STATUS_CD = '3047')
			);

		IF SQLCODE <> 0 THEN
			al_sqlcode := SQLCODE;
		ELSE
			al_sqlcode := 0;
		END IF;

		IF al_sqlcode = 0 THEN
			--Update the blance
			UPDATE tb_RECEIVABLE_HEADER
				SET BALANCE_NO = vd_total_receivable,
					update_ts = current_timestamp,
					update_user_id = 'finance'
			WHERE RECEIVABLE_ID = vl_receivable_id;

		IF SQLCODE <> 0 THEN
			al_sqlcode := SQLCODE;
		ELSE
			al_sqlcode := 0;
		END IF;
	END IF;
  
	-- Call Sp to Update Payment Plan - CIS-18124
	--  SELECT CHESSIE_MASK_FIN.SP_PAYMENT_PLAN_UPDATE ( vl_receivable_id,
	--                      vs_sq_off,  
	--                      vl_transaction_amt,   
	--                      vl_sqlcode
	--                     );--
          
	al_sqlcode := vl_sqlcode;

	/* COMMIT; */

	CLOSE cursor_detail;
END IF;
  
--RETURN  al_sqlcode;--

END 
;

$function$
;
