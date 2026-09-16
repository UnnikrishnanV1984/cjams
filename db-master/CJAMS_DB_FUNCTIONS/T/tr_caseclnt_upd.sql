CREATE OR REPLACE FUNCTION cjams.fn_caseclnt_upd()
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
					servicecase.servicecasenumber,
                     CURRENT_TIMESTAMP,
                     '60',
                     'N',
	  1
	   from person,  servicecase,intakeservicerequestactor
	   where intakeservicerequestactor.personid=person.personid and 
	   intakeservicerequestactor.intakeservicerequestpersontypekey='PARENT' and
		  person.personid = new.personid and
	    servicecase.servicecaseid = intakeservicerequestactor.servicecaseid;--

    END IF;--


    IF  NEW.dateofdeath IS NOT NULL THEN

	INSERT INTO csesoutboundtrigger
	( fk_id, 
      old_id,
      transactionon,
      transactiontypekey,
      statusflag,
	 activeflag)
	Select
                    person.cjamspid,
					servicecase.servicecasenumber,
                     CURRENT_TIMESTAMP,
                     '42',
                     'N',
	  1
	   from person,  servicecase,intakeservicerequestactor
	   where intakeservicerequestactor.personid=person.personid and 
	   intakeservicerequestactor.intakeservicerequestpersontypekey='PARENT' and
		  person.personid = new.personid and
	    servicecase.servicecaseid = intakeservicerequestactor.servicecaseid;--

    END IF;--

return new;
END;

$function$
;

 DROP TRIGGER if exists tr_caseclnt_upd ON cjams.person;

create trigger tr_caseclnt_upd after  update
    of dateofdeath on
    cjams.person for each row execute procedure fn_caseclnt_upd();
   
   
   
   
   
   
   