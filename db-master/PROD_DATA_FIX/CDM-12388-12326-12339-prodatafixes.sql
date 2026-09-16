-- CDM-12388				
update routing set activeflag = 0,updatedby = 'CDM-12388',updatedon = now() where routingid = 'd6baaeec-e6ec-493a-b10f-b13e12aa83ee' and objectid = '41ee2039-cc66-4c62-85f1-a3b39eb8afda';


-- CDM-12326 -- 2021-04-02 19:00:00
update  intakeservreqchildremoval i set exitdate = null,updatedby = 'CDM-12326',updatedon = now() where intakeservreqchildremovalid = '2cdbd9f1-8626-425e-a908-2ea25c04df90';
update personprogramarea p set enddate = null,updatedon = now() where personprogramid = 'e1e069db-1bcb-47b5-8f3e-b5196fd16266';

-- CDM-12339
update documentproperties d set activeflag = 0,updatedby = 'CDM-12339',updatedon = now() where documentpropertiesid = '810b2e27-15ab-4a0f-9cf7-4ab3f121d540';
