ALTER TABLE investigationfinding
ADD COLUMN "victim_explanation" character varying,
ADD COLUMN "sibling_explanation" character varying,
ADD COLUMN "guardian_explanation" character varying, 
ADD COLUMN "maltreator_explanation" character varying,
ADD COLUMN "med_assessmnts" character varying, 
ADD COLUMN "expert_assessmnts" character varying, 
ADD COLUMN "collateral_interviews" character varying, 
ADD COLUMN "criminal_history_inv" character varying, 
ADD COLUMN "home_conditions" character varying;
