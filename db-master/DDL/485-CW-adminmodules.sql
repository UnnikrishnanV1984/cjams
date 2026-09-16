drop table if exists adminmodules;


CREATE TABLE defecttracking.adminmodules(
   documentpropertiesid uuid PRIMARY KEY,
   filename VARCHAR (50) NOT NULL,
   category VARCHAR (50) NOT NULL,
   subcategory VARCHAR (50) NOT NULL,
   title  VARCHAR (100),
   description  VARCHAR (500),
   mime  VARCHAR (150),
   meta  VARCHAR (500),
   encoding  VARCHAR (50),
   uploadedon TIMESTAMP NOT NULL,
   uploadedby TIMESTAMP NOT NULL,
   expdate TIMESTAMP,
   insertedby TIMESTAMP,
   updatedby TIMESTAMP,
   startdate TIMESTAMP,
   enddate TIMESTAMP,
   searchkey VARCHAR (100),
   dataval VARCHAR (100),
   activeflag int4 NULL
);
