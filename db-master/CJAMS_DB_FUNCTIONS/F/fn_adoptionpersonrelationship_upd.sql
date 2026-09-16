CREATE OR REPLACE FUNCTION cjams.fn_adoptionpersonrelationship_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 11/25/2020 Vineet Tirodkar - Modification for CJAMS - E&E Interface
------------------------------------------------------------------------
begin
   	if new.actortypekey in ('ADOPTIVEPARENT') then 
  
		INSERT INTO caresoutboundtrigger	
			( 	fk_id, 
				old_id,
				transactionon,
				transactiontypekey,
				statusflag,
				activeflag
			)
		select p.cjamspid,
			ac.adoptioncasenumber,
			current_timestamp,
			'50',
			'N',
			1
		from adoptioncaseactor  aca, 
			PERSON p,
			adoptioncase ac  
		where aca.adoptioncaseactorid = new.adoptioncaseactorid
			and P.personid = aca.personid
			and aca.adoptioncaseid = ac.adoptioncaseid ;
				
		INSERT INTO eneoutboundtrigger	
			( 	fk_id, 
				old_id,
				transactionon,
				transactiontypekey,
				statusflag,
				activeflag
			)
		select p.cjamspid,
			ac.adoptioncasenumber,
			current_timestamp,
			'50',
			'N',
			1
		from adoptioncaseactor  aca, 
			PERSON p,
			adoptioncase ac  
		where aca.adoptioncaseactorid = new.adoptioncaseactorid
			and P.personid = aca.personid
			and aca.adoptioncaseid = ac.adoptioncaseid ;		
	END IF;
   
   
   IF new.actortypekey in ('ADOPTIVEPARENT')  then
    
		INSERT INTO csesoutboundtrigger	
			(	fk_id, 
				old_id,
				transactionon,
				transactiontypekey,
				statusflag,
				activeflag
			)
		select	p.cjamspid,
			ac.adoptioncasenumber,
			current_timestamp,
			'41',
			'N',
			1
		from adoptioncaseactor  aca, 
			PERSON p,
			adoptioncase ac  
		where aca.adoptioncaseactorid = new.adoptioncaseactorid
			and P.personid = aca.personid
			and aca.adoptioncaseid=ac.adoptioncaseid 
		;

	END IF;
	 
return new;
END;

$function$
;
