create table adoptionapplicabilitysiblinginfo(
siblingid uuid NOT NULL DEFAULT gen_random_uuid(), 
adoptionapplicabilityid uuid NOT null,
nameofsiblingchild varchar(50) NOT NULL,
nameofsiblingchildsadoptiveplacement varchar(50) NOT NULL,
dateofsiblingsadoptiondecree timestamp NULL,
dateofsiblingsapplicablechildassessment timestamp NULL,
childssiblingsapplicabilitystatus varchar(50) null,
expectedchildadoptiveplacement  varchar(50) null,
siblingsrelationshipwithchild varchar(50),
constraint pk_adoptionapplicabilitysiblinginfo  primary key(siblingid),
constraint fk_adoptionapplicabilitysiblinginfo  foreign key (adoptionapplicabilityid)  references adoptionapplicabilityinfo(adoptionapplicabilityid)
)


