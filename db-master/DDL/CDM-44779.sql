/* CDM-44779 - Indexes to improve performace on stored proc cjams.overpaymenthistorylistdetails */

CREATE INDEX IF NOT EXISTS idx_tph_provider_active ON tb_payment_header (provider_id, delete_sw) WHERE (delete_sw = 'N');
CREATE INDEX IF NOT EXISTS idx_tpd_payment_id ON tb_payment_detail (payment_id, delete_sw) WHERE (delete_sw = 'N');
CREATE INDEX IF NOT EXISTS idx_trd_pay_detail_active ON tb_receivable_detail (payment_detail_id, delete_sw) WHERE (delete_sw = 'N');
CREATE INDEX IF NOT EXISTS idx_trcs_latest_lookup ON tb_receivable_collection_status (receivable_detail_id, update_ts DESC) INCLUDE (collection_status_cd) WHERE (delete_sw = 'N');
CREATE INDEX IF NOT EXISTS idx_trcs_active_sw ON tb_receivable_collection_status (receivable_detail_id) WHERE (active_sw = 'Y' AND delete_sw = 'N');
CREATE INDEX IF NOT EXISTS idx_trl_rec_detail_liquidation ON tb_receivable_liquidation (receivable_detail_id, delete_sw) INCLUDE (collected_amount_no, isreversal) WHERE (delete_sw = 'N');
CREATE INDEX IF NOT EXISTS idx_trl_offset_receipt ON tb_receivable_liquidation (receivable_detail_id) WHERE (offset_id IS NOT NULL OR receipt_id IS NOT NULL);