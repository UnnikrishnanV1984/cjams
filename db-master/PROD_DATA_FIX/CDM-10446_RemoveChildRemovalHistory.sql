-- CDM-10446 - Unnecessary record from child removal history

update intakeservreqchildremoval set activeflag =0 where intakeservreqchildremovalid ='f4e98ab0-290c-4d13-a4f9-09b93f63d562' and activeflag=1;