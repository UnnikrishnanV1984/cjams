update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-3945'
where routingid = '4e8064ab-db44-4749-8796-6910340b3df4';

update gapagreement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-3945'
where gapagreementid = '2d8100a4-6b14-43a4-890f-d6e467a82dca';