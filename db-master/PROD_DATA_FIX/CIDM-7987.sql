/*
 * CIDM-7987 - Service Log Vendor info missing
 * This internal ticket created to identify and fix all other impacted purchase authorizations records
 * Ref: CDM-34418
 * Ticket Description: Dashboard:Auth#2135217- Vendor information is missing from the screen and also when I print the Funding Request Form. Please advise.
 * Screen name:Ancillary Payment
 * Focus Area:Payments
 * 
 */

select provider_id, provider_name, 
    f_ename('2953', provider_id::bigint),
    authorization_id, update_ts, update_user_id  
from cjams.tb_slpa_snapshot
where delete_sw = 'N'
    and (provider_name is null or btrim(provider_name ) = '' ) ;
    
UPDATE cjams.tb_slpa_snapshot
SET provider_name = f_ename('2953', provider_id::bigint) 
where delete_sw = 'N'
    and (provider_name is null or btrim(provider_name ) = '' ) ;
   