ALTER TABLE ivecsesoutbounddata add column if not exists csmsfailureflag boolean;
comment on column cjams.ivecsesoutbounddata.csmsfailureflag is 'Flag to identify the CSMS Failures';