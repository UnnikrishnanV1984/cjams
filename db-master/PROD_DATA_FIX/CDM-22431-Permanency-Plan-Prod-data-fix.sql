/*
-- CDM-22431 - Permanency Plan appears in approval inbox, but all permanency plans have been approved.
*/

update routing set activeflag =0, updatedby = 'CDM-22431', updatedon = now() 
where routingid = 'f9c4d233-cefe-4670-a683-3e8c935f32f7';
