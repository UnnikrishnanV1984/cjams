/*
 * CIDM-10710 - B-226708 Fiscal Category Codes for Hotel Stays
 * Focus Area:Purchase Authorization Form
 */
 
ALTER TABLE cjams.tb_fiscal_category_master
add column if not exists additional_description  text;

COMMENT ON COLUMN cjams.tb_fiscal_category_master.additional_description IS 'Additional description to be displayed as informational text via the info icon or at the appropriate location.';