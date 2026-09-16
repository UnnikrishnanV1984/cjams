ALTER TABLE tb_ive_adoption_audit
ADD COLUMN incompletespecalistname text;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN incompletedate timestamp without time zone;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN incompletespecalistsignature text;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN decisionsubmissionspecalistname text;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN decisionsubmissiondate timestamp without time zone;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN decisionsubmissionspecalistsignature text;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN decisionresubmissionspecalistname text;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN decisionresubmissiondate timestamp without time zone;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN decisionresubmissionspecalistsignature text;

ALTER TABLE tb_ive_adoption_audit
ADD COLUMN resubmissioncount integer;
