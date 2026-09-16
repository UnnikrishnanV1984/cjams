--------------------------------------

-- 06/11/2024 - CIDM-10566 - Enable Pilot counties for Psychotropic User story
--Garrett
--Allegany
--Washington
--Frederick
-----------------------------------------

DELETE FROM cjams.countygoliveconfig
WHERE countygoliveconfigid = '1fbfccc2-0442-4715-ada0-5219e2d2e41b';

INSERT INTO cjams.countygoliveconfig
(countygoliveconfigid, objecttype, statewide, charles, washington, stmarys, annearundel, frederick, garrett, carroll, allegany, princegeorge, montgomery, calvert, baltimorecity, baltimorecounty, caroline, dorchester, kent, queenannes, somerset, wicomico, worcester, cecil, talbot, harford, howard, dhris, insertedon, insertedby, updatedon, updatedby, activeflag)
VALUES('1fbfccc2-0442-4715-ada0-5219e2d2e41b', 'psycotrophic-hcdm', NULL, NULL, current_date, NULL, NULL, current_date, current_date, NULL, current_date, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, now(), 'CIDM-10566', now(), 'CIDM-10566', 1);

DELETE FROM cjams.countygoliveconfig
WHERE countygoliveconfigid = '5e0eea07-5ce6-4755-a473-6e7247b0b9bd';

INSERT INTO cjams.countygoliveconfig
(countygoliveconfigid, objecttype, statewide, charles, washington, stmarys, annearundel, frederick, garrett, carroll, allegany, princegeorge, montgomery, calvert, baltimorecity, baltimorecounty, caroline, dorchester, kent, queenannes, somerset, wicomico, worcester, cecil, talbot, harford, howard, dhris, insertedon, insertedby, updatedon, updatedby, activeflag)
VALUES('5e0eea07-5ce6-4755-a473-6e7247b0b9bd', 'psycotrophic-secondary-review', NULL, NULL, current_date, NULL, NULL, current_date, current_date, NULL, current_date, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, now(), 'CIDM-10566', now(), 'CIDM-10566', 1);
