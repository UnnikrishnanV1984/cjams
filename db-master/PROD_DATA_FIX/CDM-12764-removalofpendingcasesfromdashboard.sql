update routing set activeflag = 0, updatedon = now(),updatedby = 'CDM-12764' where routingid in ('a8b51b90-1f9e-4bcc-a7b1-8568e5dc78a6',
'60019873-6fdc-427a-93b4-fb2dead59d54') and activeflag = 1;