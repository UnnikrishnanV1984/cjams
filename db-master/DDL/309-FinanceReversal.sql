alter table tb_receivable_detail add column if not exists reversal_amount_no numeric null;
alter table tb_payment_receipt add column if not exists reversal_amount_no numeric null;