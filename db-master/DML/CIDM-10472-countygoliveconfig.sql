--------------------------------------

-- 06/11/2024 - CIDM-10472 - Enable Pilot counties for Large File Upload
--Baltimore City
--Baltimore County
--Washington
-----------------------------------------

DELETE FROM cjams.countygoliveconfig
WHERE countygoliveconfigid = '6531cb7f-17d3-40ee-9044-c216be121e77';

INSERT INTO cjams.countygoliveconfig
(countygoliveconfigid, objecttype, statewide, charles, washington, stmarys, annearundel, frederick, garrett, carroll, allegany, princegeorge, montgomery, calvert, baltimorecity, baltimorecounty, caroline, dorchester, kent, queenannes, somerset, wicomico, worcester, cecil, talbot, harford, howard, dhris, insertedon, insertedby, updatedon, updatedby, activeflag)
VALUES('6531cb7f-17d3-40ee-9044-c216be121e77', 'large-file-upload', current_date, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, now(), 'CIDM-10472', now(), 'CIDM-10472', 1);
