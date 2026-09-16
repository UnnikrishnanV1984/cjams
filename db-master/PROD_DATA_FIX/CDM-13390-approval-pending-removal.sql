update routing 
set activeflag = 0, updatedby = 'CDM-13390', updatedon = now()
where routingid in ('7237ee81-04b0-441f-b8fb-f736d50a3a15', 'b44c465f-513f-498f-b3e7-924be8bd5aec', 'be013905-ab64-4da8-99cf-07319190027c');
    