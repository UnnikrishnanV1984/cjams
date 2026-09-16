update routingstatustype set typedescription='Accepted' where sequencenumber=84;
ALTER TABLE publicproviderhouseholdmember ALTER COLUMN household_member_id DROP NOT NULL;
alter table publicproviderhouseholdmember add column if not exists personid uuid null;
