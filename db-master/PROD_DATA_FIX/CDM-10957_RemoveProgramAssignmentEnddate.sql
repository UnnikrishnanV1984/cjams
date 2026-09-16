-- CDM-10957 - Remove end date for program assignment

update personprogramarea set enddate = null , updatedby = 'CDM-10957', updatedon = now() where personprogramid='c3b87f4d-7417-421a-a734-931debf03cc3';
