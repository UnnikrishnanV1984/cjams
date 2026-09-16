 update routing set activeflag = 0, updatedby = 'CDM-13340', updatedon = now() where routingid in (
'039cfd34-a1ac-43c8-9d24-1cf9e73ee490',
'bd5fe600-386b-47d9-8207-b7d9f11e0a58',
'97e9ab1e-77fe-4b3e-a18c-25ec411afe0d',
'b517d96c-0938-4a37-bdec-cd746a0c75c1'
);