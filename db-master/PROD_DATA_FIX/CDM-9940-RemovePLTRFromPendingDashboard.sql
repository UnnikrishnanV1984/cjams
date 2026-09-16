-- CDM-9940 - Remove placement review from case pending approval of the user

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-9940' where routingid = '54c5ca05-31db-47dc-babf-5ee184bc332d' and activeflag = 1;
