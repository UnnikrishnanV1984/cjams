
          
--drop function if exists fn_petitiondate_ins();

           
CREATE OR REPLACE FUNCTION fn_petitiondate_ins()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN


	IF NEW.petitiondate::VARCHAR is not null  THEN
	
	INSERT INTO 	csesoutboundtrigger	(	 	old_id,
                    							transactionon,
                    							transactiontypekey,
                    							statusflag,
	 											activeflag)
	 											
					select		distinct 	sc.servicecasenumber,
                    				CURRENT_TIMESTAMP,
                     				'44',
                     				'N',
	  								1
	   			 	from 		intakeservicerequestpetition isrp  , servicecase sc
					where 		isrp.servicecaseid = sc.servicecaseid  and
					            isrp.intakeservicerequestpetitionid= new.intakeservicerequestpetitionid
								and isrp.activeflag=1 and sc.activeflag=1 and isrp.petitiontypekey='GAPTPR';
			
	 end if;
	
	return new;

END;

$function$
;
           

  DROP  TRIGGER if exists tr_petetiondate_ins ON intakeservicerequestpetition;


create
    trigger tr_petetiondate_ins after  insert on
            intakeservicerequestpetition for each row execute procedure fn_petitiondate_ins();