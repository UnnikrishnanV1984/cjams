
-- Inserting new Intake service NON_CPS with hard coded id '3d073640-40fa-4160-aa5b-00083c3d12c0'
    INSERT INTO intakeserv ("intakeservid","intakeservtypekey", "description") 
	VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','NONCPS', 'Non-CPS') ;
-- Inserting in agency service table with '3d073640-40fa-4160-aa5b-00083c3d12c0'- NON CPS mapped to 'd207bdd4-f281-4ec8-949c-8fd9657227f9' - Request for services
	INSERT INTO intakeagencyserv ("intakeservid", "intakeservreqtypeid", "teamtypekey")	
	VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','d207bdd4-f281-4ec8-949c-8fd9657227f9','CW');

-- Inserting 43 rows in subtype of 'NON-CPS'
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','2634', 'Family Preservation');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','2635' , 'Foster Care');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','5730' , 'ROA');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6451' , 'Adoptions');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6452' , 'In Home Family Services');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6453' , 'Services To Family - SFC');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6455' , 'Other - Local Specific Services');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6456' , 'Other');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6457' , 'Safe Haven');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6460' , 'Voluntary Placement');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6461' , 'Environmental Emergency');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6463' , 'ICPC');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6954' , 'Child with Disability VPA');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6955' , 'Foster Care Home Study');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6956' , 'ROA (Adoptive)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6957' , 'ROA (CPS)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6958' , 'ROA (Foster Care)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6959' , 'ROA (SFC)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6960' , 'Time Limited VPA');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','1' , 'Adoption (Post Services)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33388' , 'IFPS - DSS');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33389' , 'IFPS - DJS');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33390' , 'IFPS - MHA');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33391' , 'IFPS - DDA');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33392' , 'IFPS - LSS');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33393' , 'IFPS - ADAA');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33394' , 'IFPS - Other');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','7198' , 'Custody and Guardianship');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33398' , 'Independent Living Aftercare In-State');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33399' , 'Independent Living Aftercare Out-of-State');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33406' , 'Adoption (Private)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','7199' , 'ROA(Ex Parte)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','7200' , 'ROA(Home Assessment)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','32944' , 'Information to Active Worker');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33284' , 'ROA INS (In-Home Services)');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','33396' , 'IFPS - Health Department');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','6454' , 'Combined Services');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','16002' , 'Kinship Navigator - Support Groups');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','16003' , 'Kinship Navigator - Information & Referral');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','16004' , 'Kinship Navigator - Family Kin Connections');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','7201' , 'Independent Living Aftercare VPA');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','7202' , 'Human Trafficking');
INSERT INTO intakeservsubtype ("intakeservid","intakeservsubtypekey","typedescription") VALUES('3d073640-40fa-4160-aa5b-00083c3d12c0','7203' , 'Human Trafficking Information to Active Worker');
