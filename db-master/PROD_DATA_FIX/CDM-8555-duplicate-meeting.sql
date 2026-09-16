delete from meetingfimdetails where meetingrecordingid in ('a3a63086-c60f-4f42-a656-5a9ca5a9fd5c',
'250a98b1-9b1b-4777-87e4-bd068023e66d'); 

delete from meetingparticipants where meetingrecordingid in ('a3a63086-c60f-4f42-a656-5a9ca5a9fd5c',
'250a98b1-9b1b-4777-87e4-bd068023e66d');

delete from meetingrecordingactor where meetingrecordingid in ('a3a63086-c60f-4f42-a656-5a9ca5a9fd5c',
'250a98b1-9b1b-4777-87e4-bd068023e66d');

delete from meetingrecording where meetingrecordingid in ('a3a63086-c60f-4f42-a656-5a9ca5a9fd5c',
'250a98b1-9b1b-4777-87e4-bd068023e66d');