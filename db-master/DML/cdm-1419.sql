INSERT INTO cjams.intakeservreqchildremovalreason
(intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, activeflag, insertedby, insertedon, updatedby, updatedon, old_id, inputtypekey, otherdescription, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'f3b65707-c4c3-4ea4-a06c-262375d26846', 'REPERCH', 1, 'Datafix user as per CDM-1419', now(), 'Datafix user as per CDM-1419', now(), NULL, 'REPCR', NULL, NULL, NULL);


INSERT INTO cjams.intakeservreqchildremovalreason
(intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, activeflag, insertedby, insertedon, updatedby, updatedon, old_id, inputtypekey, otherdescription, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '6a7c6a0d-2c37-4f60-b251-af8fc414f3d9', 'REPERCH', 1, 'Datafix user as per CDM-1419', now(), 'Datafix user as per CDM-1419', now(), NULL, 'REPCR', NULL, NULL, NULL);


update cjams.Intakeservreqchildremoval SET agencytypekey = 'AFH',
comments = 'On January 28, 2020 it was discovered that Stefany had bruising on her hand and arm and a white line on her back as a result of her grandmother, Maria Garcia, beating her with a belt. Suleyma Garcia was unable to protect the children''s from Maria Garcia and when she attempted to intervene, Maria Garcia was violent towards her. Additionally, Suleyma Garcia was unable to meet the childrens mental health needs as Stefany is diagnosed with Major Depressive Disorder with Psychotic Features and Social Anxiety. At the time of shelter, Stefany self-harmed, made numerous suicidal attempts, and was hospitalized at Brooklane on multiple occasions. Additionally, Ms. Garcia did not follow the recommendations of Brooklane. Esmeralda also has a history of suicidal ideations and self-harming behaviors and had previously been hospitalized. A Family Involvement Meeting was held on 2/11/20 at which time it was determined that Esmeralda and Stefany would be sheltered'
WHERE intakeservreqchildremovalid = 'f3b65707-c4c3-4ea4-a06c-262375d26846';


update cjams.Intakeservreqchildremoval SET agencytypekey = 'AFH',
comments = 'On January 28, 2020 it was discovered that Stefany had bruising on her hand and arm and a white line on her back as a result of her grandmother, Maria Garcia, beating her with a belt. Suleyma Garcia was unable to protect the children''s from Maria Garcia and when she attempted to intervene, Maria Garcia was violent towards her. Additionally, Suleyma Garcia was unable to meet the childrens mental health needs as Stefany is diagnosed with Major Depressive Disorder with Psychotic Features and Social Anxiety. At the time of shelter, Stefany self-harmed, made numerous suicidal attempts, and was hospitalized at Brooklane on multiple occasions. Additionally, Ms. Garcia did not follow the recommendations of Brooklane. Esmeralda also has a history of suicidal ideations and self-harming behaviors and had previously been hospitalized. A Family Involvement Meeting was held on 2/11/20 at which time it was determined that Esmeralda and Stefany would be sheltered'
WHERE intakeservreqchildremovalid = '6a7c6a0d-2c37-4f60-b251-af8fc414f3d9';









