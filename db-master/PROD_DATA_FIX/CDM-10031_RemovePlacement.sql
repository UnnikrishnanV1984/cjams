-- CDM-10031 - Remove placement from placement history

update placement set activeflag = 0, updatedby = 'CDM-10031', updatedon = now() where placementid='ca27efbb-f707-4bd7-a89f-aefd20599627' and activeflag =1; 
