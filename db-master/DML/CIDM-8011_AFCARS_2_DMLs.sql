-- CIDM-8011 - AFCARS 2.0 code modifications for MD AFCARS 23A Data errors reported by ACF

-- Add new AFCARS reference codes for gender (referencetypeid = 301)
-- TGIF	Transgender- Identifies as Female
-- TGIM	Transgender- Identifies as Male


delete from cjams.afcars_ref_code where  reference_id in (67, 68) and afcars_ref_type = 'sex';

INSERT INTO cjams.afcars_ref_code
(reference_id, afcars_ref_cd, afcars_ref_type, cjams_cd, description, activeflag)
VALUES(67, '1', 'sex', 'TGIF', 'Data element: FC #7, A #6', 1);

INSERT INTO cjams.afcars_ref_code
(reference_id, afcars_ref_cd, afcars_ref_type, cjams_cd, description, activeflag)
VALUES(68, '2', 'sex', 'TGIM', 'Data element: FC #7, A #6', 1);
