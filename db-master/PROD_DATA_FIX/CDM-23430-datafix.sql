-- CDM-23430

update gapagreementrate set activeflag = 0, updatedby = 'CDM-23430', updatedon = now() 
where gapagreementid = '7d8d41cb-7e81-4767-80ed-3a95c5f69e86' and gapagreementrateid = '7b6d69e1-22ec-4363-993e-12ac6d528e85';

update routing set activeflag = 0, updatedby = 'CDM-23430', updatedon = now() 
where objectid  = '7b6d69e1-22ec-4363-993e-12ac6d528e85' and activeflag = 1;

update gapratesrevision g set approvaldate =now(), activeflag = 0, updatedby = 'CDM-23430', updatedon = now() 
where gaprateid = '7b6d69e1-22ec-4363-993e-12ac6d528e85';
