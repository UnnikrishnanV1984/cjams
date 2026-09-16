delete from referencevalues where referencetypeid in ( 319,320,321,322,323,324,325,326,327,328,329,330,331,336,337);

delete from referencetype where referencetypeid in ( 319,320,321,322,323,324,325,326,327,328,329,330,331,336,337);

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(319, 'Sexual Orientation', 'sexualorientation', 1, NULL, now(), NULL,now(), NULL);


INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(320, 'Gender Identity', 'genderidentity', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SXO1',319,'Heterosexual','Heterosexual','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SXO2',319,'Homosexual/Gay/Lesbian','Homosexual/Gay/Lesbian','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SXO3',319,'Bisexual','Bisexual','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SXO4',319,'Pansexual (any sexual identity)','Pansexual (any sexual identity)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SXO5',319,'Other (specify)','Other (specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SXO6',319,'Unknown','Unknown','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);


--delete from referencevalues where referencetypeid in ( 321,322,323,324,325,326,327,328,329,330,331,336,337);

--delete from referencetype where referencetypeid in ( 321,322,323,324,325,326,327,328,329,330,331,336,337);

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(321, 'Mobility', 'mobility', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('MBSH1',321,'Other (specify)','Other (specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('MBSH2',321,'Runs','Runs','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('MBSH3',321,'Sits','Sits','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('MBSH4',321,'Stands','Stands','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('MBSH5',321,'Walks','Walks','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('MBSH6',321,'Little/None','Little/None','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(322, 'Speech', 'spch', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SPCH1',322,'Other (specify)','Other (specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SPCH2',322,'Phrases','Phrases','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SPCH3',322,'Sentences','Sentences','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SPCH4',322,'Single Words','Single Words','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);


INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(323, 'Diet Type', 'diettype', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE1',323,'Kosher','Kosher','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE2',323,'Low Calorie','Low Calorie','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE3',323,'Low Sodium','Low Sodium','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE4',323,'Muslim','Muslim','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE5',323,'Other(Specify)','Other(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE6',323,'Regular','Regular','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE7',323,'Soy','Soy','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE8',323,'Special(Specify)','Special(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE9',323,'Vegan','Vegan','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE10',323,'Vegetarian(dairy only)','Vegetarian(dairy only)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('DTYE11',323,'Vegetarian(dairy/eggs)','Vegetarian(dairy/eggs)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(324, 'Eater Type', 'eatertype', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ETTY1',324,'Avearge','Avearge','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ETTY2',324,'Healthy','Healthy','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ETTY3',324,'Other(Specify)','Other(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ETTY4',324,'Picky','Picky','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ETTY5',324,'Poor Appetite','Poor Appetite','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(325, 'Liquids', 'liquids', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('LIQ1',325,'Breast Fed','Breast Fed','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('LIQ2',325,'Drinks from Cup','Drinks from Cup','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('LIQ3',325,'Other(Specify)','Other(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('LIQ4',325,'Feeds Self','Feeds Self','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('LIQ5',325,'Bottle fed','Bottle fed','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('LIQ6',325,'Unknown','Unknown','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(326, 'Feeding Position', 'feedingposition', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FEP1',326,'Lap','Lap','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FEP2',326,'Table','Table','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FEP3',326,'Other(Specify)','Other(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FEP4',326,'High Chair','High Chair','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FEP5',326,'Unknown','Unknown','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(327, 'Solid Food', 'Solidfood', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SOFD1',327,'Junior','Junior','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SOFD2',327,'Organic Foods','Organic Foods','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SOFD3',327,'Other(Specify)','Other(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SOFD4',327,'Strained','Strained','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SOFD5',327,'Table Food','Table Food','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SOFD6',327,'Unknown','Unknown','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SOFD7',327,'Ground Food','Ground Food','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);


INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(328, 'Feeding - Other Needs', 'feedingotherneeds', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON1',328,'Nasogastric Tube (NG - Tube)','Nasogastric Tube (NG - Tube)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON2',328,'Nutrition Supplement','Nutrition Supplement','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON3',328,'Other(Specify)','Other(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON4',328,'Pacifier','Pacifier','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON5',328,'Special Nipple','Special Nipple','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON6',328,'Sucks Finger','Sucks Finger','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON7',328,'Thumb Sucker','Thumb Sucker','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON8',328,'Unknown','Unknown','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('FON9',328,'Gastrotomy Intestinal Tube(G-Tube)','Gastrotomy Intestinal Tube(G-Tube)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(329, 'Sleeping Environment', 'sleepingenvironment', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLEN1',329,'Crib','Crib','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLEN2',329,'Light Off','Light Off','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLEN3',329,'Light On','Light On','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLEN4',329,'Other(Specify)','Other(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLEN5',329,'Sleeps alone','Sleeps alone','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLEN6',329,'Sleeps with someone','Sleeps with someone','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLEN7',329,'Bed','Bed','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);


INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(330, 'Sleeping Problems', 'sleepingproblems', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLPR1',330,'Nightmares','Nightmares','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLPR2',330,'Phobia','Phobia','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLPR3',330,'Sleepwalking','Sleepwalking','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLPR4',330,'Other(Specify)','Other(Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLPR5',330,'Insomnia','Insomnia','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
--
INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(331, 'Sleeping Position', 'sleepingposition', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLPS1',331,'Side','Side','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLPS2',331,'Stomach','Stomach','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('SLPS3',331,'Back','Back','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);


INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(336, 'Elimination Current Status', 'eliminationcurrentstatus', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS1',336,'Cloth Diapers','Cloth Diapers','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS2',336,'Colostomy','Colostomy','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS3',336,'Disposable Diapers','Disposable Diapers','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS4',336,'Disposable Undergarments','Disposable Undergarments','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS5',336,'Either Cloth or disposable diapers','Either Cloth or disposable diapers','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS6',336,'Encopresis','Encopresis','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS7',336,'Enema','Enema','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS8',336,'Enuresis','Enuresis','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS9',336,'Other','Other','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS10',336,'Pull-Ups Diaper','Pull-Ups Diaper','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS11',336,'Rubber Pants','Rubber Pants','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS12',336,'Toilet trained','Toilet trained','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS13',336,'Training Pants','Training Pants','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('ELCS14',336,'Cathrization','Cathrization','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);


INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(337, 'Toilet Training Method', 'toilettrainingmethod', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('TTM1',337,'Pottie','Pottie','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('TTM2',337,'Regular Toilet Seat','Regular Toilet Seat','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('TTM3',337,'Toilet Seat Attachment','Toilet Seat Attachment','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) VALUES('TTM4',337,'Other (Specify)','Other (Specify)','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

