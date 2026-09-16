create index idx_TB_FMIS_RESPONSE_INVOICE_NO on TB_FMIS_RESPONSE(INVOICE_NO);
create index idx_TB_FMIS_RESPONSE_INVOICE_No_DELETE_SW on TB_FMIS_RESPONSE(INVOICE_NO,DELETE_SW);
create index idx_TB_FMIS_RESPONSE_TRANSACTION_CODE on TB_FMIS_RESPONSE(TRANSACTION_CODE);
create index idx_tb_afs_response_payment_id on tb_afs_response(payment_id);
create index idx_tb_afs_response_payment_id_delete_sw on tb_afs_response(payment_id,DELETE_SW);
delete from county where countyid in ('295abd73-0175-4869-adea-e99bcae8c92f','dc13bb97-8b5c-4344-a437-f51816fbef62');
