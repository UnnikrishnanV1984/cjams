UPDATE documentproperties SET  insertedby = '0fc9bd71-88cf-4065-9446-df743c84293b',
updatedby = '0fc9bd71-88cf-4065-9446-df743c84293b',
updatedon = now() WHERE
documentpropertiesid IN ('a8312b7e-4178-4c3b-8c76-b292ac94a6eb',
'b0b289ff-3c83-4a0c-bb3a-239cb3066cba', '2b73df3b-401b-4e7e-b182-905b5489be00',
'ee9a012e-9778-423f-80a7-f0e6b36048ef' ) ;

UPDATE documentattachment SET insertedby = '0fc9bd71-88cf-4065-9446-df743c84293b',
updatedby = '0fc9bd71-88cf-4065-9446-df743c84293b',
updatedon = now() WHERE
documentpropertiesid IN ('a8312b7e-4178-4c3b-8c76-b292ac94a6eb',
'b0b289ff-3c83-4a0c-bb3a-239cb3066cba', '2b73df3b-401b-4e7e-b182-905b5489be00',
'ee9a012e-9778-423f-80a7-f0e6b36048ef' ) ;