-- CIDM-8211 - AFCARS - Foster Care - E55 Element needs to be updated based on latest Business Logic

-- To capture the QRTP providers for AFCARS Element 55 logic
	
-- Arrow Child and Family group
-- 5000485 - Arrow Child & Family Ministries, Inc.
/* Hold on this one
INSERT INTO cjams.afcars_fc_qrtp_providers
	(provider_id, insertedby, insertedon, updatedby, updatedon, activeflag)
VALUES
	(5000485, 'CIDM-8211', now(), 'CIDM-8211', now(), 1);
*/

-- St. Vincent Villa
-- 5000543	Associated Catholic Charities Inc.	
INSERT INTO cjams.afcars_fc_qrtp_providers
	(provider_id, insertedby, insertedon, updatedby, updatedon, activeflag)
VALUES
	(5000543, 'CIDM-8211', now(), 'CIDM-8211', now(), 1);


-- Board of Child Care
-- 5000647 - Board of Child Care of the United Methodist Church, Incorporated
INSERT INTO cjams.afcars_fc_qrtp_providers
	(provider_id, insertedby, insertedon, updatedby, updatedon, activeflag)
VALUES
	(5000647, 'CIDM-8211', now(), 'CIDM-8211', now(), 1);
	
-- Cedar Ridge
-- 5001248 - Cedar Ridge Children's Home and School, Inc.
INSERT INTO cjams.afcars_fc_qrtp_providers
	(provider_id, insertedby, insertedon, updatedby, updatedon, activeflag)
VALUES
	(5001248, 'CIDM-8211', now(), 'CIDM-8211', now(), 1);


-- National Center for Children and Families
-- 5001352 - The National Center for Children and Families, Inc.	
INSERT INTO cjams.afcars_fc_qrtp_providers
	(provider_id, insertedby, insertedon, updatedby, updatedon, activeflag)
VALUES
	(5001352, 'CIDM-8211', now(), 'CIDM-8211', now(), 1);

