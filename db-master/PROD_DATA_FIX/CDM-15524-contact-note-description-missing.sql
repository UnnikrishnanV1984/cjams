/*
   Issue Description: CDM-15524
   Category/ Module  : INtake
   Root cause: user requested  to 
     211020115632:This case has a contact note which was entered in parts. The initial two entries are missing and only say "worker," but had previously had several
      sentences of more detailed information. The last portion of the contact and most recent entry is present.
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update progressnotedetail set description='
<p>Worker met with MC and KS while BW waited following the PO hearings that had just been held. Worker observed KS to be appropriately dressed and 
to be managing the circumstances relatively well. KS appeared comfortable with MC and her extended family, who had been observed in and out of the 
courthouse throughout the day. She was assessed to be safe in the care of MC at this time.
<br>
<br>
Worker asked when the safety plan from TCDSS expired and was informed it expired today. Worker explained that the Department could not maintain a safety plan 
that AS did not agree with long term. Worker safety planned with MC due to not learning the plan from Talbot County DSS expired until after hours, but explained 
the Department would be working with AS and KS to make another plan. MC told this worker she wanted KS to return to her grandparents home, where she has reportedly 
resided most of her life. She said she understood and that she had been harassed severely by AS, which is why the family had come to get POs today. MC said she and her 
children had been granted POs against AS, as well as PK, BW, and BWs children.</p>',
updatedby='CDM-15524',updatedon= now()
where progressnotedetailid='abfc93b6-2115-4a31-8b5a-8827e73303c5' and activeflag=1;