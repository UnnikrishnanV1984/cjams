CREATE TABLE cjams.permanencyplanhistory (
	permanencyplanhistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
	permanencyplanid uuid NULL,
	intakeservicerequestactorid uuid NULL,
	intakeserviceid uuid NULL,
	servicecaseid uuid NULL,
	placementid uuid NULL,
	projecteddate timestamp NULL,	 
	establisheddate timestamp NULL,
	enddate timestamp NULL,
	caseworkername varchar(100) NULL,
 	status varchar(20) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NOT NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NOT NULL 
);