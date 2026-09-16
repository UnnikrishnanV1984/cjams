DROP TABLE IF EXISTS  cjams.reverserelationship;

CREATE TABLE cjams.reverserelationship (
   reverserelationshipid uuid PRIMARY key,
   relationshiptypekey character varying(50) NOT NULL,
   relationgendercode character varying(10),
   malereverserelationshiptypekey character varying(50),
   femalereverserelationshiptypekey character varying(50),
   insertedby character varying(50),
   insertedon timestamp without time zone,
   updatedby character varying(50),
   updatedon timestamp without time zone
);
