import {
    ChangeDetectorRef,
    Component,
    NgZone,
    OnInit,
    ViewEncapsulation,
    Injector
} from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NgxfUploaderService } from 'ngxf-uploader';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DynamicObject, PaginationRequest } from '../../../../@core/entities/common.entities';
import { DataStoreService, GenericService, SessionStorageService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { AuthService } from '../../../../@core/services/auth.service';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { IntakeUtils } from '../../../_utils/intake-utils.service';
import { Subscription } from 'rxjs';
import { IntakeConfigService } from '../../../newintake/my-newintake/intake-config.service';
import { ResourcePermission } from '../../../newintake/my-newintake/_entities/newintakeModel';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-persons',
    templateUrl: './adoption-persons.component.html',
    styleUrls: ['./adoption-persons.component.scss'
        // , '../../../../../styles/trumbowyg.scss'
    ],
    encapsulation: ViewEncapsulation.None,
    standalone: false
})
export class AdoptionPersonsComponent implements OnInit {
    intakeNarrativeForm!: FormGroup;
    speechRecogninitionOn: boolean;
    speechData: string;
    notification!: string | null;
    recognizing = false;
    roleName!: AppUser;
    currentLanguage!: string;
    isrole: any;
    isServiceCase: any;
    store: DynamicObject;
    id!: string;
    dataStroeSubscription!: Subscription;
    baseUrl!: string;
    addedIdentifiedPersons: any;
    agency!: string;
    genderList: any[] = [];
    narrativeCont: any;
    reporterRoles: any[] = [];
    currentNarrativeText: any;
    narrativeUpdatedDate!: Date;
    involevedPerson: any;
    providerDetails: any;
    isAdoptionCase: boolean = false;

    private formBuilder: FormBuilder;
    private speechRecognizer: SpeechRecognizerService;
    private _alertService: AlertService;
    private _changeDetect: ChangeDetectorRef;
    private _uploadService: NgxfUploaderService;
    private _authService: AuthService;
    private route: ActivatedRoute;
    private _speechRecognitionService: SpeechRecognitionService;
    private _resourceService: GenericService<ResourcePermission>;
    private _sessionStorage: SessionStorageService;
    private zone: NgZone;
    private _storeService: DataStoreService;
    private _httpService: CommonHttpService;
    private intakeUtils: IntakeUtils;
    private _intakeConfig: IntakeConfigService;
    private _commonHttpService: CommonHttpService;
    private _router: Router;

    constructor(private injector: Injector) {
        this.formBuilder = injector.get<FormBuilder>(FormBuilder);
        this.speechRecognizer = injector.get<SpeechRecognizerService>(SpeechRecognizerService);
        this._alertService = injector.get<AlertService>(AlertService);
        this._changeDetect = injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._uploadService = injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._authService = injector.get<AuthService>(AuthService);
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this._speechRecognitionService = injector.get<SpeechRecognitionService>(SpeechRecognitionService);
        this._resourceService = injector.get<GenericService<ResourcePermission>>(GenericService);
        this._sessionStorage = injector.get<SessionStorageService>(SessionStorageService);
        this.zone = injector.get<NgZone>(NgZone);
        this._storeService = injector.get<DataStoreService>(DataStoreService);
        this._httpService = injector.get<CommonHttpService>(CommonHttpService);
        this.intakeUtils = injector.get<IntakeUtils>(IntakeUtils);
        this._intakeConfig = injector.get<IntakeConfigService>(IntakeConfigService);
        this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
        this._router = injector.get<Router>(Router);
        this.speechRecogninitionOn = false;
        this.speechData = '';
        this.store = this._storeService.getCurrentStore();
    }

    ngOnInit() {
        this.id = this._storeService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.agency = this._authService.getAgencyName();
        this.currentLanguage = 'en-US';
        this.speechRecognizer.initialize(this.currentLanguage);
        this.notification = null;
        this.roleName = this._authService.getCurrentUser();
        this.involevedPerson = [];
        this.getInvolvedPerson();
        const caseData = this._sessionStorage.getObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD);
        this.providerDetails = [];
        if (caseData && caseData.providerdetails && caseData.providerdetails.length) {
            const providerInfo = caseData.providerdetails[0];
            if (providerInfo.parent1providerid) {
                const obj = {
                    name: 'Parent 1',
                    providerid: providerInfo.parent1providerid,
                    providername: providerInfo.parent1providername,
                    signdate: providerInfo.parent1signdate
                }
                this.providerDetails.push(obj);
            }
            if (providerInfo.parent2providerid) {
                const obj = {
                    name: 'Parent 2',
                    providerid: providerInfo.parent2providerid,
                    providername: providerInfo.parent2providername,
                    signdate: providerInfo.parent2signdate
                }
                this.providerDetails.push(obj);
            }
        }
    }

    getInvolvedPerson() {
        let reqObj = {};
        reqObj = {
            intakeserviceid: this.id
        };

        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: reqObj
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
            )
            .subscribe(res => {
                if (res && res['data']) {
                    this.involevedPerson = res['data'];
                }
            });
    }
}