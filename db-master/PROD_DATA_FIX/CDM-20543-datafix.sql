--CDM-20543

update snapshothist s set s.approvalstatus  = 'Draft', s.updatedby ='CDM-20543', s.updatedon = now()
where s.objectid = '51edcf10-5b8f-4642-9188-639554b8bf09' and id = '7355a534-e832-4576-a516-e0f99dd1ba39';
