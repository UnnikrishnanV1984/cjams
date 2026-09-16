alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason1 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason2 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason3 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason4 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason5 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason6 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason7 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason8 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason9 character varying;




COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason1 IS 'Skip Reason one for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason2 IS 'Skip Reason two for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason3 IS 'Skip Reason three for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason4 IS 'Skip Reason one for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason5 IS 'Skip Reason two for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason6 IS 'Skip Reason three for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason7 IS 'Skip Reason one for Initial Contact Caregiver';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason8 IS 'Skip Reason two for Initial Contact Caregiver';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason9 IS 'Skip Reason three for Initial Contact Caregiver';
