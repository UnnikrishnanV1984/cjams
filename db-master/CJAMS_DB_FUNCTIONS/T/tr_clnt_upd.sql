CREATE OR REPLACE FUNCTION cjams.fn_clnt_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$


 
BEGIN

 IF OLD.primarycitizenshiptypekey <> NEW.primarycitizenshiptypekey THEN
	INSERT INTO caresoutboundtrigger
	(	fk_id,
		transactionon,
		transactiontypekey,
		statusflag,
		activeflag)
	
	select
    	cjamspid,
		CURRENT_TIMESTAMP,
		'62',
		 'N',
		 1
	from person
	where 
		 cjamspid=NEW.cjamspid;
END IF;--

return new;
END;

$function$
;



 drop trigger IF EXISTS  tr_clnt_upd on  cjams.person ;
  drop trigger IF EXISTS  tr_clnt_ins on  cjams.person ;


create trigger tr_clnt_upd before update
    of primarycitizenshiptypekey on
    cjams.person for each row execute procedure fn_clnt_upd();
