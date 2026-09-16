

CREATE OR REPLACE FUNCTION cjams.fn_personrelationship_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
	
    
    	if new.intakeservicerequestpersontypekey in ('PARENT') then 
  

			INSERT INTO 	caresoutboundtrigger	( 	fk_id, 
                     									old_id,
                    									transactionon,
                    									transactiontypekey,
                    									statusflag,
	                									activeflag)
									select	p.cjamspid,
											sc.servicecasenumber,
                    						current_timestamp,
                     						'50',
                     						'N',
                      						1
	   								from 	intakeservicerequestactor isr, 
	   										PERSON p,
	   										servicecase sc  
       								where 	
									        isr.intakeservicerequestactorid = new.intakeservicerequestactorid
       										and P.personid = isr.personid
       										and sc.servicecaseid=isr.servicecaseid 
											;--
											
											
				
       		END IF;--
   
   
   IF 	new.intakeservicerequestpersontypekey in ('PARENT')  then
    
    	

			INSERT INTO csesoutboundtrigger	(	fk_id, 
     											old_id,
      											transactionon,
      											transactiontypekey,
      											statusflag,
	 											activeflag)
								select	P.cjamspid,
                   						sc.servicecasenumber,
                    					CURRENT_TIMESTAMP,
                     					'41',
                     					'N',
                      					1
   									from 	intakeservicerequestactor isr, 
	   										PERSON p,
	   										servicecase sc  
       								where 	
									        isr.intakeservicerequestactorid = new.intakeservicerequestactorid
       										and P.personid = isr.personid
       										and sc.servicecaseid=isr.servicecaseid 
											;--
											
			END IF;--
	 
return new;
END;

$function$
;


 drop trigger IF EXISTS  tr_personrelationship_upd on  intakeservicerequestactor;
    

create trigger tr_personrelationship_upd after  insert or update
    of intakeservicerequestpersontypekey on
    intakeservicerequestactor for each row execute procedure fn_personrelationship_upd();
