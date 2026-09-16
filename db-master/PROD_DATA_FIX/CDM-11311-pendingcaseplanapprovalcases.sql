-- CDM-11311
update routing set activeflag = 1, updatedby = 'CDM-11311', updatedon = now() where objectid in ('feb129da-bb47-4e55-ab28-0838b9fd7267',
'a1f3a276-c859-4405-b8d7-1c6144344c59') and routingid in ('f0e962ad-7607-4ddc-b1f5-dfd198035ba8',
'9e87f187-7f27-475b-b35e-847a96df6776') and eventcode = 'CPLAN2' and activeflag = 0;