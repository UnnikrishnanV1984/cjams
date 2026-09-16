

CREATE OR REPLACE FUNCTION cjams.fn_pmnt_detail_ins()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
IF NOT EXISTS (SELECT 1 FROM caresoutboundtrigger 
                        WHERE old_id::BIGINT = NEW.PAYMENT_ID 
	      AND fk_id::BIGINT = NEW.CLIENT_ID)   THEN
 
INSERT INTO caresoutboundtrigger
( old_id,
  fk_id,
  transactionon,
  transactiontypekey,
  statusflag,
  activeflag)
SELECT 
NEW.PAYMENT_ID,
NEW.CLIENT_ID,
CURRENT_TIMESTAMP,
'40',
'N',
1 FROM tb_payment_header payhead 
			INNER JOIN tb_payment_detail paydet ON paydet.payment_id=payhead.payment_id AND paydet.delete_sw='N' 
		and  payhead.payment_type_cd='6' and paydet.PAYMENT_ID=NEW.PAYMENT_ID;--

END IF;--

 IF NOT EXISTS(SELECT 1 FROM csesoutboundtrigger 
                        WHERE old_id::BIGINT = NEW.PAYMENT_ID 
	      AND fk_id::BIGINT = NEW.CLIENT_ID)   THEN
 
INSERT INTO csesoutboundtrigger
( old_id,
  fk_id,
  transactionon,
  transactiontypekey,
  statusflag,
  activeflag)
select 
NEW.PAYMENT_ID,
NEW.CLIENT_ID,
CURRENT_TIMESTAMP,
'40',
'N',
1 FROM tb_payment_header payhead 
			INNER JOIN tb_payment_detail paydet ON paydet.payment_id=payhead.payment_id AND paydet.delete_sw='N' 
		and  payhead.payment_type_cd='6' and paydet.PAYMENT_ID=NEW.PAYMENT_ID ;--

END IF;-- 

  return new;  

END;
$function$
;


 drop trigger IF EXISTS  tr_pmnt_detail_ins on  cjams.tb_payment_detail ;
  
create trigger tr_pmnt_detail_ins after insert
on
cjams.tb_payment_detail for each row execute procedure fn_pmnt_detail_ins();
