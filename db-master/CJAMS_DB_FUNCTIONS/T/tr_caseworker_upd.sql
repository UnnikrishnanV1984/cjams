
-- drop function if exits cjams.fn_caseworker_upd();
CREATE OR REPLACE FUNCTION cjams.fn_caseworker_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN

	if	((new.toworkeridno <> new.fromworkeridno) and new.statustypekey='ASSGN')  then  

	INSERT INTO 	csesoutboundtrigger	(	 	old_id,
                    							transactionon,
                    							transactiontypekey,
                    							statusflag,
	 											activeflag)
	 											
					select	 distinct	servicecase.servicecasenumber,
                    			CURRENT_TIMESTAMP,
                     			'45',
                     			'N',
	  							1
	   			 
					from 	caseassignment ,  servicecase 
					where 	caseassignment.objectid = servicecase.servicecaseid and
							 caseassignment.toworkeridno <> caseassignment.fromworkeridno 
							and caseassignment.objecttypekey = 'servicecase' and caseassignment.statustypekey='ASSGN' and
							caseassignment.caseassignmentid=new.caseassignmentid 
					 limit 1 ;
					
					
					
		INSERT INTO 	csesoutboundtrigger	(	 	old_id,
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
							 caseassignment.toworkeridno <> caseassignment.fromworkeridno 
							and caseassignment.objecttypekey = 'adoptioncase' and
							caseassignment.objectid=new.objectid 
					 limit 1 ;
	   					
	 end if;
	 
	 
	if	((new.toldssid <> new.fromldssid) and new.statustypekey='ASSGN')  then  

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
							and caseassignment.objecttypekey = 'servicecase' and caseassignment.statustypekey='ASSGN' and
							caseassignment.caseassignmentid=new.caseassignmentid 
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
							and caseassignment.objecttypekey = 'adoptioncase' and caseassignment.statustypekey='ASSGN' and
							caseassignment.caseassignmentid=new.caseassignmentid 
					 limit 1 ;												
					 
	 end if;

	
	return new;

END;

$function$
;

  DROP  TRIGGER if exists tr_caseworker_upd ON caseassignment;
    DROP  TRIGGER if exists tr_department_upd ON intakeservicerequest;
  DROP  TRIGGER if exists tr_department_upd ON caseassignment;

create trigger tr_caseworker_upd after insert
     on
    caseassignment for each row execute procedure fn_caseworker_upd();
