update investigationallegation set activeflag = 0, updatedby = 'CDM-12220',updatedon = now() where investigationallegationid in (
'25dcb3e1-ec29-4897-a4b6-7085cd5a2f50',
'b426456a-f49d-4565-bc8d-e9d067412607',
'b3099a3b-63e0-4c3e-af7b-b37233b54945',
'905aa222-331d-48eb-bb5d-6eb27e067106'
) and investigationid = '0ac350cc-afe3-490d-9bf7-4af3a708a3ac' and activeflag = 1;