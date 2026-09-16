UPDATE intakeservicerequest 
SET intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', actiontype = null, updatedon = now(), updatedby = 'CDM-1424'
WHERE  intakeserviceid in ('9104562f-166f-4d3f-8555-5e6e6cbab483',
'354bf90f-9041-488d-9b2d-4bf38139bf40',
'7d480987-2319-430f-83f0-5a9bddac3ee1',
'ca6d584d-dda3-40aa-979d-175a787392b8');