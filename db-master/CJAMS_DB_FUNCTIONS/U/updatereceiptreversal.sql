CREATE OR REPLACE FUNCTION cjams.updatereceiptreversal(searchobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 
	v_securityusersid character varying;
    v_receivabledetail integer;
    v_amount_no numeric;
    v_liquidationentry record;
    v_remainingamount numeric;
    v_tobesubtracted numeric;
    v_reason_tx character varying;
    v_toassingedsecurityuserid character varying;
    v_routingstatus character varying;
    v_receipt_id int;
   v_notes character varying;
	
BEGIN 
	v_securityusersid := searchobj ->> 'securityusersid';
    v_toassingedsecurityuserid := searchobj ->> 'toassingedsecurityuserid';
	v_receivabledetail := searchobj ->> 'receivable_detail_id';
    v_amount_no := searchobj ->> 'payment_amount_no';
     v_receipt_id := searchobj ->> 'receipt_id';
   v_reason_tx := searchobj ->> 'reason_tx';
    v_notes := searchobj ->> 'notes_tx';
	if(v_receipt_id is not null) then
	 update tb_receivable_detail set isreversal=true,reversal_amount_no=coalesce(reversal_amount_no, 0) + v_amount_no where receivable_detail_id=v_receivabledetail;
	update tb_payment_receipt set reversal_amount_no=coalesce(reversal_amount_no, 0) + v_amount_no,notes_tx=v_notes where receipt_id=v_receipt_id;
   for v_liquidationentry in select rcvbl_liquidation_id,receipt_id,collected_amount_no,receivable_detail_id from tb_receivable_liquidation
   where receipt_id=v_receipt_id
   
  loop 
  
  if (v_liquidationentry.collected_amount_no >= v_amount_no) then 
   update tb_receivable_liquidation set reversal_amount_no = v_amount_no,reversal_reason_tx =v_reason_tx  where rcvbl_liquidation_id=v_liquidationentry.rcvbl_liquidation_id;
  v_remainingamount := 0;
  v_amount_no := 0; 
 else 
  v_tobesubtracted := v_amount_no - v_liquidationentry.collected_amount_no;
  update tb_receivable_liquidation set reversal_amount_no = v_tobesubtracted,reversal_reason_tx =v_reason_tx  where rcvbl_liquidation_id=v_liquidationentry.rcvbl_liquidation_id;
  v_remainingamount := v_amount_no - v_tobesubtracted;
  v_amount_no := v_remainingamount ; 
  end if;
  EXIT when v_remainingamount = 0;
  end loop;

 
select routingfinance into v_routingstatus from routingfinance(v_receipt_id::character varying,v_securityusersid::character varying,'RVRSL'::character varying,30,'Pending'::text,v_toassingedsecurityuserid::character varying,
false,false,false,'Receipt Reversed','Receipt Reversed',null
);

return v_routingstatus;
else 
return 'Failure';
end if;
END;

$function$
