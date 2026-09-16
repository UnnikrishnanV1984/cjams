/*
Issue: CJAMS-64284 report
Category/Module: Intake Dashboard
Root cause: Intake (I251013479238) transferred from Baltimore City to Anne Arundel County, and approved on 11/25/2025. 
            Data fix needed to update the county name to Anne Arundel County.
Fix provided:  Data fix has been done to update the intake county from Baltimore City to Anne Arundel County
Data/Code fix ticket#: CJAMS-64284
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Intake has been transferrd and User requested for data fix.
*/

--7665ca54-5374-4174-be07-a687b811a82c	Baltimore City   (Old)
--f5214cb2-953e-41a9-a4ad-71341501e2ad	Anne Arundel County (New)

UPDATE intakedastaging
SET updatedby = 'CJAMS-64284', updatedon = now(), 
jsondata = 	jsonb_set(jsondata, '{General}', 
				jsonb_set(jsondata->'General', '{countyid}', '"f5214cb2-953e-41a9-a4ad-71341501e2ad"'))
WHERE intakenumber = 'I251013479238' AND activeflag=1;