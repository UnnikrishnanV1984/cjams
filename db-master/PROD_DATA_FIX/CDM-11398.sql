update assessment set  updatedby ='CDM-11398', updatedon =now(), submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
where submissionid ='1959704c-c921-4be3-b44c-6027b504b4db';


update assessment set updatedby ='CDM-11398', updatedon =now(), submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '""')
where submissionid ='8edbddcd-5e74-4675-9281-9d389f599c00';


update assessment set updatedby ='CDM-11398', updatedon =now(), submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '"2020-12-16T23:25:00.000Z"')
where submissionid ='60258e3a3797cb001ac76ea6';