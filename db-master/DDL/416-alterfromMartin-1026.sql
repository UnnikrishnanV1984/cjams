alter table cjams.tb_batch_runtime_log alter column create_ts  type timestamp without time zone USING create_ts::timestamp without time zone;
alter table cjams.tb_batch_runtime_log alter column update_ts  type timestamp without time zone USING update_ts::timestamp without time zone; 
alter table tb_fmis_payment_detail_interface_iss alter column create_ts type timestamp without time zone USING create_ts::timestamp without time zone;
alter table tb_fmis_payment_detail_interface_iss alter column update_ts type timestamp without time zone USING update_ts::timestamp without time zone;
alter table tb_fmis_payment_header_interface_iss  alter column create_ts type timestamp without time zone USING create_ts::timestamp without time zone;
alter table tb_fmis_payment_header_interface_iss  alter column update_ts type timestamp without time zone USING update_ts::timestamp without time zone;
alter table cjams.tb_fmis_payment_detail_interface_iss alter column batch_dt type timestamp without time zone USING batch_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_detail_interface_iss alter column effective_dt type timestamp without time zone USING effective_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_detail_interface_iss alter column invoice_dt type timestamp without time zone USING invoice_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_detail_interface_iss alter column document_dt type timestamp without time zone USING document_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_detail_interface_iss alter column due_dt type timestamp without time zone USING due_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_detail_interface_iss alter column service_dt type timestamp without time zone USING service_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_detail_interface_iss alter column discount_dt type timestamp without time zone USING discount_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_detail_interface_iss alter column penalty_dt type timestamp without time zone USING penalty_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_header_interface_iss alter column batch_dt type timestamp without time zone USING batch_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_header_interface_iss alter column batch_effective_dt type timestamp without time zone USING batch_effective_dt::timestamp without time zone;
alter table cjams.tb_fmis_payment_header_interface_iss alter column batch_system_dt type timestamp without time zone USING batch_system_dt::timestamp without time zone;

ALTER TABLE progressnote ADD COLUMN fk_user_id character varying;
ALTER TABLE progressnotedetail ADD COLUMN fk_user_id character varying;
 
