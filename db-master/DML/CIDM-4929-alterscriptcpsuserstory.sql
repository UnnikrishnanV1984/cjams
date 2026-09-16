alter table improviderswitchinfo add column if not exists providerhistory boolean null;
alter table improviderswitchinfo add column if not exists fostercarecheckbox boolean null;

COMMENT ON COLUMN cjams.improviderswitchinfo.providerhistory IS 'To get the history check box for provider details';
COMMENT ON COLUMN cjams.improviderswitchinfo.fostercarecheckbox IS 'To get reason for change of providers';