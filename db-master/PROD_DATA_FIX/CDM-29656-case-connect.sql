/*
   Issue Description: CDM-29656
   Category/ Module  :  I231010545526:I am attempting to case connect referral, #211030011566 to service case #3307792. CJAMS does not give you the option again if the case connection window closes and you have NOT case connected it to a service case.
    This is bug in the system. User should always have the ability to case connect.
   Root cause: User error case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error - requested a data fix
*/

select * from cjams.createservicecase('c5fa46aa-097a-4aac-bfa8-3853ef97077c', '45cbd5dc-3a38-452e-9395-28d6d36c267e', 1,'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 'intake' );