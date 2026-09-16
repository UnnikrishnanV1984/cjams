CREATE OR REPLACE FUNCTION cjams.fn_pmnt_detail_ins()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 06/22/2020 Vineet Tirodkar - Modification to avoid multiple inserts of the same Client/Payment in outboundtrigger tables
-- 09/29/2020 Vineet Tirodkar - Modification to exclude APS payments
-- 11/25/2020 Vineet Tirodkar - Modification for CJAMS - E&E Interface
-- 11/10/2022 Vineet Tirodkar - Modification for comment out Inserts for CARES & CSES Tables
------------------------------------------------------------------------
BEGIN
	IF EXISTS ( select 1
					from tb_payment_header
				where payment_id = NEW.PAYMENT_ID
					and delete_sw = 'N'
					and payment_type_cd in ('21','22') ) THEN
		-- Do nothing (APS Payments)			
	ELSE				
		IF NOT EXISTS (	SELECT 1 
							FROM caresoutboundtrigger 
						WHERE old_id = NEW.PAYMENT_ID::varchar 
							AND fk_id = NEW.CLIENT_ID::varchar
							AND transactiontypekey = '40' )  THEN
			/*
			INSERT INTO caresoutboundtrigger
				( 	old_id,
					fk_id,
					transactionon,
					transactiontypekey,
					statusflag,
					activeflag
				)
			VALUES
				( 	NEW.PAYMENT_ID,
					NEW.CLIENT_ID,
					CURRENT_TIMESTAMP,
					'40',
					'N',
					1 
				);
			*/	
			INSERT INTO eneoutboundtrigger
				( 	old_id,
					fk_id,
					transactionon,
					transactiontypekey,
					statusflag,
					activeflag
				)
			VALUES
				( 	NEW.PAYMENT_ID,
					NEW.CLIENT_ID,
					CURRENT_TIMESTAMP,
					'40',
					'N',
					1 
				);	

		END IF;
		/*
		IF NOT EXISTS(	SELECT 1 
							FROM csesoutboundtrigger 
						WHERE old_id = NEW.PAYMENT_ID::varchar 
							AND fk_id = NEW.CLIENT_ID::varchar
							AND transactiontypekey = '40' ) THEN
	 
			INSERT INTO csesoutboundtrigger
				(	old_id,
					fk_id,
					transactionon,
					transactiontypekey,
					statusflag,
					activeflag
				)
			VALUES
				( 	NEW.PAYMENT_ID,
					NEW.CLIENT_ID,
					CURRENT_TIMESTAMP,
					'40',
					'N',
					1 
				);
		END IF;
		*/
	END IF;
	
	return new;  

END;
$function$
;