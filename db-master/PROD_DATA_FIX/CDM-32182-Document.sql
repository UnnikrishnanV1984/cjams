/*
   Issue Description: CDM-32182
   Category/ Module  : Prod data fix to update correct inserted user details 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/ 

-- ff85645e-6fdd-4ea8-8d2c-ecdad5007a5e    HeatherStrosnider    398ee31a-9887-410c-a473-c757c7007917
-- 856908af-c2a0-4e55-ab1a-6d93c4baceeb    HeatherStrosnider    3b88b658-ff68-4f70-b59f-904dd2c01163
-- 9be29715-c681-4c0c-856d-79a188287244    KimberlyKyle    e524bf90-e0dd-45c8-a609-31cc83e2c915
-- a43d0423-d1ff-4ae3-8df0-00e756a27979    HeatherStrosnider    f3927fdf-8c32-4a9b-b5e4-b57b9b792424
 
 update documentproperties set insertedby = '518e2289-9311-4416-ac68-a3f241150797', updatedby = 'CDM-32182', updatedon = now()
 where documentpropertiesid in 
('3b88b658-ff68-4f70-b59f-904dd2c01163','398ee31a-9887-410c-a473-c757c7007917','f3927fdf-8c32-4a9b-b5e4-b57b9b792424','e524bf90-e0dd-45c8-a609-31cc83e2c915');
	

    update documentattachment 
    set insertedby = '518e2289-9311-4416-ac68-a3f241150797', updatedby = 'CDM-32182', updatedon = now()
 where documentpropertiesid in 
('3b88b658-ff68-4f70-b59f-904dd2c01163','398ee31a-9887-410c-a473-c757c7007917','f3927fdf-8c32-4a9b-b5e4-b57b9b792424','e524bf90-e0dd-45c8-a609-31cc83e2c915');
	