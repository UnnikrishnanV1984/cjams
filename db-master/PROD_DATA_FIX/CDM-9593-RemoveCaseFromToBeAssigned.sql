-- CDM-9593 - Remove case from to be assigned list

update routing set activeflag = 0, updatedby = 'CDM-9593', updatedon = now() where objectid = 'I201900355485' and activeflag = 1;