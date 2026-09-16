--CDM-7642 2020033704522:Removal CORRECT start date SHOULD BE 11/20/20.


UPDATE intakeservreqchildremoval SET removaldate = '2020-11-20 00:00:00', updatedon = now() WHERE 
intakeservreqchildremovalid = 'e0156c6b-8b17-4a11-a0da-ef4eed68a321' AND activeflag = 1 AND removaldate = '2020-11-23 00:00:00';
