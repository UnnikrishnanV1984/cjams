CREATE TABLE if not exists expungementstaging(
   mdm_id VARCHAR (50) , 
   cjamspid bigint ,
   cisclientid VARCHAR (10) ,
   DateOfExpungement TIMESTAMP ,
   case_number varchar(100),
   status_flag integer,
   insertedon TIMESTAMP
);

CREATE TABLE  if not exists expungementoutbound(
   mdm_id VARCHAR (50) , 
   cjamspid bigint ,
   cisclientid VARCHAR (10) ,
   DateOfExpungement TIMESTAMP ,
   case_number varchar(100),
   status_flag integer,
   insertedon TIMESTAMP,
   updatedon TIMESTAMP
);