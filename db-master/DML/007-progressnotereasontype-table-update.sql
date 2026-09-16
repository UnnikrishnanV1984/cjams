--Nirmal

update progressnotereasontype set typedescription='Family Finding - Member Contact' where typedescription='FF - Member Contact' 
and progressnotereasontypekey='FMC';
 
DELETE FROM progressnotereasontype where progressnotereasontypekey='ICPS' and  typedescription='Investigation & CPS';
INSERT INTO progressnotereasontype
( progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES( 'ICPS', 1, 'Investigation & CPS', now(), 'admin', 'admin', current_date, current_date, '');