import { Component, OnInit, Input, Output, EventEmitter, Injector } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Titile4eUrlConfig } from '../../_entities/title4e-dashboard-url-config';
import { MatDialog } from '@angular/material/dialog';
import { Router} from '@angular/router';
import {AlertService, CommonHttpService, AuthService, DataStoreService} from '../../../../@core/services';
import { DatePipe } from '@angular/common';
import moment from 'moment';
import {PaginationRequest} from '../../../../@core/entities/common.entities';

@Component({
    selector: 'adoption-extended',
    templateUrl: './adoption-extended.component.html',
    styleUrls: ['./adoption-extended.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class AdoptionExtendedComponent implements OnInit {

    @Input() adoptionData: any;
    @Output() submitForReview: EventEmitter<any> = new EventEmitter();
    assessmentFormData: any;
    ChildStatusInfo!: FormGroup;
    PlacementAndMedicalInfo!: FormGroup;
    SpecialNeedsOfChild!: FormGroup;
    TitleIVeStatus!: FormGroup;
    @Output() submitApplicability = new EventEmitter();
    adoptionDetails: any;
    client_id: any;
    childassessmentData: any;
    removalid: any;
    countyname: any;
    childPersonId: any;
    educationlist: any;
    employementlist: any;
    employementbarrierlist: any;
    adoptionMigratedData: any;
    narrativeuniqueInfo: any;
    disabilityList: any;
    disabilityfilterlist:any[] = [];
    educationfilterlist:any[] = [];
    adoptionExtensionData: any;
    adoptionextensionForm!:  FormGroup;
    @Input() pagesnapshot: any;
    isreadonly: any;
    dtformat = 'MM/DD/YYYY';
    private readonly _commonHttpService: CommonHttpService;
    private readonly _alertService: AlertService;
    private readonly fb: FormBuilder;
    private readonly _dataStore: DataStoreService;
    private readonly router: Router;
    public _authService: AuthService;

    constructor(private injector: Injector, public dialog: MatDialog, private readonly datePipe: DatePipe) {
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this.fb = this.injector.get<FormBuilder>(FormBuilder);
        this._dataStore = this.injector.get<DataStoreService>(DataStoreService);
        this.router = this.injector.get<Router>(Router);
        this._authService = this.injector.get<AuthService>(AuthService);
    }

    ngOnInit() {
        this.createFormGroup();
        this._dataStore.currentStore.subscribe((item) => {
            if (item['isivereadonly']) {
              this.isreadonly = item['isivereadonly'];
            }
          });

        if (this.pagesnapshot) {
            this.adoptionextensionForm.patchValue(this.pagesnapshot);
            this.adoptionextensionForm.disable();
        } else {
            this.client_id = this.router.routerState.snapshot.url.split('/')[4];
            this.removalid = this.router.routerState.snapshot.url.split('/')[5];
            this.searchAdoptionExtensionData();
        }
        if (this.removalid === 'null' || this.removalid === undefined) {
            this.getAdoptionHistoryByPerson();
        } else{
            this.getEducation(this.childPersonId);
            this.getworkDetails(this.childPersonId);
            this.getEmploymentBarrierDetails(this.childPersonId);
            this.getDisabilityList(this.childPersonId);
        }        
        this._authService.readonlyPage('read_only_access','',
        [this.adoptionextensionForm
        ]);

    }

    getAdoptionHistoryByPerson() {
        // client_id comes from the route, so it is the literal string 'null' whenever
        // the navigation that opened this page built the URL from a list row with no
        // client id -- the same reason removalid is compared against the string
        // 'null' above. adoption-history declares clientId as a required number, so
        // strong-remoting rejects '/adoption-history/null' with a 400 before the
        // query runs and the subscribe below never fires.
        if (!this.client_id || isNaN(Number(this.client_id))) {
            return;
        }
        this._commonHttpService.getAll('iveadoption/adoption/adoption-history/' + this.client_id
        ).subscribe(data => {
                this.adoptionMigratedData = data[0];
                this.childPersonId = this.adoptionMigratedData.personid;
                this.adoptionextensionForm.patchValue({ dateofbirth: this.adoptionMigratedData.dateofbirth});
                this.adoptionextensionForm.patchValue({ nameofchild: this.adoptionMigratedData.childname});
                this.adoptionextensionForm.patchValue({ clientid: this.adoptionMigratedData.clientid});
                this.adoptionextensionForm.patchValue({ countyofjurisdiction: this.adoptionMigratedData.childjurisdiction});
                this.adoptionextensionForm.patchValue({ provideridofadoptiveparent: data[0].parent1providerid});
                this.adoptionextensionForm.patchValue({ nameofadoptiveparent1: data[0].parent1providername});
                this.adoptionextensionForm.patchValue({ nameofadoptiveparent2: data[0].parent2providername});
                this.adoptionextensionForm.patchValue({ dateofadoptionfinalization: data[0].dateofadoptionfinalization});
                this.adoptionextensionForm.patchValue({ isdocumentedphysicalandmentaldisability: data[0].isdocumentedphysicalandmentaldisability});
                if (this.adoptionMigratedData.removalage) {
                    if (this.adoptionMigratedData.removalage === 'M') {
                        this.adoptionextensionForm.patchValue({gender: 'Male'});
                    } else if (this.adoptionMigratedData.removalage === 'F') {
                        this.adoptionextensionForm.patchValue({gender: 'Female'});
                    } else if (this.adoptionMigratedData.removalage === 'O') {
                        this.adoptionextensionForm.patchValue({gender: 'Other'});
                    }
                }
                this.getEducation(this.childPersonId);
                this.getworkDetails(this.childPersonId);
                this.getEmploymentBarrierDetails(this.childPersonId);
                this.getDisabilityList(this.childPersonId);
        });
    }


    isTabSwitched(){
        $('.adoption a').on('shown.bs.tab', (event) => {
            var x = $(event.target).text();
            if(x.includes("Redetermination")){
                this.searchAdoptionExtensionData();
            }
        });
    }
    createFormGroup(){
        this.adoptionextensionForm = this.fb.group({
            countyofjurisdiction: [''],
            nameofchild: [''],
            clientid: [''],
            dateofbirth: [''],
            gender: [''],
            dateofadoptionfinalization: [''],
            isdocumentedphysicalandmentaldisability: [''],
            provideridofadoptiveparent: [''],
            nameofadoptiveparent1: [''],
            nameofadoptiveparent2: [''],
            singleparentadoptioncheck: ['']
        });
    }

    setData() {

        if (this.adoptionExtensionData && this.adoptionExtensionData.adoptionEligibilityInfo && this.adoptionExtensionData.adoptionEligibilityInfo.length > 0 ) {
            this.adoptionextensionForm.patchValue(this.adoptionExtensionData.adoptionEligibilityInfo[0]);
            this.childPersonId = this.adoptionExtensionData.adoptionEligibilityInfo[0].personid;
        }
    }

    saveData() {
        const finalsubmission = this.adoptionextensionForm.value;
        var request = {
            'clientId': Number(this.client_id),
            ...finalsubmission
        };
        this._commonHttpService.create(request, Titile4eUrlConfig.EndPoint.saveadoptioneligibility).subscribe(
            (res) => {
                this._alertService.success("Adoption data saved successfully!");
            },
            (error) => {
                this._alertService.error("Adoption data save Failed");
            });

    }

    submissionData() {
        interface LooseObject {
            [key: string]: any;
        }
        //SonarQube code complexity fix - reafctored the condition check
        if (Array.isArray(this.educationfilterlist) && this.educationfilterlist.length > 0 ) {
            const edumetadata = {'__metadata': {
                    '#type': 'EducationDetails'
                }};
            const edueventreason = {'YouthEventReason': 'ED'};
            this.educationfilterlist.forEach((obj) => {
                Object.assign(obj, edueventreason, edumetadata);
            });
        }else {
            this.educationfilterlist = [];
        }

        if (Array.isArray(this.employementlist) && this.employementlist.length > 0) {
            const empmetadata = {'__metadata': {
                    '#type': 'EmploymentDetails'
                }};
            const empeventreason = {'YouthEventReason': 'EM'};
            this.employementlist.forEach((obj) => {
                Object.assign(obj, empeventreason, empmetadata);
            });
        } else {
            this.employementlist = null;
        }

        if (Array.isArray(this.narrativeuniqueInfo) && this.narrativeuniqueInfo.length > 0 ) {
            const empbarriermetadata = {'__metadata': {
                    '#type': 'RemovesBarriersDetails'
                }};
            const empbarriereventreason =   {'YouthEventReason': 'RB'};
            this.narrativeuniqueInfo.forEach((obj) => {
                Object.assign(obj, empbarriereventreason, empbarriermetadata);
            });
        }else {
            this.narrativeuniqueInfo = null;
        }

        if (Array.isArray(this.disabilityfilterlist) && this.disabilityfilterlist.length > 0) {
            const disablitymetadata =  {'__metadata': {
                    '#type': 'ChildDisabilityDetails'
                }};
            const disablityeventreason =  {'YouthEventReason': 'CD'};
            this.disabilityfilterlist.forEach((obj) => {
                Object.assign(obj, disablityeventreason, disablitymetadata);
            });
        }else {
            this.disabilityfilterlist = [];
        }
        const isdocumentedphysicalandmentaldisability = this.adoptionextensionForm.value.isdocumentedphysicalandmentaldisability;
        const submissiondata: LooseObject = {
            'cjamsPid': Number(this.client_id),
            'removalid': this.removalid,
            'pagesnapshot': this.adoptionextensionForm.getRawValue(),
            'reDetermination': {
                'payload': {
                    "name": "EXT_Adoption",
                    "__metadataRoot": {},
                    "Objects": [{
                        "AdoptionFinalizationDate": this.dateTimeConversion(this.adoptionextensionForm.value.dateofadoptionfinalization),
                        "person": {
                            "educationDetails": this.educationfilterlist,
                            "employmentDetails": this.employementlist,
                            "childDisabilityDetails": this.disabilityfilterlist,
                            "removesBarriersDetails": this.narrativeuniqueInfo,
                            "DateOfBirth": this.dateConversion(this.adoptionextensionForm.value.dateofbirth),
                            "CountyOfJurisdiction_LDSS": this.adoptionextensionForm.value.countyofjurisdiction,
                            "Gender": this.adoptionextensionForm.value.gender,
                            "Name": this.adoptionextensionForm.value.nameofchild,
                            "__metadata": {
                                "#type": "Person",
                                "#id": "Person_id_1"
                            },

                        },
                        "__metadata": {
                            "#type": "Application",
                            "#id": "Application_id_1"
                        },
                        "IsDocumentedPhysicalAndMentalDisability": isdocumentedphysicalandmentaldisability === "" ? null : isdocumentedphysicalandmentaldisability,
                        "status": {
                            "AdoptionAssistance": "Eligible Reimbursable",
                            "EXTAdoption": null,
                            "__metadata": {
                                "#type": "Status",
                                "#id": "Status_id_1"
                            }
                        }
                    }]
                }
            }
        };

        this._commonHttpService.create(submissiondata, Titile4eUrlConfig.EndPoint.postAdoptionApplicability).subscribe(
            (res) => {
                this.submitForReview.emit();
                this._alertService.success("Submitted successfully!");
            },
            (error) => {
                this._alertService.error("Submission Failed");
            });

    }

    getEducation(personid:any) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: { personid: personid },
                    page: 1,
                    limit: 10
                }),
                'personeducation/educationlist' + '?filter'
            ).subscribe((result) => {
                this.educationlist = result;
                this.educationlist = this.educationlist?.personEducation ?? [];
                this.educationfilterlist = [];
                this.educationListForloopFn();
            });
    }


    private educationListForloopFn() {
        this.educationlist.forEach((element: any) => {
            element.startdate = element.startdate ? moment(element.startdate).format(this.dtformat) : null;
            element.enddate = element.enddate ? moment(element.enddate).format(this.dtformat) : null;
            if (element.classtypetypekey === null && element.schoolenrolltypekey) {
                if (element.schoolenrolltypekey === 'SESC') {
                    element.classtypetypekey = 'JH';
                } else if (element.schoolenrolltypekey === 'COLLG') {
                    element.classtypetypekey = 'CLG';
                } else if (element.schoolenrolltypekey === 'PSEOT') {
                    element.classtypetypekey = 'VTP';
                }
            }
            if (element.classtypetypekey === 'CLG' || element.classtypetypekey === 'GEDP' || element.classtypetypekey === 'VTP' || element.classtypetypekey === 'HS'
                || element.classtypetypekey === 'JH' || element.classtypetypekey === 'IA'
                || element.schoolenrolltypekey === 'SESC' || element.schoolenrolltypekey === 'PSEOT' || element.schoolenrolltypekey === 'COLLG') {
                this.educationfilterlist.push(element);
            }
        });
    }

    getworkDetails(personid: string) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: { personid: personid }
                }),
                'People/getpersonwork?filter'
            ).subscribe((result) => {
                this.employementlist = result;
                this.employementlist.forEach((element:any) => {
                    element.startdate = element.startdate ? moment(element.startdate).format(this.dtformat) : null;
                    element.enddate =  element.enddate ? moment(element.enddate).format(this.dtformat) : null;
                    element.noofhours =  element.noofhours ? Number(element.noofhours) : null;
                    if (element.workphone && element.workphone.length > 0) {
                        delete element.workphone;
                    }
                    if (element.email && element.email.length > 0) {
                        delete element.email;
                    }
                });
            });
    }

    getEmploymentBarrierDetails(personid:any) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: {personid: personid}
                }),
                'People/getpersonworknarrative?filter'
            ).subscribe((result) => {
                this.employementbarrierlist = result;
                this.narrativeuniqueInfo = [];

                //SonarQube fix - used single for-of loop instead of the 2 for loops above
                for(const i of this.employementbarrierlist){
                    const promotedemploymentprogramname = i.promotedemploymentprogramname;
                    i.promotedemploymentprogramstartdate = i.promotedemploymentprogramstartdate ? moment(i.promotedemploymentprogramstartdate).format(this.dtformat) : null;
                    i.promotedemploymentprogramenddate =  i.promotedemploymentprogramenddate ? moment(i.promotedemploymentprogramenddate).format(this.dtformat) : null;

                    if (promotedemploymentprogramname) {
                        this.narrativeuniqueInfo.push(i);
                    }
                }
            });
    }

    getDisabilityList(personid:any) {
        return this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { personid: personid }
                }),
                'People/getpersondisability?filter'
            ).subscribe((result) => {
                this.disabilityfilterlist = [];
                this.disabilityList = result;
                this.disabilityList.forEach((element:any) => {
                    element.startdate = element.startdate ? moment(element.startdate).format(this.dtformat) : null;
                    element.enddate =  element.enddate ? moment(element.enddate).format(this.dtformat) : null;
                    element.evaluationdate =  element.evaluationdate ? moment(element.evaluationdate).format(this.dtformat) : null;
                    if (element.disabilityconditiontypekey === 'Yes') {
                        if (element.disabilityflag === 1) {
                            element.disabilityflag = 'Permanent';
                        }  else {
                            element.disabilityflag = 'Temporary';
                        }
                        this.disabilityfilterlist.push(element);
                    }
                });
            });
    }


    dateConversion(date:any) {
        if (date === undefined || date === null || date === '') {
            return null;
        } else {
            return this.datePipe.transform(date, 'MM/dd/yyyy');
        }
    }

    dateTimeConversion(date:any){
        if(date === undefined || date === null || date === ''){
            return null;
        }else{
            return this.datePipe.transform(date,"MM/dd/yyyy HH:mm:ss");
        }
    }

    searchAdoptionExtensionData(){
        if(this.adoptionData){
            this.adoptionExtensionData = this.adoptionData;
            this.setData();
        }
    }
}
