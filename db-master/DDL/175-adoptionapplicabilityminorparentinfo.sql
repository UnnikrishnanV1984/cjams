create table adoptionapplicabilityminorparentinfo(
minorparentid uuid NOT NULL DEFAULT gen_random_uuid(), 
adoptionapplicabilityid uuid NOT null,
minorparentname varchar(50) NOT NULL,
birthdateofparent timestamp NULL,
removaltypeofminorparent varchar(50) null,
removalcourtorderdateofminorparent timestamp NULL,
removaldateofminorparent timestamp NULL,
minorparentscurrentplacementtype  varchar(50) null,
childscurrentplacementtype varchar(50) null,
physicaladdressofminorparent varchar(50) null,
constraint pk_adoptionapplicabilityminorparentinfo  primary key(minorparentid),
constraint fk_adoptionapplicabilityminorparentinfo  foreign key (adoptionapplicabilityid)  references adoptionapplicabilityinfo(adoptionapplicabilityid)
)