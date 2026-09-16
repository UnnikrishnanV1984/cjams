-- CDM-10560 - Remove Record from pending approval tab

 update routing set activeflag =0, updatedby = 'CDM-10560', updatedon = now() where routingid ='5fb0091a-c737-44fe-8c68-b8c33115aaf8' and activeflag = 1;