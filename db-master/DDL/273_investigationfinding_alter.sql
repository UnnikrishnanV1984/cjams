--Internal defect Investigation
ALTER TABLE investigationallegation
ALTER COLUMN victim_explanation TYPE text;

ALTER TABLE investigationallegation
ALTER COLUMN sibling_explanation TYPE text;

ALTER TABLE investigationallegation
ALTER COLUMN guardian_explanation TYPE text;

ALTER TABLE investigationallegation
ALTER COLUMN maltreator_explanation TYPE text;

ALTER TABLE investigationallegation
ALTER COLUMN med_assessmnts TYPE text;

ALTER TABLE investigationallegation
ALTER COLUMN expert_assessmnts TYPE text;

ALTER TABLE investigationallegation
ALTER COLUMN collateral_interviews TYPE text;

ALTER TABLE investigationallegation
ALTER COLUMN criminal_history_inv TYPE text;

ALTER TABLE investigationallegation
ALTER COLUMN home_conditions TYPE text;