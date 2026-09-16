-- CDM-10211 - Remove cases from to be assigned

update routing set activeflag =0, updatedby = 'CDM-10211', updatedon = now() where routingid in ('ee8e4034-097c-4974-81bf-dd4f201b9956','523a0112-4c2b-44f4-ad50-1c2d46be2238','a7ea16b1-ae17-4a81-95f9-30e073361af8','ece14efb-ec43-4ab6-ae19-31f9490630cc') and activeflag =1;
