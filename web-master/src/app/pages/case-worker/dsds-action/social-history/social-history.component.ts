import { Component, OnInit, OnDestroy, Injector } from '@angular/core';
import { SocialHistoryService } from './social-history.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AuthService, AlertService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { SpeechRecognitionService } from '../../../../@core/services/speech-recognition.service';
import { ActivatedRoute } from '@angular/router';
import { environment } from '../../../../../environments/environment';

@Component({
    selector: 'social-history',
    templateUrl: './social-history.component.html',
    styleUrls: ['./social-history.component.scss'],
    standalone: false
})

export class SocialHistoryComponent implements OnInit, OnDestroy {
  childList: any[] = [];
  selectedChild: any;
  selection: any;
  selectedHist: any;
  history: any;
  socialHistoryFormGroup!: FormGroup;
  childCardFormGroup!: FormGroup;
  isClosed = false;
  speechData!: string;
  speechRecogninitionOn!: boolean;
  recognizing: any = '';
  notification!: string;
  addNewSocialHist:boolean = false;
  selectedNewPerson!: string;
  moduleview: any;
  isReadonly: boolean = false;
  checkmandatory: boolean = false;
  environment = environment;
  addrecordpopupid = '#add-record';

    private _SocialHistoryService: SocialHistoryService;
    private _formBuilder: FormBuilder;
    private _alertService: AlertService;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;
    private _speechRecognitionService: SpeechRecognitionService;
    public _authService: AuthService;
    private route: ActivatedRoute;

    constructor( private injector:Injector) {
      this._SocialHistoryService = this.injector.get<SocialHistoryService>(SocialHistoryService);
      this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
      this._speechRecognitionService = this.injector.get<SpeechRecognitionService>(SpeechRecognitionService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this.route= this.injector.get<ActivatedRoute>(ActivatedRoute);
      this._SocialHistoryService= this.injector.get<SocialHistoryService>(SocialHistoryService);

      this.route.data.subscribe(data => {
        if (data && data.hasOwnProperty('result')) {
          this._authService.setAuthDetail('socialhistory',data.result);
        }
    });
     }

  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('socialhistory', 'socialhistory');
    const childList = this._SocialHistoryService.getChildList();
    this.childList = childList.filter((data: {removalStatus: any;}) => data.removalStatus === 'Approved');
    this.initForm();
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
        this.isReadonly = false;
    } else {
        this.isReadonly = this._authService.readonlyButton('read_only_access', 'readonly-social-history');
    }
    const da_status = this.storage.getItem('da_status');
    if (da_status) {
     if (da_status === 'Closed' || da_status === 'Completed') {
         this.isClosed = true;
     } else {
         this.isClosed = false;
     }
    }
  }

  initForm() {
    this.socialHistoryFormGroup = this._formBuilder.group({
      placement: ['', Validators.required],
      familyhistory: ['', Validators.required],
      childdesc: ['', Validators.required],
      socialhistoryid : [null],
      personid: [null]
    });

    this.childCardFormGroup = this._formBuilder.group({
      child: [null],
    });
  }

  viewChildInfo(child: any) {
    if (child &&  child.intakeservicerequestactorid) {
      this.selectedChild = child;

      this._SocialHistoryService.getSocialHistoryList(child.intakeservicerequestactorid)
      .subscribe(data => {
        this.getSocialHistoryListApiResponse(data);
      });
    }  else  {
      this.history = [];
    }
  }

  private getSocialHistoryListApiResponse(data: any[]) {
    if (data && data.length) {
      data.forEach(element => {
        element.placement = element.placement !== null ? element.placement : '';
        element.familyhistory = element.familyhistory !== null ? element.familyhistory : '';
        element.childdesc = element.childdesc !== null ? element.childdesc : '';

      });
      this.history = data;
    }
  }

  selectHist(item: any) {
    this.selectedHist = item;
    this.socialHistoryFormGroup.patchValue(item);
  }

  resetSelectedChild() {
    this.selectedChild = null;
    this.selectedHist = null;
    this.addNewSocialHist = false;
    this.clearForm();
  }

  clearForm() {
    this.socialHistoryFormGroup.reset();
    this.childCardFormGroup.reset();
  }

  addNewHist(selectedChild: any) {
    if(selectedChild.isbioadoptedflag === 1){
      (<any>$('#bioadoptedflag')).modal('show');
      return;
    }
    this.addNewSocialHist = true;
    this.selectedNewPerson = selectedChild;
    const item: any = {};
    item['placement'] = '';
    item['familyhistory'] = '';
    item['childdesc'] = '';
    
    if (this.history === undefined) {
      this.history = [];
    }
    if (this.history.length === 0){
      this.history = [item];
    }else if (this.history.length >= 1){

      $(this.addrecordpopupid).show();
    }else {
      this.history.unshift(item);
    }
  }

  addHist(selectedChild: any) {
    const data = this.socialHistoryFormGroup.getRawValue();
    this._SocialHistoryService.createSocialHistory(selectedChild.intakeservicerequestactorid, data).subscribe((item2) => {
      this._alertService.success('History created successfully!');

      this._SocialHistoryService.getSocialHistoryList(selectedChild.intakeservicerequestactorid).subscribe((item) => {
         
         
        item.forEach(element1 => {
          element1.placement = element1.placement!==null ? element1.placement : '';
          element1.familyhistory = element1.familyhistory!==null ? element1.familyhistory : '';
          element1.childdesc  = element1.childdesc!==null ? element1.childdesc : '';        
        });
        this.history = item;
        this.selectHist(item[0]);
      });
    });
  }

  save() {
    this.checkmandatory = true;
    if(!this.socialHistoryFormGroup.invalid){
    if (this.addNewSocialHist === true) {
      this.addHist(this.selectedNewPerson);
      this.addNewSocialHist = false;
    }
    else {
    const data = this.socialHistoryFormGroup.getRawValue();
    this._SocialHistoryService.patchData(data)
    .subscribe(
      response => {
        this._alertService.success('Social history information saved successfully!');

        this._SocialHistoryService.getSocialHistory(this.selectedChild.intakeservicerequestactorid)
      .subscribe(data1 => {
        if (data1 && data1.length) {
          this.getSocialHistoryResponseFn(data1);
        }
      });
      },
      error => {
        this._alertService.error('Error in entering social history information!');
      }
    );
    }
  }
  }
  private getSocialHistoryResponseFn(data: any[]) {
    data.forEach(element2 => {
      element2.placement = element2.placement !== null ? element2.placement : '';
      element2.familyhistory = element2.familyhistory !== null ? element2.familyhistory : '';
      element2.childdesc = element2.childdesc !== null ? element2.childdesc : '';

    });

    this.getSocialHistoryListApiFn();
  }

  private getSocialHistoryListApiFn() {
    this._SocialHistoryService.getSocialHistoryList(this.selectedChild.intakeservicerequestactorid).subscribe(data1 => {
      if (data1 && data1.length) {
        data1.forEach(element3 => {
          element3.placement = element3.placement !== null ? element3.placement : '';
          element3.familyhistory = element3.familyhistory !== null ? element3.familyhistory : '';
          element3.childdesc = element3.childdesc !== null ? element3.childdesc : '';
        });
        this.history = data1;
        this.checkmandatory = false;
      }
    });
  }

  activateSpeechToText(type: any): void {
    this.recognizing = type;
    this.speechRecogninitionOn = !this.speechRecogninitionOn;
    if (this.speechRecogninitionOn) {
      this._speechRecognitionService.record().subscribe(
        // listener
        (value) => {
          this.speechData = value;
          switch (type) {
            case 'placement':
              const placement = this.socialHistoryFormGroup.getRawValue().placement;
              this.socialHistoryFormGroup.patchValue({ placement: placement + ' ' + this.speechData });
              break;
            case 'familyhistory':
              const familyhistory = this.socialHistoryFormGroup.getRawValue().familyhistory;
              this.socialHistoryFormGroup.patchValue({ familyhistory: familyhistory + ' ' + this.speechData });
              break;
            case 'childdesc':
              const childdesc = this.socialHistoryFormGroup.getRawValue().childdesc;
              this.socialHistoryFormGroup.patchValue({ childdesc: childdesc + ' ' + this.speechData });
              break;
            default: break;
          }
        },
        // errror
        (err) => {
          console.error(err);
          this.recognizing = false;
          if (err.error === 'no-speech') {
            this.notification = `No speech has been detected. Please try again.`;
            this._alertService.warn(this.notification);
            this.activateSpeechToText(type);
          } else if (err.error === 'not-allowed') {
            this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
            this._alertService.warn(this.notification);
          } else if (err.error === 'not-microphone') {
            this.notification = `Microphone is not available. Please verify the connection of your microphone and try again.`;
            this._alertService.warn(this.notification);
          }
        },
        // completion
        () => {
          this.speechRecogninitionOn = true;
           
          this.activateSpeechToText(type);
        }
      );
    } else {
      this.recognizing = '';
      this.deActivateSpeechRecognition();
    }
  }

  deActivateSpeechRecognition() {
    this.speechRecogninitionOn = false;
    this._speechRecognitionService.destroySpeechObject();
  }

  ngOnDestroy(): void {
    this._speechRecognitionService.destroySpeechObject();
  }


  addrecord(){
    const item: any = {};
    item['placement'] = '';
    item['familyhistory'] = '';
    item['childdesc'] = '';
    this.history.unshift(item);
    $(this.addrecordpopupid).hide();
     
  }
  deleterecord(){
    this.addNewSocialHist = false;
    $(this.addrecordpopupid).hide();

  }
}
