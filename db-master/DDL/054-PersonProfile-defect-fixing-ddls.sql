ALTER TABLE cjams.personaddress ALTER COLUMN danger TYPE int4 USING danger::int4;

ALTER TABLE investigationallegation ADD COLUMN victim_explanation VARCHAR(250),
								 ADD COLUMN sibling_explanation VARCHAR(250),
                                 ADD COLUMN guardian_explanation VARCHAR(250),
                                 ADD COLUMN maltreator_explanation VARCHAR(250),
                                 ADD COLUMN med_assessmnts VARCHAR(250),
                                 ADD COLUMN expert_assessmnts VARCHAR(250),
								 ADD COLUMN collateral_interviews VARCHAR(250),
								 ADD COLUMN criminal_history_inv VARCHAR(250),
								 ADD COLUMN home_conditions VARCHAR(250);