/*
Issue: CIDM-11088 Re-route Pending Purchase Authorizations
Category/Module: Purchase Authorization
Root cause: Supervisor Debra Dandridge has retired and data fix needed to re-route all pending purchase authorization records to Linnel Benton
Fix provided:  Bulk data fix has been made to re-route pending purchase authorization approval records to Linnel Benton
Below are the list of AuthID that have been re-routed
2532133
2551768
2555810
2572678
1936705
2406456
2624256
2623689
2636802
2636973
2637006
2636701
2474467
2636905
2648259
2646551
2013916
2648275
2648273
2648270
2648269
2646552
2652576
2650229
2650194
2048399
2054751
2653555
2653182
2670776
2125582
2125577
2148318
2162711
2672840
2691456
2192989
2162331
2726976
2333211
2357226
2726712
2733415
2733779
2733745
2734078
2377953
2379326
2735007
2427312
2442964
2750992
2758436
2754098
2749633
2760999
2765573
2765043
2780191
2780588
2777238
2777105
2777072
2787005
2803383
2806948
2814316
2814350
2814984
2815216
2944823
2944856
2944427
2943268
2942998
3651461
3272218
3271754
3310613
3358333
3520777
3609281
3850222
4169529
Data/Code fix ticket#: CIDM-11088
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User has retired and data fix is needed for re-routing her records.
*/

update routing
set tosecurityusersid = 'b0fbf926-91a3-4a91-a6a4-62e458683797', --Linnel Benton
    updatedon = now(),
    updatedby ='CIDM-11088'
where eventcode = 'PCAUTH' 
and tosecurityusersid = 'df4e91fc-5824-45b0-baae-788cacf3bc79' --Debra Dandridge
and routingstatustypeid = 40 
and activeflag=1;    
