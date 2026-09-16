drop table if exists defecttracking.helpdocuments;

CREATE TABLE defecttracking.helpdocuments(		
helpdocumentsid uuid PRIMARY KEY,	
title TEXT,	
filename TEXT,	
filetype VARCHAR(50),	
category VARCHAR(50) NOT NULL,		
subcategory VARCHAR(50),		
description  VARCHAR(500),		
filecontent bytea,	
mime  VARCHAR(150),		
meta  VARCHAR(500),		
encoding  VARCHAR(50),		
numberofbytes int4,		
effectivestartdate TIMESTAMP, 	
effectiveenddate TIMESTAMP,
searchkey 	TEXT,	
insertedon TIMESTAMP,		
insertedby VARCHAR(100),		
updatedon TIMESTAMP,		
updatedby VARCHAR(100),		
activeflag int4		  		
);
