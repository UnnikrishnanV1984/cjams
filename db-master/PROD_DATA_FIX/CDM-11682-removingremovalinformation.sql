
-- Removing Removal info
update intakeservreqchildremoval i set activeflag = 0, updatedby = 'CDM-11682', updatedon = now() where removalid  = '251657' and activeflag = 1;

-- Placement and livingarrangement removal
update placement p set activeflag = 0, updatedby = 'CDM-11682', updatedon = now() where placementid = '5b3cccd1-63f1-4a31-9c02-093074d56802' and activeflag = 1;
update placementrevision p set activeflag = 0, updatedby = 'CDM-11682', updatedon = now() where placementid = '5b3cccd1-63f1-4a31-9c02-093074d56802' and activeflag = 1;
update livingarrangement p set activeflag = 0, updatedby = 'CDM-11682', updatedon = now() where placementid = '5b3cccd1-63f1-4a31-9c02-093074d56802' and activeflag = 1;

-- person program removal
update personprogramarea p set activeflag = 0, updatedby = 'CDM-11682',updatedon = now() where personprogramid = 'cc7a8780-f3b2-4bb7-9dbc-e5c53063e6c8' and entityid = '202106306379';
