-- CDM-35737 - Incorrect Coding on CJAMS Purchase Authorizations
/* Issue Description:Foster Care entered incorrect coding on 2 CJAMS purchase authorizations,need to have the payments moved to the correct budget code 

-- Case ID: 3306930
-- Client ID: 3425183
-- Service Log ID: 2804598 & 2805689    
    
-- Current: 7133     Foster Care (Super Flex)
-- New: 7121     One-on-One Support

-- Category/ Module: Title IV-E 

-- Root cause: Foster Care entered incorrect coding on 2 CJAMS purchase authorizations,need to have the payments moved to the correct budget code
-- Fix Provided: Datafix has been provided to update category code on purchase authorization and payment details
-- Pull request# N/A

*/

select fiscal_category_cd, update_ts, update_user_id, *
from tb_service_purchase_authorization
where authorization_id in (2712793, 2714288)
    and delete_sw = 'N'
    and btrim(fiscal_category_cd) = '7133';

update tb_service_purchase_authorization
set fiscal_category_cd='7121',
	update_ts = now(), 	
	update_user_id = 'CDM-35737'
where authorization_id in (2712793, 2714288)
    and delete_sw = 'N'
    and btrim(fiscal_category_cd) = '7133';

-- Payment IDs :3820043 & 3820040 Date:    2023-11-21    
select final_fiscal_category_cd, update_ts, update_user_id, *
from tb_payment_detail
where payment_detail_id in (5056364, 5056361)
    and delete_sw = 'N'
    and btrim(final_fiscal_category_cd) = '7133';

update tb_payment_detail
set final_fiscal_category_cd='7121',
	update_ts = now(), 	
	update_user_id = 'CDM-35737'
where payment_detail_id in (5056364, 5056361)
    and delete_sw = 'N'
    and btrim(final_fiscal_category_cd) = '7133';

