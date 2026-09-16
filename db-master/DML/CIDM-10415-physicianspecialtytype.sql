UPDATE cjams.physicianspecialtytype
SET updatedby='CIDM-10415', updatedon=now(), teamtypekey='AS'
WHERE physicianspecialtytypekey in ('ED','PYSCH','THP','UR','PUL');