--D-12989/ CW-Field-Test- Contact Type Option of Face to Face not available
UPDATE progressnotetype 
SET progressnotetypekey = 'Face to Face' 
, updatedby = 'admin'
, updatedon = Now()
where progressnotetypekey = 'FaceToFace'
and description = 'Face to Face';

--D-12989/ Order of sort for Contact Purpose
update progressnotereasontype 
set typedescription = 'Parent Child Visit'
,updatedby = 'admin'
,updatedon = Now()
where typedescription = ' Parent Child Visit'
and activeflag = 1 
and progressnotereasontypekey = 'PCV';


