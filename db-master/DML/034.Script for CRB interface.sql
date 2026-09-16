drop view fm106r_view;

create sequence SQ_CRB_FACTS_INTERMEDIATE start 101;

alter  table interfaceserrorlog alter column errorcode type varchar(10000);


alter  table interfaceserrorlog alter column interfaceid type varchar(100);


CREATE OR REPLACE VIEW cjams.fm106r_view AS
 SELECT f_plvalue(tiel.county_cd, 104) AS county_name,
    tiel.county_cd,
    tiel.client_id,
    f_ename('2955'::character varying, tiel.client_id) AS client_name,
    tiel.provider_id,
    f_provname(tiel.provider_id) AS provider_nm,
    pd.payment_detail_id,
    tiel.payment_id,
    ph.payment_dt,
    pd.final_fiscal_category_cd,
    f_pdesc(ph.payment_type_cd, 2) AS payment_type_code,
    pd.final_service_start_dt,
    pd.final_service_end_dt,
    tiel.payment_amount,
    tiel.errordescription
   FROM interfaceserrorlog tiel
     LEFT JOIN tb_payment_detail pd ON tiel.payment_id = pd.payment_id AND tiel.client_id = pd.client_id AND pd.delete_sw::text = 'N'::text
     LEFT JOIN tb_payment_header ph ON pd.payment_id = ph.payment_id AND ph.delete_sw = 'N'::bpchar
  WHERE tiel.interfaceid::text = 'AFS_INTERFACES'::text
  ORDER BY tiel.county_cd ;--

ALTER TABLE cjams.fm106r_view
    OWNER TO welfareadmin ;--