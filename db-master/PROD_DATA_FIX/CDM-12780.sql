update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{caseworkername}', '"Emma McAdoo"'), updatedby ='CDM-12780', updatedon =now()
where submissionid ='60258e3a3797cb001ac76ea6';