 UPDATE placement 
 SET activeflag = 0, updatedon = now(), updatedby = 'CDM-1323'
 WHERE placementid in (
  '025eb172-9219-4f52-b6d2-77534d374343',
  '654e8d00-9994-4614-b724-18f213f24a76',
  '99b75dbb-6089-4064-9d09-b5028d1f98f9',
  '501e60ed-a155-43ab-88e1-27cd5b6794c3');
