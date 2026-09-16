-- CDM-10825
update documentproperties set servicecaseid  = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()  where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6'; 
update assessment set objectid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where objectid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';
update intakeservicerequestpetition set servicecaseid = '12f3ab6e-1065-41ef-9991-a2f51e0940b6', updatedby = 'CDM-10825', updatedon = now()
where servicecaseid = 'b399410e-acd8-485c-a859-b9a6c336ddd6';