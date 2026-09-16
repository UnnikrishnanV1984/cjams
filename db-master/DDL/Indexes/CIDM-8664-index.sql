create index Xie2_TB_PAYMENT_HEADER on TB_PAYMENT_HEADER (lpad(to_char_int(payment_id), 14, '0'));
