DO $$
<<block1>>
DECLARE
placementIds UUID[] := ARRAY['0d1b44d0-f48e-4b1e-98ee-6212198385b0',
'c408ec2d-d15c-4b48-942e-a01ec30209a8'];

placementEndDate TEXT := '2022-01-20';

placementEndTime TEXT := '07:59';

placementEndDateTime TIMESTAMP := CONCAT(placementEndDate, ' ', placementEndTime, ':00.000');

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-21627';

BEGIN
UPDATE
  placement
SET
  enddatetime = placementEndDateTime,
  endtime = placementEndTime,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  placementid = ANY(placementIds)
  AND activeflag = 1;

UPDATE
  placementrevision
SET
  exitdate = placementEndDateTime,
  exittime = placementEndTime,
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  placementid = ANY(placementIds)
  AND activeflag = 1;

UPDATE
  tb_placement_validation
SET
  placement_exit_dt = placementEndDate::date,
  update_user_id = updateBy,
  update_ts = updateOn
WHERE
  placement_id IN (
  SELECT
    alternateid
  FROM
    placement
  WHERE
    placementid = ANY(placementIds)
      AND activeflag = 1);

UPDATE
  intakeservreqchildremoval
SET
  exitdate = '2022-02-18 00:00:00.000',
  updatedby = updateBy,
  updatedon = updateOn
WHERE
  intakeservreqchildremovalid IN ('4d9bef61-1aa4-4884-8857-b3afe68e788f', 'b176816f-2eeb-4e9f-a6db-5e5f45f6a7ca')
  AND activeflag = 1;
END block1 $$;
