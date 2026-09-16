UPDATE cjams.adoptioncaserevision
SET enddate='4/11/2021'::timestamp, updatedon=now(), updatedby='CDM-1434', approvalstatustypekey = '3047', status = 'Approved'
WHERE adoptionrevisionid='b39d7530-38f5-4cd7-b1e7-b721af76c819';

UPDATE cjams.adoptioncaseagreementrate
SET enddate='4/11/2021'::timestamp, approvaldate=now(),  updatedon=now(), updatedby='CDM-1434'
WHERE adoptionagreementrateid='ca957dc4-200e-4a75-a256-5b898c6f75a3';


