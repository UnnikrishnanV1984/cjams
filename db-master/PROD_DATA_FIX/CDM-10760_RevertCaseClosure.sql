-- CDM-10760 - remove case closure record from disposition

update servicecasedisposition set activeflag =0, updatedby ='CDM-10760', updatedon = now() where servicecasedispositionid ='96342fcf-32f7-4e56-92b8-db49894be823' and activeflag =1;
