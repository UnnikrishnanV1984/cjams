CREATE OR REPLACE FUNCTION cjams.fn_eligibility_status()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 11/25/2020 Vineet Tirodkar - Modification for CJAMS - E&E Interface
------------------------------------------------------------------------
BEGIN

	IF NEW.eligibility_type_cd <> OLD.eligibility_type_cd THEN

		INSERT INTO caresoutboundtrigger
			( 	old_id,
				fk_id,
				transactionon,
				transactiontypekey,
				statusflag,
				activeflag
			)
		SELECT
			case_id,
			client_id,
			CURRENT_TIMESTAMP,
			'20',
			'N',
			1
		from tb_client_eligibility cl  
		where cl.eligibility_type_cd = new.eligibility_type_cd;
		

		INSERT INTO eneoutboundtrigger
			( 	old_id,
				fk_id,
				transactionon,
				transactiontypekey,
				statusflag,
				activeflag
			)
		SELECT
			case_id,
			client_id,
			CURRENT_TIMESTAMP,
			'20',
			'N',
			1
		from tb_client_eligibility cl  
		where cl.eligibility_type_cd = new.eligibility_type_cd;
		
		INSERT INTO csesoutboundtrigger
			(	 old_id,
				fk_id,
				transactionon,
				transactiontypekey,
				statusflag,
				activeflag
			)
		SELECT
			case_id,
			client_id,
			CURRENT_TIMESTAMP,
			'20',
			'N',
			1
		from tb_client_eligibility cl  
		where cl.eligibility_type_cd = new.eligibility_type_cd;

	END IF;

	RETURN NEW;
END;


$function$
;
