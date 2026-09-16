-- CDM-10482 - Removing cases assignment from IVE-Specialist dashboard
update routing set activeflag = 0 where objectid in (
'698f7c8b-8b26-4945-bb46-57259722c61c',
'688d949e-6aaa-43e6-8178-904afc42a469',
'731309b7-d73c-4228-951b-9c1f70cbd6ae',
'fb2e27ee-4f2b-408f-95c0-8811e123e0ac'
) AND eventcode='PLTR' AND tosecurityusersid::character varying='09e55a48-aef1-4543-9776-2c47d31319d1'
AND routing.routingstatustypeid::text in (16,70) and activeflag = 1;