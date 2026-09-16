-- Indexes for sp_fc_worksheet_periods_info sql
create index Xie1_placement on placement (date(startdatetime),activeflag ) where placementtypekey = 'PRPL' and ( isvoided = 0 OR isvoided IS NULL );