alter table TB_PLACEMENT_FSS
alter column CREATE_USER_ID type VARCHAR(50);

alter table TB_ADOPTION_FSS 
alter column adoption_id type BIGINT;
alter table TB_ADOPTION_FSS
alter column provider_id type BIGINT;
alter table TB_ADOPTION_FSS
alter column case_id type BIGINT;
alter table TB_ADOPTION_FSS
alter column disclosure_staff_id set default null;
alter table TB_ADOPTION_FSS
alter column court_order_id set default null;
alter table TB_ADOPTION_FSS
alter column placement_id set default null;
alter table TB_ADOPTION_FSS
alter column adoptive_father_id set default null;
alter table TB_ADOPTION_FSS
alter column adoptive_mother_id set default null;
alter table TB_ADOPTION_FSS
alter column client_merge_id set default null;
alter table TB_ADOPTION_FSS
add adoptionagreementrateid UUID;
alter table TB_ADOPTION_FSS
add adoptionagreementid UUID;
alter table TB_ADOPTION_FSS
add ma_only_payment_cd text;

alter table TB_ADOPTION_SUBSIDY_AGREEMENT_FSS
alter column create_user_id type VARCHAR(50);
alter table TB_ADOPTION_SUBSIDY_AGREEMENT_FSS
alter column update_user_id  type VARCHAR(50);


alter table TB_FISCAL_CATEGORY_MASTER_FSS
alter column create_ts type character varying(30);
alter table TB_FISCAL_CATEGORY_MASTER_FSS
alter column update_ts type character varying(30); 

alter table TB_ADOPTION_SUBSIDY_AGREEMENT_FSS add adoptionplanningid UUID;
alter table TB_ADOPTION_SUBSIDY_AGREEMENT_FSS add adoptionagreementrateid UUID;


alter table TB_PAYMENT_HEADER_fss
alter column create_user_id type varchar(50);
alter table TB_PAYMENT_HEADER_fss
alter column update_user_id type varchar(50);

alter table TB_PAYMENT_DETAIL_fss
alter column create_user_id type varchar(50);
alter table TB_PAYMENT_DETAIL_fss
alter column update_user_id type varchar(50);
alter table TB_PAYMENT_DETAIL_fss
alter column client_id type BIGINT;
alter table TB_PAYMENT_DETAIL_fss
alter column placement_id type BIGINT;
alter table TB_PAYMENT_DETAIL_fss
alter column case_id type BIGINT;

alter table TB_PAYMENT_STATUS_fss
alter column create_user_id type varchar(50);
alter table TB_PAYMENT_STATUS_fss
alter column update_user_id type varchar(50);