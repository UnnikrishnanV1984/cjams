ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS Actual_Placement_After_Discharge  varchar NULL;
comment on column cjams.personhospitalization.Actual_Placement_After_Discharge is 'To record Actual Placement After Discharge value';



ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS hospitalization_discharge_recommendation_others  varchar NULL;
comment on column cjams.personhospitalization.hospitalization_discharge_recommendation_others is 'To record other hospitalization discharge recommendation value';


ALTER TABLE cjams.personhospitalization ADD COLUMN IF NOT EXISTS actual_placement_after_discharge_others  varchar NULL;
comment on column cjams.personhospitalization.actual_placement_after_discharge_others is 'To record other actual placement discharge recommendation value';