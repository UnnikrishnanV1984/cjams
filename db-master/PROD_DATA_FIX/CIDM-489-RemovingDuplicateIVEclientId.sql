update tb_client_eligibility set delete_sw = 'Y', update_ts = now(), update_user_id = 'CIDM-480' where removal_id in (250569, 250616);
