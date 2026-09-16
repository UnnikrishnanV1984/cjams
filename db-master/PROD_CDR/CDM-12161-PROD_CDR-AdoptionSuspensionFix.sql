update routing
set routingstatustypeid =16, updatedon =now(), updatedby ='CDM-12161'
where routingid ='828e0fb1-f36f-4e0c-836a-ec1fd75ee12d';

update adoptioncasesuspensionrevision 
set approvalstatustypekey ='3047', approvaldate =now(), updatedon =now(), updatedby ='CDM-12161'
where adoptionsuspensionrevisionid ='ea771665-991e-4a1f-8890-3bd862792c18';

update adoptioncasesuspension
set suspensionenddate ='2021-04-05 04:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-12161'
where adoptionsuspensionid ='a62f6d62-c4c7-4f6e-b943-8b10d4a9e00e';