-- CDM-17706 fix - Remove Service plan review reocrod from approval dashboard.

update routing set activeflag = 0, updatedby = 'CDM-17706', updatedon = now() 
where routingid in ('0c8ca705-4fb5-4bfd-858a-bdb864a7dd81','42c72404-12d2-4653-b425-8b79aebb172a','65b0ecde-1efa-4ef4-90c4-50d508705751','239f8c0e-ee79-4883-a2c9-ab215e6f6fd0','5bdb66ac-dca2-4727-ab53-7b7bee1387d3') and activeflag =1 and routingstatustypeid = 15 and eventcode = 'SPLAN';