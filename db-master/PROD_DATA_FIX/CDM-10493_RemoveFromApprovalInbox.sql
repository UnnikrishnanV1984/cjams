-- CDM-10493 - Remove records from approval inbox

update routing set activeflag =0, updatedby = 'CDM-10493', updatedon = now() where routingid in ('6de5a7a9-04d7-44ea-b904-c98891e6b64d','640e2a89-d71f-40da-8809-078c6e05542e') and activeflag =1;
