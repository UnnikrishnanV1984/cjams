-- D-17413 remove Head of household from roles dropdown
DELETE FROM cjams.referencevalues
WHERE ref_key='CAH' AND referencetypeid=176;