-- CDM-10813
update intakeservreqchildremoval set removaldate  = '2020-10-30 00:00:00',removaltime = '2020-10-30 18:08:00' , updatedon = now(), updatedby = 'CDM-10813' where removalid in (251234,251235);
update placement set startdatetime = '2020-10-30 00:00:00', updatedon = now(), updatedby = 'CDM-10813' where placementid in ('812fbdf3-72c8-4e10-9585-e953f66ee589','f40c8eb6-b263-443e-885b-a4d25347ad29');
update placementrevision p set entrydate = '2020-10-30 00:00:00' where placementid in ('812fbdf3-72c8-4e10-9585-e953f66ee589','f40c8eb6-b263-443e-885b-a4d25347ad29') and placementrevisionid in ('44155b44-9ee3-43fa-a86d-144cf9d1e8c4','6dde1196-72a6-4921-97a4-f6d65a2e30db');
