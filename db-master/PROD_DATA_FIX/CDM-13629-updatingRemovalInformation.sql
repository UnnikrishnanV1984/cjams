update intakeservreqchildremoval set agencytypekey = 'AFH' ,
primarycaregiveradd = '682 Middlesex Road, Essex, MD 21221',
isverifiedcaregiver1add  = 1,
updatedby = 'CDM-13629',
updatedon = now(), 
"comments" = 'On October 24, 2015 the district police contacted the agency to report alleged sexual abuse of Heaven Oxendine by her grandmother''s boyfriend, Keith Titus. Heaven reported to the district officer that Mr. Titus had touched her on her breasts and her vagina. Heaven stated that she told her grandmother, Diane Meadows, who did not believe her. Heaven was placed in an agency foster home, as Mr. Titus refused to leave the home and no relatives were able to provide care for Heaven. Heaven has resided with her grandmother for the last seven years.'
where removalid = '176367';

INSERT INTO cjams.intakeservreqchildremovalreason
(intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, activeflag, insertedby, insertedon, updatedby, updatedon, old_id, inputtypekey, otherdescription, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '74ef79eb-04fb-42d9-a0bf-a6cba2f48782', 'REPERCH', 1, 'CDM-13629', now(), 'CDM-13629', now(), NULL, 'REPCR', NULL, NULL, NULL);
