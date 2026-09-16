import { Component, OnInit, Output, EventEmitter, Injector } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { NavigationUtils } from '../../../pages/_utils/navigation-utils.service';
import { ActivatedRoute, Router } from '@angular/router';
import {DataStoreService, SessionStorageService, AuthService, CommonHttpService} from '../../../@core/services';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { Titile4eUrlConfig } from '../_entities/title4e-dashboard-url-config';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption',
    templateUrl: './titleIVe-adoption.component.html',
    styleUrls: ['./titleIVe-adoption.component.scss'],
    standalone: false
})
export class AdoptionComponent implements OnInit {
    adoptionMissingFields!: FormGroup;
    TitleIVeStatus!: FormGroup;
    SpecialNeedsOfChild!: FormGroup;
    ChildStatusInfo!: FormGroup;
    PlacementAndMedicalInfo!: FormGroup;
    @Output() AdoptionApplicable = new EventEmitter();
    @Output() AdoptionApplicability = new EventEmitter();
    AdoptionApplicableInn: any;
    RedeterminationStatus: any;
    @Output() AdoptionNonapplicability = new EventEmitter<string>();
    @Output() AdoptionIncomplete = new EventEmitter();
    adoptionAssistance = new EventEmitter();
    adoptionnonApplicable: any;
    RedeteradoptionAssistance: any;
    RedetExtAdoption: any;
    removalid: any;
    adoptionMigratedData: any;
    clientName: any;
    createdate: any;
    adoptionEligibilityData: any;
    adoptionData: any;
    childagency: any;
    casenumber: any;
    adoptioncasenumber: any;
    childSubmisson!: FormGroup;
    submissondate: any;
    assignmentdate: any;
    adoptionapplicabiltystatus: boolean = false;
    showEligibility: boolean = true;
    determination: any;
    bioclientid: any;
    isaca!: string;
    moduleview: any;
    activeModule: any;
    userInfo: any;
    private router: Router;
    private route: ActivatedRoute;
    private commonHttpService: CommonHttpService;
    private fb: FormBuilder;
    private _sessionStorage: SessionStorageService;
    private _dataStore: DataStoreService;
    public _authService: AuthService;

    constructor(private injector: Injector, private navigateutil: NavigationUtils, public dialog: MatDialog) {
        this.router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.fb = this.injector.get<FormBuilder>(FormBuilder);
        this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._dataStore = this.injector.get<DataStoreService>(DataStoreService);
        this._authService = this.injector.get<AuthService>(AuthService);

        this.route.data.subscribe(response => {

            if (response && response.adoptionData) {
                this._authService.setAuthDetail('iveadoption',response.adoptionData.userresources);
                if(response.adoptionData.adoptioneligibilitydata && response.adoptionData.adoptioneligibilitydata.adoptionEligibilityInfo && response.adoptionData.adoptioneligibilitydata.adoptionEligibilityInfo.length > 0){
                    this.adoptionEligibilityData = response.adoptionData.adoptioneligibilitydata.adoptionEligibilityInfo[0];
                    this.adoptionData = response.adoptionData.adoptioneligibilitydata;
                    this.clientName = this.adoptionEligibilityData.nameofchild;
                    this.childagency = this.adoptionEligibilityData.childagency;
                    this.casenumber = this.adoptionEligibilityData.casenumber;
                    this.adoptioncasenumber = this.adoptionEligibilityData.adoptioncasenumber;
                    this.createdate = this.adoptionEligibilityData.createdate;
                    this.bioclientid = this.adoptionEligibilityData.bioclientid;
                    var ivestatus = this.adoptionEligibilityData.ivestatus;
                    this.adoptionapplicabiltystatus = (ivestatus === undefined || ivestatus === null || ivestatus === 'PENDING' || ivestatus === 'COMPLETED' || ivestatus === 'REVIEW') ? false : true;
                    this.isaca = this.router.routerState.snapshot.url.split('/')[3];
                    if (this.isaca === 'aca') {
                        this.showEligibility = false;
                        this._dataStore.setData('adoption_clientid', this.adoptionEligibilityData.clientid);
                        this._dataStore.setData('adoption_removalid', this.adoptionEligibilityData.removalid);
                    }
                    else {
                        this._dataStore.setData('adoption_clientid', this.bioclientid);
                        this._dataStore.setData('adoption_removalid', this.adoptionEligibilityData.removalid);
                    }
                    this._dataStore.setData('ivepersonnameselected', this.clientName);
                }
            }
        });
    }
    client_id: any;
    ngOnInit() {
        this.moduleview = this._authService.isModuleAccessable('iveadoption', 'iveadoption');
        this.client_id = this.router.routerState.snapshot.url.split('/')[4];
        this.removalid = this.router.routerState.snapshot.url.split('/')[5];
        this._dataStore.setData('ivepersoncjamspidselected', this.client_id);
        this.userInfo = this._authService.getCurrentUser();
        if (this.removalid === 'null') {
            this.getAdoptionHistoryByPerson();
        }
        this.childSubmisson = this.fb.group({
            submissondate: [],
            assignmentdate: []
        });
        this.determination = 'Initial Determination';

        this._authService.readonlyPage('read_only_access','',
        [this.childSubmisson]);
        this.activeModule = this._sessionStorage.getItem('activeModuleNav');
        if(this.activeModule == '4E Analyst'){
            this.getcaseassignment();
        }else{
        this._dataStore.setData('isivereadonly', false);
        }
        this.route.queryParams.subscribe(params => {
            if(params['retrydocument']) {
              $('#attachmentBtnTrigger').click();          
            }
        });
    }

    getcaseassignment() {
        const data = {
          clientId: this.client_id,
          removalId: this.removalid,
          module: 'adoption'
        }
        this.commonHttpService.create(data, Titile4eUrlConfig.EndPoint.getiveassignment).subscribe(
          (response: any) => {
            if(response && response.length > 0 && response[0].getiveassignment == this.userInfo.user.securityusersid){
              this._dataStore.setData('isivereadonly', false);
            }else{
              this._dataStore.setData('isivereadonly', true);
            }
          });
      }

    setdetermination(value: any) {
        this.determination = value
    }

    submitDetermination() {
        const eligibilityBtn = document.getElementById('adoptioneligibilitydetails')
        if (eligibilityBtn) {
            eligibilityBtn.click();
        }
    }

    applicabilitySubmission() {
        this.adoptionapplicabiltystatus = true;
        this.navigatetopath('eligibilityTab');
    }
    navigatetopath(tabtogo: string) {
        setTimeout(() => {
            const pageId: any = document.querySelector('#' + tabtogo);
            if (pageId) {
                pageId.click();
                setTimeout(() => {
                    $('html,body').animate({ scrollTop: 0 }, 'slow');
                }, 300);
            }
        }, 100);
    }
    getAdoptionHistoryByPerson() {
        // client_id is recovered from the route, so it is the literal string 'null'
        // whenever the navigation that opened this page built the URL from a list
        // row with no client id. adoption-history declares clientId as a required
        // number, so strong-remoting rejects '/adoption-history/null' with a 400
        // before the query runs and the subscribe below never fires -- skip the
        // call instead of logging an unexplained 400 for the same empty result.
        if (!this.client_id || isNaN(Number(this.client_id))) {
            return;
        }
        this.commonHttpService.getAll('iveadoption/adoption/adoption-history/' + this.client_id
        ).subscribe(data => {
            this.adoptionMigratedData = data[0];
        });
    }


    navigateCaseNumber(data: any) {
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.SERVICE_CASE);
        this.navigateutil.routToServiceCase(data);
    }
    navigateToFostercare() {
        this.navigateutil.loadFostcareIVE(this.bioclientid, this.removalid, null);
    }
    navigateToAdoptioncase(data: any) {
     if (data) {
         const item = {};
         (item as any)['servicerequestnumber'] = data.adoptioncaseid;
         (item as any)['adoptioncaseid'] = data.adoptioncaseid;
         (item as any)['adoptioncasenumber'] = data.adoptioncasenumber;
         (item as any)['startdate'] = data.adoptionstartdate;
         this.navigateutil.routToAdoptionCase(item);
     } else {
         const item = {};
         (item as any)['servicerequestnumber'] = this.adoptionMigratedData.adoptioncaseid;
         (item as any)['adoptioncaseid'] = this.adoptionMigratedData.adoptioncaseid;
         (item as any)['adoptioncasenumber'] = this.adoptionMigratedData.casenumber;
         (item as any)['startdate'] = this.adoptionMigratedData.adoptionstartdt;
         this.navigateutil.routToAdoptionCase(item);
     }

    }
}
