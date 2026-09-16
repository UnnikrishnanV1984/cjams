-- Data fix for all the exits that happened since go live and have a mismatch
UPDATE intakeservreqchildremoval
SET updatedon = exitdate, returntransts = exitdate, updatedby = 'admin-D-22599'
WHERE exitdate > '2019-10-26' and exitdate>updatedon;
--WHERE intakeservreqchildremovalid = 'e1309687-f1c3-431d-8691-2aa3d0b838c7';

-- In prod currently as of 12/17/2019 thare are 6 such scenarios
-- SELECT intakeservreqchildremovalid,exitdate,updatedon,returntransts,* FROM intakeservreqchildremoval WHERE exitdate > '2019-10-26' and exitdate>updatedon;
-- intakeservreqchildremovalid	        exitdate	        updatedon	        returntransts
-- 9a9e0313-24b6-4361-9adf-a16ca5536cdb	2019-11-04 09:00:00	2019-09-05 11:21:27	1900-01-01
-- 986ace6e-14e4-4215-b36b-3c5e60110946	2019-12-11 09:00:00	2019-09-06 10:26:41	1900-01-01
-- e1309687-f1c3-431d-8691-2aa3d0b838c7	2019-11-21 14:00:00	2018-07-13 14:37:30	1900-01-01
-- 06e2eada-4cbe-40db-a0c0-66260f4b8037	2019-11-22 09:00:00	2017-10-16 09:22:54	1900-01-01
-- a013c5d0-5149-45c0-82d8-2084df0fe219	2019-11-15 09:30:00	2019-02-21 14:33:22	1900-01-01
-- a688287b-6e85-4b74-b8b0-bba410024dfe	2019-11-16 00:00:00	2010-03-17 15:33:47	1900-01-01