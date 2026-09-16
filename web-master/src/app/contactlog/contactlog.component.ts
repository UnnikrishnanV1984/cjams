
import { map, pluck } from 'rxjs/operators';
import { ChangeDetectorRef, Component, ElementRef, Injector, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormBuilder, Validators, ReactiveFormsModule } from '@angular/forms';
import { UserProfile } from '../pages/provider-applicant/new-public-applicant/public-applicant-add-document/_entities/attachmnt.model';
import { AlertService, DataStoreService, SessionStorageService, CommonHttpService, AuthService } from '../@core/services';
import { Router, RouterLink } from '@angular/router';
import { CommonModule, Location } from '@angular/common';
import _ from 'lodash';
import { DropdownModel} from '../@core/entities/common.entities';
import { AppConstants } from '../@core/common/constants';
import { AppUser } from '../@core/entities/authDataModel';
import { GLOBAL_MESSAGES } from '../@core/entities/constants';
import { AppConfig } from '../app.config';
import { environment } from '../../environments/environment';
import moment from 'moment';
import { ManageUrlConfig } from '../pages/manage/manage-url.config';
import { TabsetComponent, TabsModule } from 'ngx-bootstrap/tabs';
import { NewUrlConfig } from '../pages/newintake/newintake-url.config';
import { of, Observable} from 'rxjs';
import { CaseWorkerUrlConfig } from '../pages/case-worker/case-worker-url.config';
// import { Html2CanvasService } from '../@core/services/html2canvas.service';
import { NgxPaginationModule } from 'ngx-pagination';
import { HttpClient } from '@angular/common/http';
// import html2canvas from 'html2canvas';

@Component({
    selector: 'contactlog',
    templateUrl: './contactlog.component.html',
    styleUrls: ['./contactlog.component.scss'],
    imports:[NgxPaginationModule,CommonModule,RouterLink,ReactiveFormsModule,TabsModule],
    standalone: true
})
export class ContactlogComponent implements OnInit {

    // @ViewChild('canvas') mycanvas: any;
    @ViewChild('canvas', { static: false }) mycanvas!: ElementRef;
    @ViewChild('tabset') tabset!: TabsetComponent;
    pushRightClass = 'push-right';
    userInfo: AppUser = new AppUser();
    today = Date.now();
    role = '';
    agency = '';
    totalNotificationCount = 10;
    showNotification = false;
    isPreIntake = false;
    dashBoardLink = '';
    isDjs = false;
    ROLES = AppConstants.ROLES;
    feedbackUser: UserProfile = new UserProfile();
    curDate!: string;
    feedbackForm!: FormGroup;
    searchForm!: FormGroup;
    supportNo!: number;
    fileUploaded: any;
    screenshot: any;
    isLoggedIn: boolean;
    ticketsList: any = [];
    ticketsCount!: number;
    maxPageSize = 10;
    query = {};
    showProgress = false;
    downloadMessage!: string;
    downloadAttachments: boolean = false;
    enableDownload: boolean = false;
    severityTypes: any;
    issueTypes: any;
    priorityList: any;
    envList: any;
    roleName: any;
    links: any;
    originalDataLinks: any;
    helpDocumentsList: any = [];
    isApprove = false;
    countiesSource$: any;
    inprogress$: Observable<boolean> = of(false);
    countyname: any
    programarea: any = ['All', 'CW', 'AS', 'JS'];
    countiesData: any = [];
    programgroup: any = ['In-Home', 'Out-of-Home', 'Provider', 'Finance', 'Reports'];
    focusarea: any = ['Assessments: CANS',
        'Assessments: Home Health Report',
        'Assessments: MFIRA',
        'Assessments: SAFE-C',
        'Assessments: Other',
        'Assignments',
        'Case Audit Trail',
        'Court: Legal Custody',
        'Court: TPR',
        'Court: Other',
        'Decision',
        'Documents',
        'Persons: Household',
        'Persons: Collateral',
        'Persons: Quick Person History',
        'Persons: Others',
        'Relationship',
        'Case Plan',
        'Contacts: Notes',
        'Contacts: Meetings',
        'Contacts: Visitation Log',
        'Checklist: In-Home',
        'Checklist: Out-of-Home',
        'Child Removal',
        'Participation',
        'Payments',
        'Permanency Plan',
        'Placement',
        'Reports-Qlik',
        'SDM',
        'Service Agreement',
        'Services: Service Plan',
        'Services: Service Log',
        'Services: Youth Transition Plan',
        'Services: Other',
        'Social History',
        'Title IV-E'];
    releasenotesstr = 'Release Notes';
    countyid!: string | undefined;
    supervisorlist: any[] = [];
    isDisabled: boolean | null = false;
    vl: any = 0;
    isClosed: any;
    isModalVisible: boolean = false;

    public router: Router;
    private _authService: AuthService;
    private _service: CommonHttpService;
    private _dataStoreService: DataStoreService;
    private _sessionStorage: SessionStorageService;
    private _formBuild: FormBuilder;
    private _alert: AlertService;
    // private html2canvas:Html2CanvasService;

    constructor(private readonly injector : Injector,private location: Location, private cdr: ChangeDetectorRef,private readonly _http: HttpClient) {
        this.router = this.injector.get<Router>(Router);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._service = this.injector.get<CommonHttpService>(CommonHttpService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._formBuild = this.injector.get<FormBuilder>(FormBuilder);
        this._alert = this.injector.get<AlertService>(AlertService);
        // this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);

        this.isLoggedIn = false;
    }

    // private newMethod() {
    //     return this;
    // }

    ngOnInit() {
        this.userInfo = this._authService.getCurrentUser();
        // this.getUserCounty();
        this.initializeForm();
        this.initializeSearchForm();


        this.severityTypes = [
            {
                key: "Critical",
                value: "Critical"
            },
            {
                key: "High",
                value: "High"
            },
            {
                key: "Medium",
                value: "Medium"
            },
            {
                key: "Low",
                value: "Low"
            },
        ];
        this.priorityList = [
            {
                key: "10100",
                value: "Emergency"
            },
            {
                key: "2",
                value: "High"
            },
            {
                key: "3",
                value: "Medium"
            },
            {
                key: "4",
                value: "Low"
            }
        ];
        this.envList = [
            {
                key: "Production",
                value: "Production"
            },
            {
                key: "Staging",
                value: "Staging"
            },
            {
                key: "Dev",
                value: "Dev"
            },
            {
                key: "stg1",
                value: "stg1"
            }
            ,
            {
                key: "stg3",
                value: "stg3"
            }
            ,
            {
                key: "dev2",
                value: "dev2"
            }
            ,
            {
                key: "trn1",
                value: "trn1"
            },
            {
                key: "dev3",
                value: "dev3"
            }
        ];
        // @Debashis : This was hardcoded from beginning. It should be part of database tables. but unable to perform the same for now.
        this.issueTypes = [
            {
                key: "531",
                value: "Enhancement"
            },
            {
                key: "528",
                value: "Bug/Issue/Defect"
            },
            {
                key: "531",
                value: "Question/Policy"
            },
            {
                key: "531",
                value: "Gap/Missing from Legacy System"
            },
            {
                key: "524",
                value: "Application Support/Training"
            }
        ];
    }

    activeTab = '';
    referenceLinks: any[] = [];
    howtosLinks: any[] = [];
    releasenotesLinks: any[] = [];
    orgReferenceLinks = [];
    orgHowtosLinks = [];
    orgReleasenotesLinks = [];
    setActiveTab($event: { target: any; }) {
        if ($event.target.innerText == this.releasenotesstr) {
            this.activeTab = this.releasenotesstr;
            this.releasenotesLinks = this.getData('releasenotes', this.helpDocumentsList);
        } else if ($event.target.innerText == "How To's") {
            this.activeTab = "How To's";
            this.howtosLinks = this.getData('howtos', this.helpDocumentsList);
        } else if ($event.target.innerText == 'References') {
            this.activeTab = 'References';
            this.referenceLinks = this.getData('references', this.helpDocumentsList);
        }
    }


    searchText($event: any, searchtext: any) {
        if ($event.target.innerText == this.releasenotesstr) {
            this.releasenotesLinks = this.filterLinks(searchtext, this.releasenotesLinks);
        } else if ($event.target.innerText == "How To's") {
            this.howtosLinks = this.filterLinks(searchtext, this.howtosLinks);
        } else if ($event.target.innerText == 'References') {
            this.referenceLinks = this.filterLinks(searchtext, this.referenceLinks);
        }
    }

    filterLinks(searchStr: string, data: any[]) {
        const arr = [];
        const arrData = JSON.parse(JSON.stringify(data));
        for (const item of arrData) {
            if (item.filename.toLowerCase().includes(searchStr.toLowerCase())) {
                arr.push(item);
            }
        }
        return arr;
    }

    getLinksData() {
        this._service.getAll(ManageUrlConfig.EndPoint.Manage.getHelpDocuments).subscribe(result => {
            this.helpDocumentsList = result;
            const data = { target: { innerText: this.releasenotesstr } };
            this.setActiveTab(data);
        }, (errorData) => {
            // No data or content to add or call
        });
    }

    setDisplayTabLinks(links: any) {
        if (this.activeTab === 'notes') {
            this.releasenotesLinks = (links.length > 0) ? links : [];
        } else if (this.activeTab === 'howto') {
            this.howtosLinks = (links.length > 0) ? links : [];
        } else if (this.activeTab === 'refer') {
            this.referenceLinks = (links.length > 0) ? links : [];
        }
    }

    getData(type: string, data: any) {
        const arr = [];
        for (const tData of data) {
            if (tData.category === type) {
                arr.push(tData);
            }
        }
        return arr;
    }

    searchItems($event: any) {
        // start filtering the links
        const searchStr = $event.target.value;
        const filterCriteria = { target: { innerText: this.activeTab } };
        if (searchStr.length > 2) {
            this.searchText(filterCriteria, searchStr);
        }
    }

    getSeverityType(key: any) {
        return _.get(_.filter(this.severityTypes, { key }), "0.value");
    }

    getIssueType(key: any) {
        return _.get(_.filter(this.issueTypes, { key }), "0.value");
    }

    launchContactlog() {
        const _self = this;
        _self.userInfo = this._authService.getCurrentUser();
        this.getUserCounty();

        _self.screenshot = null;
        _self.feedbackForm?.patchValue({ filedata: null });
        _self.resetFeedback();
        /** 
        try { // NOSONAR
            const canvas = this.mycanvas.nativeElement;
            const ctx = canvas.getContext('2d');

            const width = 200;
            const height = 140;
            canvas.width = width;
            canvas.height = height;

            ctx.fillStyle = 'black';
            ctx.fillRect(0, 0, width, height);

            // Convert the canvas to a Base64 PNG string
            const base64Image = canvas.toDataURL('image/png');

            // Update the form with the Base64 image data
            this.feedbackForm.patchValue({ filedata: base64Image });
            this.cdr.detectChanges();

            // Log the Base64 string to the console (optional)

            // this.html2canvas.capture(document.body, { backgroundColor: undefined, removeContainer: true }).then(function (canvas: any) {
            //     _self.screenshot = canvas.toDataURL('image/png');
            //     if (_self.mycanvas) {
            //         if (_self.mycanvas.nativeElement) {
            //             const canvasEl: HTMLCanvasElement = _self.mycanvas.nativeElement;
            //             if (canvasEl.getContext('2d')) {
            //                 const cx: CanvasRenderingContext2D | any = canvasEl.getContext('2d');
            //                 // set some default properties about the line
            //                 cx.lineWidth = 3;
            //                 cx.lineCap = 'round';
            //                 cx.strokeStyle = '#000';

            //                 const image = new Image();
            //                 image.onload = function () {
            //                     cx.drawImage(image, 0, 0, 200, 140);
            //                 };
            //                 image.src = _self.screenshot;
            //                 console.log("_self.screenshot", typeof _self.screenshot)
            //                 _self.feedbackForm.patchValue({ filedata: _self.screenshot });
            //             }
            //         }
            //     }
            // });
        } catch (error) {
            // NO data or function to add or call
        }
        */
        _self.fillFeedback();
    }


    async captureScreen(): Promise<string> {
        try {
            const stream = await navigator.mediaDevices.getDisplayMedia({
                video: {
                    displaySurface: 'browser', // prioritize the current tab
                },
                audio: false,
                // @ts-ignore
                preferCurrentTab: true 
            });

            const video = document.createElement('video');
            video.srcObject = stream;
            video.play();

            return new Promise((resolve) => {
                video.onloadedmetadata = () => {
                    const canvas = document.createElement('canvas');
                    canvas.width = video.videoWidth;
                    canvas.height = video.videoHeight;
                    const ctx = canvas.getContext('2d');
                    
                    ctx?.drawImage(video, 0, 0, canvas.width, canvas.height);
                    
                    // Cleanup immediately
                    stream.getTracks().forEach(track => track.stop());
                    video.remove();
                    
                    resolve(canvas.toDataURL('image/png'));
                };
            });
        } catch (err) {
            return '';
        }
    }

    async sendFeedback() {
        if (this.feedbackForm.invalid) {
            return;
        }
        // Hide the popup so it doesn't block, and then trigger screen capture
        (<any>$('#user-feedback')).modal('hide');
        setTimeout(async () => {
            try {
                const image = await this.captureScreen();
                
                if (image) {
                    this.screenshot = image;
                    this.feedbackForm?.patchValue({ filedata: this.screenshot });
                } else {
                    // CHOICE:
                    // 1) Cancelled: Show the modal again so they don't lose data
                    //(<any>$('#user-feedback')).modal('show');
                    // 2) User cancelled the browser prompt and we proceed with submission
                    this.screenshot = null;
                    this.feedbackForm?.patchValue({ filedata: null });
                }
            } catch (e) {
                // Error: Show modal again ??
                // (<any>$('#user-feedback')).modal('show');
                // Error occurred (e.g., browser denied permission natively): Ensure it's null
                this.screenshot = null;
                this.feedbackForm?.patchValue({ filedata: null });
            }

            // always submiting, regardless of whether a screenshot was taken
            this.submitToBackend();
        }, 500);
    }

    submitToBackend() {
        this.inprogress$ = of(true);
        const feedbackForm = this.feedbackForm?.getRawValue(); // Added getRawValue fn to get all the fields data
        feedbackForm.notes = feedbackForm.notes + '  \n\n' + 'Screen URL: ' + window.location.href;
        
        this._service?.create(feedbackForm, 'supportlog/add').subscribe(
            res => {
                this._alert.success('Feedback sent successfully');
                this.resetFeedback();
                this.supportNo = res.supportno;
                (<any>$('#supportNo')).modal('show');
                this.inprogress$ = of(false);
            },
            err => {
                this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                this.inprogress$ = of(false);
            }
        );

        if (this.screenshot) {
            this.feedbackForm.patchValue({ filedata: this.screenshot });
        }
    }

    fillFeedback() {
        this.curDate = moment(new Date()).format('YYYY-MM-DD hh:mm A');
        let caseid = 'Dashboard';
        this.feedbackForm.patchValue({ clientid: 'Dashboard' });
        if (this.location.path().indexOf('/case-worker/') !== -1) {
            caseid = this.location.path().split('/')[4];
            this.feedbackForm.patchValue({ clientid: 'CaseWorker' });
        } else if (this.location.path().indexOf('/my-newintake/') !== -1) {
            caseid = this._dataStoreService.getObj('intake') ? this._dataStoreService.getObj('intake').number : '';
            this.feedbackForm.patchValue({ clientid: 'Intake' });
        }
        this.feedbackForm.patchValue({ supportlogdate: this.curDate, caseid: caseid, pageurl: this.location.path() });
        // We will capture the screenshot after user clicks submit
        // this.feedbackForm.patchValue({ filedata: this.screenshot });
        (<any>$('#user-feedback')).modal('show');
        this.isModalVisible = true;
    }

    forceDownload(fileId: string) {
        const wso2Module = AppConfig.getModuleMapName('supportlogfiles');
        const url = `${AppConfig.baseUrl}/${wso2Module}supportlogfiles/download`;
        
        this._http.get(`${url}?id=${fileId}`, {
                responseType: 'blob'
            }).subscribe( ( response ) => {
            const fileURL = URL.createObjectURL(response);
            window.open(fileURL);
        });
    }

    viewTickets() {
        this.router.navigate(['/pages/contact-support']);
    }

    hideTickets() {
        this.clearSearchTickets();
        (<any>$('#user-tickets')).modal('hide');
    }

    viewHelpInfo() {
        (<any>$('#help-info')).modal('show');
    }

    closeHelpInfo() {
        (<any>$('#help-info')).modal('hide');
    }

    pageChanged(event: any) {
        this.getSupportTickets(event - 1);
        return event;
    }

    searchTickets() {
        this.ticketsCount = 0
        const { searchType, searchText } = this.searchForm.value;
        let query: any = {};

        if (searchType === 'effectivedate') {
            query = {
                and: [
                    { 'effectivedate': { gt: new Date(searchText.trim() + " 00:00:00") } },
                    { 'effectivedate': { lt: new Date(searchText.trim() + " 23:59:59") } }

                ],
            }
        } else if (searchType === 'frommailid') {
            const email = searchText.toLowerCase();
            query[searchType] = { like: `%${email.trim()}%` };
        }
        else if (searchType === 'ldssregion') {
            query[searchType] = { like: `%${searchText.trim()}%` };
            query['application'] = { like: '%CW%' };
        }
        else if (searchType === 'application') {
            if (searchText !== 'All') {
                query[searchType] = { like: `%${searchText.trim()}%` };
            }
        }
        else {
            query[searchType] = { like: `%${searchText.trim()}%` };
        }

        this.query = query;
        this.getSupportTickets(0);
    }

    clearSearchTickets() {
        this.query = {};
        this.ticketsList = [];
        this.searchForm.reset();
        this.initializeSearchForm();
        this.getSupportTickets(0);
    }

    downloadTickets() {
        const { searchType, searchText } = this.searchForm.value;
        this.downloadMessage = '';
        if (searchType === 'effectivedate' && !isNaN(Date.parse(searchText))) {
            const filter = {
                where: {
                    and: [
                        { 'effectivedate': { gt: new Date(searchText.trim() + " 00:00:00") } },
                        { 'effectivedate': { lt: new Date(searchText.trim() + " 23:59:59") } }
                    ],
                }
            };
            const wso2Module = AppConfig.getModuleMapName('supportlogfiles');
            const url = `${AppConfig.baseUrl}/${wso2Module}supportlogfiles/downloadall`;
            
            this._http.get(`${url}?filter=${JSON.stringify(filter)}`, {
                    responseType: 'blob'
                }).subscribe( ( response ) => {
                const fileURL = URL.createObjectURL(response);
                window.open(fileURL);
            });
        } else {
            this.downloadMessage = 'Please select "Date" filter with valid date';
        }
    }

    onAttachmentChange(event: any) {
        const reader = new FileReader();
        if (event.target.files && event.target.files.length) {
            this.fileUploaded = event.target.files[0];
            const [file] = event.target.files;
            reader.readAsDataURL(file);
            reader.onload = () => {
                this.feedbackForm.patchValue({
                    filedata: reader.result
                });
            };
        }
    }

    /** Comment this is piece of code as we are updating the functionality.
    sendFeedback() {
        this.inprogress$ = of(true);
        if (this.screenshot) {
            this.feedbackForm.patchValue({ filedata: this.screenshot });
        }
        const feedbackForm = this.feedbackForm.getRawValue();
        feedbackForm.notes = feedbackForm.notes + '  \n\n' + 'Screen URL: ' + window.location.href;
        this._service.create(feedbackForm, 'supportlog/add').subscribe(
            res => {
                this._alert.success('Feedback sent successfully');
                this.resetFeedback();
                this.supportNo = res.supportno;
                (<any>$('#supportNo')).modal('show');
            },
            err => {
                this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );

        setTimeout(() => {
            this.inprogress$ = of(false);
          }, 4000);
    }
    **/

    resetFeedback() {
        (<any>$('#user-feedback')).modal('hide');
        this.isModalVisible = false;
        this.feedbackForm.reset();
        this.fileUploaded = Object.assign({});
        (<any>$('#filedata')).val(null);
        var countyname = '';
        if (this.userInfo.user && this.userInfo.user.userprofile) {
            if (this.userInfo.user.userprofile.teammemberassignment &&
                this.userInfo.user.userprofile.teammemberassignment.teammember &&
                this.userInfo.user.userprofile.teammemberassignment.teammember.team &&
                this.userInfo.user.userprofile.teammemberassignment.teammember.team.countyid) {
                countyname = this.userInfo.user.userprofile.teammemberassignment.teammember.team?.county?.countyname;
                this.getsupervisorlist();

            }
            try {
                if (environment.envName === 'stg3') {
                    this.feedbackForm.patchValue({ jiraEnv: 'Staging' });
                } else {
                    this.feedbackForm.patchValue({ jiraEnv: environment.envName });
                }
            } catch (ex) {
                this.feedbackForm.patchValue({ jiraEnv: 'Production' });
            }
            this.feedbackForm.patchValue({
                displayname: this.userInfo.user?.userprofile?.displayname,
                cjamspid: this.userInfo.user?.userprofile?.cjamspid,
                frommailid: this.userInfo.user?.userprofile?.email,
                userrole: this.userInfo.role?.description,
                ldssregion: countyname ? countyname : this.countyname,
                application: 'CW',
                // severity: 'Medium',
                priority: '3',
                approvedsupervisorid : this.userInfo?.user?.userprofile?.supervisorid,
                caseworkerdefaultsupervisorid: this.userInfo?.user?.userprofile?.supervisorid
            });
        }
    }
    private initializeForm() {
        this.feedbackForm = this._formBuild.group({
            displayname: [{ value: '', disabled: true }],
            cjamspid: [{ value: '', disabled: true }],
            frommailid: [''],
            ldssregion: [{ value: '', disabled: true }],
            application: [''],
            supportlogdate: [null],
            officelocation: [{ value: '', disabled: true }],
            clientid: [{ value: '', disabled: true }],
            subject: [null, Validators.required],
            notes: ['', Validators.required],
            userrole: [''],
            caseid: [{ value: '', disabled: true }],
            filedata: [null],
            severity: ['', Validators.required],
            issuetype: ['', Validators.required],
            pageurl: [''],
            priority: ['3', Validators.required],
            jiraEnv: [{ value: 'Production', disabled: true }],
            program: ['', Validators.required],
            focus: ['', Validators.required],
            supportnumber: [''],
            approvedsupervisorid: [''],
            caseworkerdefaultsupervisorid:['']
        });
        if (this.userInfo.user && this.userInfo.user.userprofile) {

            this.feedbackForm.patchValue({
                displayname: this.userInfo.user?.userprofile?.displayname,
                cjamspid: this.userInfo.user?.userprofile?.cjamspid,
                frommailid: this.userInfo.user?.userprofile?.email,
                userrole: this.userInfo?.role?.description,
                officelocation: 'Child Welfare',
                approvedsupervisorid :this.userInfo.user?.userprofile?.supervisorid,
                caseworkerdefaultsupervisorid: this.userInfo.user?.userprofile?.supervisorid,
            });
        }
    }

    private initializeSearchForm() {
        this.downloadMessage = '';
        this.searchForm = this._formBuild.group({
            searchText: [''],
            searchType: ['']
        });

        this.searchForm.valueChanges.subscribe(() => {
            this.enableDownload = false;
        });
    }

    private getCounties() {
        const source = this._service.getArrayList(
            {
                method: 'get',
                nolimit: true
            },
            NewUrlConfig.EndPoint.Intake.CountryListUrl + '?filter'
        ).pipe(map((result) => {
            return {
                counties: result.map(
                    (res) =>
                        new DropdownModel({
                            text: res.countyname,
                            value: res.countyid
                        })
                )
            }
        }));
        this.countiesSource$ = source.pipe(pluck('counties'));
        source.pipe(pluck('counties')).subscribe((data: any) => {
            this.countiesData = data;
        });

    }

    private getDownloadAccessRole() {
        const cache = Date.now();
        this._service
            .getAll(`Authorizes/getPageProfile?cache=${cache}&arg={"count":-1,"where":{"modulekey":"contact-support"},"method":"get"}`)
            .subscribe(res => {
                const data: any = res;
                this.downloadAttachments = _.includes(_.map(data.resources, 'resourceid'), 'can-download-defects');
            });
    }

    private getSupportTickets(pageNumber = 0) {
        const pageSize = pageNumber * this.maxPageSize;
        const filter: any = {
            limit: this.maxPageSize,
            skip: pageSize,
            where: this.query,
            fields: {
                frommailid: true,
                notes: true,
                effectivedate: true,
                clientid: true,
                subject: true,
                supportno: true,
                supportlogid: true,
                caseid: true,
                severity: true,
                issuetype: true,
                status: true,
                jirarequestsent: true,
                jirarequestno: true,
                ldssregion: true,
                application: true,
                program: true,
                focus: true
            },
            include: {
                relation: 'supportlogfiles',
                scope: {
                    fields: ["supportlogfilesid"]
                }
            },
            order: 'effectivedate desc'
        };
        this.showProgress = true;

        if (this.ticketsCount) {
            this.ticketsList = [];
            if (this.ticketsCount) {
                this.getTickets(filter);
            }
        } else {
            this._service
                .getAll('supportlog/count')
                .subscribe(res => {
                    const data: any = res;
                    this.ticketsCount = data.count;
                    this.getTickets(filter);
                });
        }
    }

    private getTickets(filter: any) {
        this._service
            .getAll('supportlog?filter=' + encodeURIComponent(JSON.stringify(filter)))
            .subscribe(res => {
                if (this.searchForm['controls'].searchType.value === 'effectivedate' && !isNaN(Date.parse(this.searchForm['controls'].searchText.value))) {
                    this.enableDownload = true;
                }
                this.showProgress = false;
                this.ticketsList = res;
            }, err => {
                this.showProgress = false;
            });
    }

    private getJiraStatus() {
        this._service
            .getAll('supportlog/getJiraRequest')
            .subscribe();
    }

    getFormattedDate(dateValue: string | number | Date) {
        if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY HH:mm:ss', true).isValid()) {
            return moment(new Date(dateValue)).format('MM/DD/YYYY HH:mm:ss');
        } else {
            return '';
        }
    }

    approveOrReject(serviceLogID: any, approveOrReject: string) {
        const data = {
            'supportlogid': serviceLogID,
            'approveOrReject': approveOrReject
        };
        this._service.create(data, 'supportlog/approveorreject').subscribe(
            res => {
                if (approveOrReject === 'Approved') {
                    if (res === 'Success') {
                        this._alert.success('Ticket raised has been approved, Jira request has also been sent');
                    } else {
                        this._alert.error('Oops, Something went wrong while Approving the ticket.We have recorded the Approval request and our CJAMS Contact Support Team will look into this ticket as priority.');
                    }
                } else {
                    this._alert.success('Ticket raised has been rejected');
                }
                this.getSupportTickets(0);
                (<any>$('#supportNo')).modal('show');
            },
            err => {
                this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    getUserCounty() {
        const filter: any = {};
        this._service
            .getAll('admin/county/getusercounty?data=' + encodeURIComponent(JSON.stringify(filter)))
            .subscribe(res => {
                if (res && res.length > 0) {
                    const userCounty = res[0];
                    this.countyname = userCounty.countyname;
                }
            });
    }
    getsupervisorlist(){
        this.countyid = this.userInfo?.user?.userprofile?.teammemberassignment?.teammember?.team?.countyid;
        this.supervisorlist = [];



                 const formData = {
                     v_countyid: this.countyid,
                     v_roletypekey: null,
                     method: 'post'
                 }
                 this._service.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.IntakeTransfer.GetSupervisorByCountyId)
                 .subscribe(result => {
                     const supervisorsCollectionfortransfer = result[0].getsupervisorsbycounty;
                     const filterSupervisors =supervisorsCollectionfortransfer.filter((item: any)=>item.roletypekey ==='CWSP' || item.roletypekey ==='IVESV' || item.roletypekey === 'FNSCOFS' || item.roletypekey === 'FNSFS'|| item.roletypekey === 'CWPS');
                     const sortedordersupervisors = _.sortBy(filterSupervisors,'fullname');
                     this.supervisorlist = sortedordersupervisors;
                     this.checkIfSupervisorSelected(this.supervisorlist)
                 });

     }

    checkIfSupervisorSelected(supervisorList: any[]){
        if(this.feedbackForm.controls.approvedsupervisorid.value && supervisorList.filter((user: any)=>user.securityusersid === this.feedbackForm.controls.approvedsupervisorid.value).length>0){
            this.isDisabled = true;
        }else{
            this.isDisabled = null;
        }
    }
}
