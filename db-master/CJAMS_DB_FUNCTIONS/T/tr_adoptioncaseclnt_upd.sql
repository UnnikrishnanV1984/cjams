

-- DROP FUNCTION fn_adoptioncaseclnt_upd();

CREATE OR REPLACE FUNCTION fn_adoptioncaseclnt_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN

    IF  NEW.dateofdeath IS NOT NULL THEN

	INSERT INTO caresoutboundtrigger
	( fk_id, 
                     old_id,
                    transactionon,
                    transactiontypekey,
                    statusflag,
	 activeflag)
	 Select
                    person.cjamspid,
					adoptioncase.adoptioncasenumber,
                     CURRENT_TIMESTAMP,
                     '60',
                     'N',
	                   1
	   from person,  adoptioncase, adoptioncaseactor 
	   where adoptioncaseactor.personid=person.personid and 
	         adoptioncaseactor.actortypekey='ADOPTIVEPARENT' and
		     person.personid = new.personid and
	         adoptioncaseactor.adoptioncaseid = adoptioncase.adoptioncaseid;--
    END IF;--


    IF NEW.dateofdeath IS NOT NULL THEN

	INSERT INTO csesoutboundtrigger
	( fk_id, 
      old_id,
      transactionon,
      transactiontypekey,
      statusflag,
	 activeflag)
	  
	  Select
                    person.cjamspid,
					adoptioncase.adoptioncasenumber,
                     CURRENT_TIMESTAMP,
                     '42',
                     'N',
	                   1
	   from person,  adoptioncase, adoptioncaseactor 
	   where adoptioncaseactor.personid=person.personid and 
	         adoptioncaseactor.actortypekey='ADOPTIVEPARENT' and
		     person.personid = new.personid and
	         adoptioncaseactor.adoptioncaseid = adoptioncase.adoptioncaseid;--

    END IF;--

return new;
END;

$function$
;

 DROP TRIGGER if exists tr_adoptioncaseclnt_upd ON cjams.person;

create trigger tr_adoptioncaseclnt_upd after     update
    of dateofdeath on
    person for each row execute procedure fn_adoptioncaseclnt_upd();
