-- FUNCTION: cjams.fn_personrelationship_upd()

-- DROP FUNCTION cjams.fn_personrelationship_upd();
 DROP TRIGGER if exists tr_clnt_relat_ins ON actorrelationship;

 DROP FUNCTION if exists  cjams.fn_clnt_relat_ins();

CREATE OR REPLACE FUNCTION cjams.fn_personrelationship_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
	
    IF 	OLD.relationshiptypekey <> NEW.relationshiptypekey  then
    
    	if new.relationshiptypekey in ('BGMTHR','BGFTHR','father','mother') then 
  

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
	   										actorrelationship AR, 
	   										PERSON p,
	   										servicecase sc  
       								where 	AR.intakeservicerequestactorid = ISR.intakeservicerequestactorid
       										and AR.intakeservicerequestactorid = new.intakeservicerequestactorid
       										and P.personid = ISR.personid
       										and sc.servicecaseid=isr.servicecaseid;--
       		END IF;--
    end if;
   
   
   IF 	OLD.relationshiptypekey <> NEW.relationshiptypekey  then
    
    	if new.relationshiptypekey in ('BGMTHR','BGFTHR','father','mother') then 

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
   										actorrelationship AR, 
   										PERSON p,
   										servicecase sc  
								where 	AR.intakeservicerequestactorid = ISR.intakeservicerequestactorid
										and AR.intakeservicerequestactorid = new.intakeservicerequestactorid
										and P.personid = ISR.personid
										and sc.servicecaseid=isr.servicecaseid;--
			END IF;--
	end if;--
	 
return new;
END;

$function$
;



  DROP  TRIGGER if exists tr_personrelationship_upd ON actorrelationship;

create trigger tr_personrelationship_upd after update
    of relationshiptypekey on
    cjams.actorrelationship for each row execute procedure fn_personrelationship_upd();