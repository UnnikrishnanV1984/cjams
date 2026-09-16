ALTER TABLE adoptioncaserevision 
RENAME COLUMN agreementstartdate TO startdate;

ALTER TABLE adoptioncaserevision 
RENAME COLUMN agreementenddate TO enddate;

ALTER TABLE adoptioncaserevision 
RENAME COLUMN paymentamt TO paymentamout;

ALTER TABLE adoptioncaserevision 
RENAME COLUMN "comments" TO notes;

ALTER TABLE adoptioncaserevision 
RENAME COLUMN isssaapproval TO isssaapproved;

ALTER TABLE adoptioncaserevision 
RENAME COLUMN ssaapprovaldate TO ssaapproveddate;

ALTER TABLE adoptioncaserevision 
RENAME COLUMN ischildmedicallyfragile TO isspeacialneeds;

ALTER TABLE adoptioncaserevision 
RENAME COLUMN primbasissplneedstypekey TO specialneedtypekey;

ALTER TABLE adoptioncaserevision 
RENAME COLUMN agreementrateid TO adoptionagreementrateid;

ALTER TABLE adoptioncaserevision
RENAME COLUMN providerid TO provider_id;

ALTER TABLE adoptioncaserevision
ADD COLUMN isapproval integer NULL,
ADD COLUMN parent1providername varchar(100) NULL,
ADD COLUMN parent2providername varchar(100) NULL,
ADD COLUMN childrelationship varchar(50) NULL,
ADD COLUMN effectivedate timestamp NOT NULL DEFAULT now(),
ADD COLUMN specialneedremarks varchar(200) NULL,
ADD COLUMN rateoverwrittensw bpchar(1) NULL,
ADD COLUMN status varchar(50) NULL;