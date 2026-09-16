-- CDM-10328 - remove service plan from the user dashboard

update routing set activeflag = 0, updatedby = 'CDM-10328', updatedon = now() where routingid = 'bab9b0ac-05f1-4aca-b64c-b4be731cf79d' and activeflag = 1;