/*
   Issue Description: CDM-39917 Subsidy Rate Approval showing incomplete after approval
   Category/ Module  : GAP Subsidy
   Root cause: Subsidy rate slab displayed as incomplete as rejected record is being sent for approval instead of the latest one.
   Fix provided : Data fix has been promoted to make the latest subsidy rate as approved from incomplete state and delete the duplicate record.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

---Delete duplicate record

update adoptioncaserevision 
set activeflag =0, 
    updatedby = 'CDM-39917', 
    updatedon = now() 
where adoptionagreementrateid= '5e078a63-19cf-407b-b246-bbfddab3aa96'
  and adoptionagreementid='68f0518a-5829-42e6-994d-12dff5cc880d'
  and activeflag =1;


update adoptioncaseagreementrate 
set activeflag =0, 
    updatedby = 'CDM-39917', 
    updatedon = now() 
where adoptionagreementrateid= '5e078a63-19cf-407b-b246-bbfddab3aa96'
  and adoptionagreementid='68f0518a-5829-42e6-994d-12dff5cc880d'
  and activeflag =1;  

-- Update status and status key in adoptioncaserevision table

update adoptioncaserevision
set approvalstatustypekey = '3047',
	  status = 'Approved',
    isspeacialneeds = true,
    specialneedtypekey = 'ADCD',
    approvaldate = '2024-06-28 12:34:24.000',
	  updatedby = 'CDM-39917',
	  updatedon = now()
where adoptionagreementid='68f0518a-5829-42e6-994d-12dff5cc880d' 
and   adoptionagreementrateid='b9299a36-f6dc-44c8-b3cc-fd3f0e387378';


INSERT INTO cjams.adoptioncaseagreementrate
(adoptionagreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES('b9299a36-f6dc-44c8-b3cc-fd3f0e387378'::uuid, '68f0518a-5829-42e6-994d-12dff5cc880d'::uuid, '2024-10-01 08:00:00.000', '2025-09-30 04:00:00.000', 5086907, 887, NULL, '2024-06-28 12:34:24.000', 1, NULL, NULL, NULL, NULL, 1, '2024-06-28 12:34:24.000', '9a1c8c5c-cc81-4c3f-8c25-65089b46afca', '2024-06-28 12:34:24.000', '9a1c8c5c-cc81-4c3f-8c25-65089b46afca', '2024-06-28 12:34:24.000', NULL, 'ADCD', NULL, '2024-06-28 12:34:24.000', NULL, 'Approved', NULL, NULL, NULL, NULL, NULL);


-- Deleted 7-1-2024 duplicate record

update adoptioncaserevision 
set activeflag =0, 
    updatedby = 'CDM-39917', 
    updatedon = now() 
where adoptionagreementrateid= '4a781ec4-065e-4cce-be5b-9551259cbc9f'
  and adoptionagreementid='68f0518a-5829-42e6-994d-12dff5cc880d'
  and activeflag =1;


update adoptioncaseagreementrate 
set activeflag =0, 
    updatedby = 'CDM-39917', 
    updatedon = now() 
where adoptionagreementrateid= '4a781ec4-065e-4cce-be5b-9551259cbc9f'
  and adoptionagreementid='68f0518a-5829-42e6-994d-12dff5cc880d'
  and activeflag =1; 