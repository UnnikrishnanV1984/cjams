-- Provider Program Rates

update tb_prov_program_rates
    set update_ts = now()
where program_id = 15982
and delete_sw = 'N';
