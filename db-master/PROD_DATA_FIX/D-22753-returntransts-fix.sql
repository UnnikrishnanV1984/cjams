UPDATE intakeservreqchildremoval
SET returntransts = updatedon::date
WHERE exitdate > '2019-10-26' AND (returntransts IS NULL OR returntransts < exitdate::date);

-- SELECT intakeservreqchildremovalid,exitdate,updatedon,returntransts,* FROM intakeservreqchildremoval WHERE exitdate > '2019-10-26'
-- AND (returntransts IS NULL OR returntransts < exitdate::date);

-- In prod currently as of 12/26/2019 thare are only 2 such scenarios
-- intakeservreqchildremovalid	exitdate	updatedon	returntransts	intakeservreqchildremovalid
-- 0d4c0a99-2ed4-405a-ab31-e075311acc78	2019-11-19 15:00:00	2019-11-20 14:03:09	1900-01-01	0d4c0a99-2ed4-405a-ab31-e075311acc78
-- cf20a1f4-c0d4-4808-98a4-9a18a3bd6448	2019-12-20 09:00:00	2019-12-23 08:37:47	[NULL]	cf20a1f4-c0d4-4808-98a4-9a18a3bd6448