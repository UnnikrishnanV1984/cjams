// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `angular-cli.json`.
export const environment = {
    prodMod: false,
	title4eProduction: true,//Temporary till Title IV-E goes to live
    IVEReferralCSMSCall: true,
    apiHost:'http://localhost:3000/api',
    formBuilderHost: 'https://dev3.eks.cjams.mdthink.maryland.gov/formbuilder',
   //formBuilderHost: 'http://dev4.cjams.formbuilder.mdthink.maryland.gov',
    reports: 'https://dev2.analytics.mdthink.maryland.gov/qliksense/hub/',
    reportHost: 'https://10.88.40.141/',
    fakeHttpResponse: false,
    envName: 'Dev',
    logoutDHSURL: 'https://dev.access.mdthink.maryland.gov/mdtsso/UI/Logout?realm=/dhs',
    IdleTimeOut: 900,
    PopupTimeOut: 300,
    enableCaseConnectClose: true,
    isReadOnlyEnable: true,
    FileUploadRefreshTime : 30000
 };
