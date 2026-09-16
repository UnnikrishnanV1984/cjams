ALTER TABLE cjams.tb_child_account_disbursement 
add column if not exists activeflag integer ;

ALTER TABLE tb_child_account_disbursement ALTER COLUMN activeflag set  default 1;


ALTER TABLE cjams.tb_service_purchase_authorization 
add column if not exists modified_fiscal_category_cd varchar(50) null;