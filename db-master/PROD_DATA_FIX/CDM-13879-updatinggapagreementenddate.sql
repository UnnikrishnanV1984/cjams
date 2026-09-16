-- 2022-01-06 05:00:00
update gapagreementrate g set enddate = '2022-05-05 05:00:00', updatedon = now(), updatedby = 'CDM-13879' where gapagreementrateid in ('0b98db9e-9cf2-4b63-92ea-b1cdf806d0fa','58eee101-4b31-4dfe-99d4-7a40d64ace89');

-- 2022-01-06 05:00:00
update gapratesrevision set rateenddate = '2022-05-05 05:00:00', updatedon = now(), updatedby = 'CDM-13879', approvaldate = now() where gapratesrevisionid in ('07b31e65-ebe0-406c-b4b5-9ff53ed7798a',
'e23eb92e-8cf2-4634-8bfa-efdefbdf2991',
'638bb261-4a46-4550-80a4-9396d95f7935',
'a7823479-8d49-4dd0-993c-1dbf1f10da0d');
