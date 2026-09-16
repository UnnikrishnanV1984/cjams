import {
    
    ChangeDetectorRef,
    Component,
    Injector,
    NgZone,
    OnDestroy,
    OnInit,
    ViewEncapsulation,
} from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NgxfUploaderService } from 'ngxf-uploader';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { DynamicObject } from '../../../../@core/entities/common.entities';
import { DataStoreService, GenericService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { AuthService } from '../../../../@core/services/auth.service';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import { SpeechRecognizerService } from '../../../../shared/modules/web-speech/shared/services/speech-recognizer.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { IntakeUtils } from '../../../_utils/intake-utils.service';
import { Subscription } from 'rxjs';
// From Intake :
import { IntakeConfigService } from '../../../newintake/my-newintake/intake-config.service';
import { ResourcePermission } from '../../../newintake/my-newintake/_entities/newintakeModel';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'narrative',
    templateUrl: './narrative.component.html',
    styleUrls: ['./narrative.component.scss', '../../../../../styles/trumbowyg.scss'],
    encapsulation: ViewEncapsulation.None,
    standalone: false
})
export class NarrativeComponent implements OnInit,  OnDestroy {
    intakeNarrativeForm!: FormGroup;
    speechRecogninitionOn: boolean;
    speechData: string;
    notification!: string | null;
    recognizing = false;
    viewCourt: boolean = false;
    roleName!: AppUser;
    currentLanguage!: string;

    quillToolbar!: {
        toolbar: (
            | string[]
            | { header: number }[]
            | { list: string }[]
            | { script: string }[]
            | { indent: string }[]
            | { direction: string }[]
            | { size: (string | boolean)[] }[]
            | { header: (number | boolean)[] }[]
            | ({ color: any[]; background?: any[] } | { background: any[]; color?: any[] })[]
            | { font: any[] }[]
            | { align: any[] }[])[];
    };
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
    moduleview: any;

    private formBuilder: FormBuilder;
    private speechRecognizer: SpeechRecognizerService;
    private _alertService: AlertService;
    public _authService: AuthService;
    private route: ActivatedRoute;
    private _speechRecognitionService: SpeechRecognitionService;
    private _storeService: DataStoreService;
    private _changeDetect: ChangeDetectorRef;
    private _uploadService: NgxfUploaderService;
    private zone: NgZone;
    private intakeUtils: IntakeUtils;
    private _intakeConfig: IntakeConfigService;
    private _router: Router;
    
    constructor(
        private readonly injector : Injector,
        private _commonHttpService: CommonHttpService,
        private _resourceService: GenericService<ResourcePermission>,
    ) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this.speechRecognizer = this.injector.get<SpeechRecognizerService>(SpeechRecognizerService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
        this._storeService = this.injector.get<DataStoreService>(DataStoreService);
        this._changeDetect = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this.zone = this.injector.get<NgZone>(NgZone);
        this.intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
        this._intakeConfig = this.injector.get<IntakeConfigService>(IntakeConfigService);
        this._router = this.injector.get<Router>(Router);

        this.route.data.subscribe((data: any) => {
            if (data && data.hasOwnProperty('result')) {
                this._authService.setAuthDetail('adoptionnarrative', data.result);
            }
        });
        this.speechRecogninitionOn = false;
        this.speechData = '';
        this.store = this._storeService.getCurrentStore();
    }

    ngOnInit() {
        this.moduleview = this._authService.isModuleAccessable('adoptionnarrative', 'adoptionnarrative');
        this.id = this._storeService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.agency = this._authService.getAgencyName();
        this.quillToolbar = {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
                ['blockquote', 'code-block'],

                [{ 'header': 1 }, { 'header': 2 }],               // custom button values
                [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                [{ 'script': 'sub' }, { 'script': 'super' }],      // superscript/subscript
                [{ 'indent': '-1' }, { 'indent': '+1' }],          // outdent/indent
                [{ 'direction': 'rtl' }],                         // text direction

                [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
                [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

                [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
                [{ 'font': [] }],
                [{ 'align': [] }],

                ['clean'],                                         // remove formatting button

                //   ['link', 'image', 'video']                         // link and image, video
            ]
        };
        this.narrativeForm();
        this.currentLanguage = 'en-US';
        this.speechRecognizer.initialize(this.currentLanguage);
        this.notification = null;
       

        this.roleName = this._authService.getCurrentUser();
     
        
       this.getNarrative();




       }





    private narrativeForm() {
        this.intakeNarrativeForm = this.formBuilder.group({
            narrative: [''],
            adoptioncaseid:[this.id],
            activeflag: [1],
        });
     
    }
   


  
    ngOnDestroy() {
       
        this._speechRecognitionService.destroySpeechObject();
        // (<any>$('#show-myModal')).modal('show');
    }

    activateSpeechToText(): void {
        this.recognizing = true;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
            let tempNarrative = '';
            this._speechRecognitionService.record().subscribe(
                // listener
                (value) => {
                     
                    tempNarrative = this.speechData.concat(value);
                    this.intakeNarrativeForm.patchValue({ narrative: tempNarrative });
                },
                // errror
                (err) => {
                    this.recognizing = false;
                    if (err.error === 'no-speech') {
                        this.notification = `No speech has been detected. Please try again.`;
                        this._alertService.warn(this.notification);
                        this.activateSpeechToText();
                    } else if (err.error === 'not-allowed') {
                        this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
                        this._alertService.warn(this.notification);
                    } else if (err.error === 'not-microphone') {
                        this.notification = `Microphone is not available. Plese verify the connection of your microphone and try again.`;
                        this._alertService.warn(this.notification);
                    }
                },
                // completion
                () => {
                    this.speechRecogninitionOn = true;
                     
                    this.activateSpeechToText();
                }
            );
        } else {
            this.recognizing = false;
            this.deActivateSpeechRecognition();
        }
    }
    deActivateSpeechRecognition() {
        this.speechRecogninitionOn = false;
        this._speechRecognitionService.destroySpeechObject();
    }

    saveNarrative() {
        const narrativeData = this.intakeNarrativeForm.getRawValue();
        this._commonHttpService.create(narrativeData, 'adoptioncase/addupdate').subscribe((result: any) => {
            if (result) {
                    this._alertService.success('Narrative saved successfully!');
            }
        });
    }

    getNarrative() {
        // this._commonHttpService
        //     .getPagedArrayList(
        //         new PaginationRequest({

        //             where: {
        //                 adoptioncaseid :this.id,
        //                 page :1,
        //                 limit:10
        //             },
        //             method: 'get'
        //         }),
        //          'adoptioncase/adoptioncaselistbyid?filter'
        //     ).
            this._commonHttpService.getArrayList({
                where: {
                    adoptioncaseid :this.id,
                    page :1,
                    limit:10
                },
                method: 'get'
            }, 'adoptioncase/adoptioncaselistbyid?filter').subscribe((response: any) => { 
                if(response && response.length) {
                this.intakeNarrativeForm.patchValue(response[0]);
                }
            });
           
    }

 
}