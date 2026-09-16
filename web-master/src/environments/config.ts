export const config = {
    workEnvironment : 'local',
    //workEnvironment : 'state',
    // Added the flag to show or hide the restricted cases in non-prod environment.
    // This flag will work only in non-prod environment.
    // Restrictedcaseenable - true - No access to anyone.
    // Restrictedcaseenable - false - Access to assinged user
    restrictedcaseenable: false,  
    // AutoSaveTimer: 240000 // 4 mins
    AutoSaveTimer: 120000, // 2mins
    uploadMaxSizeLimit : 104857600,
    largeUploadMaxSizeLimit : 1610612736,
    enableNewRelicWebAgent: false,
    // 150000000 - 100 MB // NOSONAR
    // 209715200 - 200 MB // NOSONAR
};
