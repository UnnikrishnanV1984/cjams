alter table tb_receivable_liquidation add column if not exists reversal_amount_no numeric(10,2);
alter table tb_receivable_liquidation add column if not exists reversal_reason_tx varchar(15) null;
alter table tb_receivable_detail add column if not exists isreversal boolean null;