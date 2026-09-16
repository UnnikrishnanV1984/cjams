/*
   Issue Description: CIDM-11628 B-239582 - Motivational interview Pilot Counties
   Category/ Module  :  Program assignment / Motivational interview
   Root cause: We need to add Baltimore CIty, Frederick, Prince George's, and Wicomico counties for Motivation options county go live configurations.
               Also remove existing counties i.e., Washigton, Garret and Allegany for which these are configured.
   Fix Provided: Data fix has been done to add configuration changes for enabling Motivational story changes in Baltimore CIty, Frederick, Prince George's
                Also removed those options from Washigton, Garret and Allegany counties.
   Data/ Code fix ticket#:CIDM-11628
   Regression Impacts: Validate if you are able add Motivational story options for Baltimore CIty, Frederick, Prince George's, and Wicomico counties
                       Also make sure you are not able to add it for Washigton, Garret and Allegany
   Is Code fix Required?: No
   Code fix ticket#: CIDM-11628
   Reason why no related code fix: This is a configuration change and no code fix is needed.
*/

update cjams.countygoliveconfig  
set garrett = null,
    allegany = null,
    washington = null,
    baltimorecity = now(),
    frederick = now(),
    princegeorges = now(),
    wicomico = now(),
    updatedon = now(),
    updatedby = 'CIDM-11628'
where objecttype = 'motivational-interview'
and activeflag = 1;