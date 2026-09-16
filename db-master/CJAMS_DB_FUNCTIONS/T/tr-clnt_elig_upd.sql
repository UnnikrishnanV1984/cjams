--DROP FUNCTION IF EXISTS cjams.fn_clnt_elig_upd()();
CREATE OR REPLACE FUNCTION cjams.fn_clnt_elig_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

 
 IF  OLD.eligibility_status_cd <> NEW.eligibility_status_cd THEN
	
    
	
	INSERT INTO caresoutboundtrigger
					( old_id,
                     fk_id,
                    transactionon,
                    transactiontypekey,
                    statusflag,
                    activeflag)
	SELECT
                    case_id,
                     client_id,
                     CURRENT_TIMESTAMP,
                     '20',
                     'N',
                     1
					 from tb_client_eligibility cl  
					 where cl.eligibility_id=new.eligibility_id;--
					 
					 
	INSERT INTO csesoutboundtrigger
					( old_id,
                     fk_id,
                    transactionon,
                    transactiontypekey,
                    statusflag,
                    activeflag)
	SELECT
                    case_id,
                     client_id,
                     CURRENT_TIMESTAMP,
                     '20',
                     'N',
                     1
					 from tb_client_eligibility cl  
					 where cl.eligibility_id=new.eligibility_id;--


end if;
RETURN NEW;
END;


$function$
;


 drop trigger IF EXISTS  tr_per_elig_upd on  tb_client_eligibility ;
    


create trigger tr_per_elig_upd after update
    of eligibility_status_cd on
    tb_client_eligibility for each row execute procedure fn_clnt_elig_upd();
