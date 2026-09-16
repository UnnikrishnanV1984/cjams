-- To add indexes for Expungement Job Performance Fixes (CIDM-8423)

create index Xie1_tb_cjams_client_participation on tb_cjams_client_participation(cis_client_id);
create index Xie2_tb_cjams_client_participation on tb_cjams_client_participation(cjams_person_id);
create index Xie2_expungement on expungement(date(insertedon));