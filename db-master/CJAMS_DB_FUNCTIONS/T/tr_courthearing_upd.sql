
--drop function if exists fn_courthearing_upd();
CREATE OR REPLACE FUNCTION cjams.fn_courthearing_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN


	IF NEW.hearingdatetime::VARCHAR <>OLD.hearingdatetime::VARCHAR  THEN
	
	INSERT INTO 	csesoutboundtrigger	(	 	old_id,
                    							transactionon,
                    							transactiontypekey,
                    							statusflag,
	 											activeflag)
	 			select		distinct 	sc.servicecasenumber,
                    				CURRENT_TIMESTAMP,
                     				'43',
                     				'N',
	  								1
	   			 	from 		intakeservicerequestcourthearing isra  , servicecase sc 
					where 		isra.intakeservicerequestcourthearingid = new.intakeservicerequestcourthearingid and
								 isra.servicecaseid = sc.servicecaseid
								and isra.hearingtypekey in ('Adjudi','AD', 'Disp', 'DI', 'CINA', 'MH', 'CC','CR');

			
	 end if;
	
	return new;

END;

$function$
;

  DROP  TRIGGER if exists tr_courthearing_upd ON intakeservicerequestcourthearing;


create trigger tr_courthearing_upd after  update
        of hearingdatetime on
        intakeservicerequestcourthearing for each row execute procedure fn_courthearing_upd();
