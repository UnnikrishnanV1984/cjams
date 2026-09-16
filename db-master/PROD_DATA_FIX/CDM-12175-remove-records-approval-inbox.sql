update routing set activeflag = 0, updatedby = 'CDM-12175', updatedon = now() where 
routingid in ('f691fc6a-f265-4d32-9480-3009baa9b7fd',
'c42bfdb5-d40c-4d26-9308-1bbce25dc574');
