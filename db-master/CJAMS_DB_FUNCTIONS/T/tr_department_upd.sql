

--drop function if exists fn_department_upd();


CREATE OR REPLACE FUNCTION fn_department_upd()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
BEGIN

	if new.toldssid <> old.toldssid  then 

	INSERT INTO 	caresoutboundtrigger	(	 
                     							old_id,
                    							transactionon,
                    							transactiontypekey,
                    							statusflag,
	 											activeflag)
					select	 distinct	servicecase.servicecasenumber,
                    			CURRENT_TIMESTAMP,
                     			'64',
                     			'N',
	  							1
	   			 
					from 	caseassignment ,  servicecase 
					where 	caseassignment.objectid = servicecase.servicecaseid and
							 caseassignment.fromldssid <> caseassignment.toldssid 
							and caseassignment.objecttypekey = 'servicecase' and
							caseassignment.objectid=new.objectid 
					 limit 1 ;
					 
			INSERT INTO 	caresoutboundtrigger	(	 
                     							old_id,
                    							transactionon,
                    							transactiontypekey,
                    							statusflag,
	 											activeflag)
	              select	 distinct	adoptioncase.adoptioncasenumber,
                    			CURRENT_TIMESTAMP,
                     			'45',
                     			'N',
	  							1
	   			 
					from 	caseassignment ,  adoptioncase 
					where 	caseassignment.objectid = adoptioncase.adoptioncaseid and
							 caseassignment.fromldssid <> caseassignment.toldssid 
							and caseassignment.objecttypekey = 'adoptioncase' and
							caseassignment.objectid=new.objectid 
					 limit 1 ;												
					 
	 end if;

END;

$function$
;


  DROP  TRIGGER if exists tr_department_upd ON intakeservicerequest;
  DROP  TRIGGER if exists tr_department_upd ON caseassignment;


create trigger tr_department_upd  before update
    of toldssid on
    caseassignment for each row execute procedure fn_department_upd();
