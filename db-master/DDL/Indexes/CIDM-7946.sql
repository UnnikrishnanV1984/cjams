create index Xie2_person on person (replace(coalesce(firstname,'')||','||coalesce(middlename,'')||','||coalesce(lastname,'')||','||coalesce(suffix,''), ' ',''));
