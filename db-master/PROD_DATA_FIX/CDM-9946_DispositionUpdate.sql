-- CDM-9946 - Already approved disposition but again submitted for closure.

update routing set activeflag =0, updatedby = 'CDM-9946', updatedon = now() where routingid = 'f4ee1b30-9f4b-4995-af47-e1e3a061be5d';