CREATE TABLE defecttracking.contactsupportlog (
	id serial NOT NULL,
	requestid varchar NULL,
	typeofpayload varchar NULL,
	payload varchar NULL,
	issueid varchar NULL,
	activeflag int4 NULL DEFAULT 1,
	insertedby varchar NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar NULL,
	updatedon timestamp NULL DEFAULT now(),
	servicetype varchar NULL
);