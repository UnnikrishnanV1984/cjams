update routing set activeflag = 0, updatedon = now(),updatedby = 'CDM-11842' 
where routingid in ('6e5bc3bb-c129-4a6c-ba66-4964ffdd7d73','1fef55aa-0a2f-417f-b293-2d15ce1f2b26') and servicerequestnumber = '3232840' and eventcode = 'SCDR'
