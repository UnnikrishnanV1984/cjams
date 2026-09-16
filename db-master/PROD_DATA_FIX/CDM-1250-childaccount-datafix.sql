update tb_client_account set total_balance_no = (total_balance_no-350.09), available_balance_no = (available_balance_no-350.09) where client_id=1416170 and client_account_id=15739;

update tb_commingled_account set total_balance_no = (total_balance_no-350.09) where comm_account_id = 61;