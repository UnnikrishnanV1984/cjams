CREATE OR REPLACE FUNCTION cjams.checkupdatepif(v_receivable_detail_id integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

--------------------------------------------------Revisions----------------------------------------------
--6/11/2026 -Vinesh -CIDM-11058 AR Balance Issue when Supervisor approved the Write-Off, the AR status should be displayed as Outstanding and no need supervisor approval when updating the collection status.
---------------------------------------------------------------------------------------------------------

DECLARE 
	v_fiscal_category_cd character;
    v_receivable_status_cd character varying(5);
	
BEGIN 
	select receivable_status_cd into v_receivable_status_cd from tb_receivable_detail where receivable_detail_id=v_receivable_detail_id;

if ((select coalesce(receivable_balance_no,0) ::integer from tb_receivable_detail trd where trd.receivable_detail_id = v_receivable_detail_id) = 0 and v_receivable_status_cd = '21') then
    
    raise notice '>>>Inside if condition: balance 0, status 21>>> %', v_receivable_status_cd;
    
    update tb_receivable_detail 
    set receivable_status_cd = '21' 
    where receivable_detail_id = v_receivable_detail_id;

-- NEW LOGIC: Update to 19 outstanding when status is 21 and balance > 0
elsif ((select coalesce(receivable_balance_no,0) ::integer from tb_receivable_detail trd where trd.receivable_detail_id = v_receivable_detail_id) > 0 and v_receivable_status_cd = '21') then
    
    raise notice '>>>Inside elsif condition: balance > 0, status 21. Updating to 19>>> %', v_receivable_status_cd;
    
    update tb_receivable_detail 
    set receivable_status_cd = '19' 
    where receivable_detail_id = v_receivable_detail_id;
else
    
    raise notice '>>>Inside else condition -- v_receivable_status_cd >>> %', v_receivable_status_cd;
    
    update tb_receivable_detail 
    set receivable_status_cd = '20' 
    where receivable_detail_id = v_receivable_detail_id
	and (select coalesce(receivable_balance_no,0) ::integer from tb_receivable_detail trd where trd.receivable_detail_id = v_receivable_detail_id) = 0 ;

end if;

return 'Success';

END;

$function$;
