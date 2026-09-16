UPDATE cjams.providermaltreatmenttype
SET  typedescription='Family-based foster home',updatedby='CIDM-4929', updatedon= now()
WHERE providermaltreatmenttypekey='FCPS';

UPDATE cjams.providermaltreatmenttype
SET  typedescription='Non-Family Based setting',updatedby='CIDM-4929', updatedon= now()
WHERE providermaltreatmenttypekey='PP';