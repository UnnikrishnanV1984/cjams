update routing set activeflag = 0, updatedon = now(),updatedby = 'CDM-12702' where routingid in (
'af40bd10-8c89-4c5d-921d-47ffacfa0773',
'558de63d-5601-4359-a3c7-6cd6388a01de',
'f00ee80f-38fe-4f7b-8240-e9b67346cdf2'
);