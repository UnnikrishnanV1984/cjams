-- CDM-9988 - End date the OOH record

update personprogramarea set enddate = '2019-12-02 00:00:00', updatedby = 'CDM-9988', updatedon = now() where personprogramid='2ec0c9d3-389c-4401-960e-f4dbf6e00ecc';
