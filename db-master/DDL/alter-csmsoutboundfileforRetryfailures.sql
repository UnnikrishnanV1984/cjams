ALTER TABLE ivecsesoutbounddata add column if not exists csmsretryfailureflag boolean;
comment on column cjams.ivecsesoutbounddata.csmsfailureflag is 'Flag to identify the retry of the csms referrals';


ALTER TABLE ivecsesoutbounddata add column if not exists csmsretryuser varchar(20);
comment on column cjams.ivecsesoutbounddata.csmsretryuser is 'To get user details of the Retry for CSMS referrals';