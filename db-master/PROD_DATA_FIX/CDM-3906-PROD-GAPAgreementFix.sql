update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-3906'
where routingid in ('01de30bb-326b-4283-82db-f52971727c04','def6add1-33dd-49de-b377-8729b695712d');

update gapagreement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-3906'
where gapagreementid = '0247dccd-fa43-44a2-969d-0e698d3e8df3';