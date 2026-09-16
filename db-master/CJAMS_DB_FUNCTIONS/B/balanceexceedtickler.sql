drop function if exists  balanceexceedtickler(bigint,varchar);

CREATE OR REPLACE FUNCTION cjams.balanceexceedtickler(v_client_account_id bigint, v_securityusersid character varying)
 RETURNS TABLE(childname text, total_balance_no numeric)
 LANGUAGE plpgsql
AS $function$

declare 

v_client_id bigint;
v_account_type_cd varchar;
v_isexceed bigint;
v_balance json;
v_totalbalance numeric;
v_childname text;
vl_tickler_id BIGINT DEFAULT 0;
v_county_cd varchar;



begin

select client_id,account_type_cd,concat (p.firstname,' ',p.middlename,' ',p.lastname) childname,ca.county_cd into v_client_id,v_account_type_cd,v_childname,v_county_cd from tb_client_account 
 ca join person p on p.cjamspid=ca.client_id 
where ca.client_account_id=v_client_account_id
and ca.county_cd IN ( select statecountycode from county where golivedate <= CURRENT_DATE );

select isexceed,balance into v_isexceed,v_balance from getchildaccouctexists(v_client_id::int,v_account_type_cd);


v_balance := v_balance  -> 0 ;
v_totalbalance := v_balance -> 'total_balance_no';

if (v_totalbalance >= 1500 and v_account_type_cd = '590') then 

SELECT al_next_value from  sp_nextid ( 'sq_payment_header') into vl_tickler_id;
INSERT INTO cjams.tb_ticklers
(tickler_id, tickler_tx, tickler_type_sw, entity_type_cd, entity_key_id, entity_nm, assigned_to_staff_id, client_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, county_cd, county_unit_id, system_tickler_id, tickler_nature_cd, assign_to_county_cd, assign_to_unit_id, expiry_dt, entity_id1, entity_id2, screen_cd, data_valid_sw, client_merge_id, action_tx, action_sw, action_dt, supervisor_review_sw, transfered_tickler_id, action_by_staff_id)
VALUES( vl_tickler_id,'Childs ('||v_childname||') Conserved account balance exceeds $1500', 'S', '2955', v_client_account_id, v_childname, NULL, v_client_id, now(),'finance', now(), 'finance', 'N',
v_county_cd
, NULL, 54, NULL, NULL, NULL, NULL, v_client_account_id, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*(select ca.county_cd from tb_client_account 
 ca join person p on p.cjamspid=ca.client_id 
where ca.client_account_id=v_client_account_id 
and ca.county_cd IN ( select statecountycode from county where golivedate <= CURRENT_DATE )
limit 1)*/
end if;

raise notice 'v_totalbalance%',v_totalbalance;
	
return query
select v_childname,v_totalbalance from tb_client_account limit 1;

END;
 
$function$;
