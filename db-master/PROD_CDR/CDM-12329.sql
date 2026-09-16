update cjams.pgresource
set isenabled = true, updatedon = now(), updatedby = 'CDM-12329'
where pgresourceid in ('b0e63c5d-0107-4d0d-b2d3-0ed44d879c28',
'8738e932-007b-4865-9ba2-a676cc63ca1a',
'4dda7f1b-103e-4b58-8cdf-1dce92db2cd8',
'557933a5-4df2-4631-bbf0-e6c4d7784fec');