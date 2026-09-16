/*
   Issue Description: CDM-28674
   Category/ Module  :
   Root cause: ::There is a case on my workload to approve- an adoption review- from Baltimore City. I attempted to email the worker and supervsior but they do not come up in the directory. This is not a Charles County case.
   Reason why no related code fix:  Data fix
*/

update routing set tosecurityusersid = 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7' where objectid='09da71fb-8e38-4428-b3d7-6a4634b01f96'
and activeflag = 1 and tosecurityusersid = '7931939d-b256-4735-b2de-5e96c615d699';