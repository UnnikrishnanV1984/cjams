ALTER TABLE adoptionapplicabilityinfo
ADD COLUMN caseworkername text;

ALTER TABLE adoptionapplicabilityinfo
ADD COLUMN submissiondate timestamp without time zone;


ALTER TABLE adoptionapplicabilityinfo
ADD COLUMN caseworkersignature text;


ALTER TABLE adoptionapplicabilityinfo
ADD COLUMN resubmissioncaseworkername text;


ALTER TABLE adoptionapplicabilityinfo
ADD COLUMN resubmissiondate timestamp without time zone;


ALTER TABLE adoptionapplicabilityinfo
ADD COLUMN resubmissioncaseworkersignature text;


ALTER TABLE adoptionapplicabilityinfo
ADD COLUMN resubmissioncount integer;

