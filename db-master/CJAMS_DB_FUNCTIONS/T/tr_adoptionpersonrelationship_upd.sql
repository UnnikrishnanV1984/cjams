CREATE OR REPLACE FUNCTION cjams.fn_adoptionpersonrelationship_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
	
    
    	if new.actortypekey in ('ADOPTIVEPARENT') then 
  

			INSERT INTO 	caresoutboundtrigger	( 	fk_id, 
                     									old_id,
                    									transactionon,
                    									transactiontypekey,
                    									statusflag,
	                									activeflag)
									select	p.cjamspid,
											ac.adoptioncasenumber,
                    						current_timestamp,
                     						'50',
                     						'N',
                      						1
	   								from 	adoptioncaseactor  aca, 
	   										PERSON p,
	   										adoptioncase ac  
       								where 	
									        aca.adoptioncaseactorid = new.adoptioncaseactorid
       										and P.personid = aca.personid
       										and aca.adoptioncaseid=ac.adoptioncaseid 
											;--
											
											
				
       		END IF;--
   
   
   IF 	new.actortypekey in ('ADOPTIVEPARENT')  then
    
    	

			INSERT INTO csesoutboundtrigger	(	fk_id, 
     											old_id,
      											transactionon,
      											transactiontypekey,
      											statusflag,
	 											activeflag)
								select	p.cjamspid,
											ac.adoptioncasenumber,
                    						current_timestamp,
                     						'41',
                     						'N',
                      						1
	   								from 	adoptioncaseactor  aca, 
	   										PERSON p,
	   										adoptioncase ac  
       								where 	
									        aca.adoptioncaseactorid = new.adoptioncaseactorid
       										and P.personid = aca.personid
       										and aca.adoptioncaseid=ac.adoptioncaseid 
											;--
											
			END IF;--
	 
return new;
END;

$function$
;


 drop trigger IF EXISTS  tr_adoptionpersonrelationship_upd on      adoptioncaseactor;
    

create trigger tr_adoptionpersonrelationship_upd after  insert or update
    of actortypekey on
    adoptioncaseactor for each row execute procedure fn_adoptionpersonrelationship_upd();
