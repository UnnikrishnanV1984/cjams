update tb_fmis_pmnt_vendor_dt
set teamtypekey = 'CW', update_ts = now()
where teamtypekey is null;
