ALTER TABLE cjams.ivessissadata ADD column if not exists issilayouth varchar(10) NULL;
comment on column cjams.ivessissadata.issilayouth is 'to store value for is SILA Youth?';