-- To add indexes on tb_eligibility_period - CIDM-8279 CJAMS-Foster Care Maintenance Payments User Story - B-186249

create index Xie1_tb_eligibility_period on tb_eligibility_period (date(update_ts),approvalstatus,delete_sw);

create index Xie2_tb_eligibility_period on tb_eligibility_period (date(approvedon),approvalstatus,delete_sw);