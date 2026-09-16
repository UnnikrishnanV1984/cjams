import { Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { MatDialog} from '@angular/material/dialog';
import { NavigationUtils } from '../../../pages/_utils/navigation-utils.service';
declare var $: any;
import { AuthService, AlertService, SessionStorageService, DataStoreService } from '../../../@core/services';
import { RecordingNotes } from '../title-ive-foster-car/narratives/iveNarrativeModel';
import { Titile4eUrlConfig } from '../_entities/title4e-dashboard-url-config';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'guardianship',
    templateUrl: './titleIVe-guardianship.component.html',
    styleUrls: ['./titleIVe-guardianship.component.scss'],
    standalone: false
})
export class GuardianshipComponent implements OnInit {
    progressNote: RecordingNotes = new RecordingNotes();
    clientId: any;
    removalId: any;
    gapSubsidyId: any;
    userInfo: any;
    gapData: any;
    placementId: any;
    isCLW: any;
    detStatusMsgData: any[]=[];
    summaryinfo: any;
    child_name: any;
    agency: any;
  moduleview: any;
  activeModule: any;

  private _commonHttpService: CommonHttpService;
  private activatedRoute: ActivatedRoute;
  public _authService: AuthService;
  private _dataStore: DataStoreService;
  private _alertService: AlertService;
  private storage: SessionStorageService;

  constructor(private injector: Injector, public dialog: MatDialog, private navigateutil: NavigationUtils) {
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.activatedRoute = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._dataStore = this.injector.get<DataStoreService>(DataStoreService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);

    this.activatedRoute.data.subscribe(response => {
      if (response.gapData) {
        this.gapData = response.gapData.gapeligibilityworksheet;
        this.summaryinfo = this.gapData.demographicsInfo && this.gapData.demographicsInfo.length > 0 ? this.gapData.demographicsInfo[0] : null;
        this.child_name = this.gapData.demographicsInfo && this.gapData.demographicsInfo.length > 0 ? this.gapData.demographicsInfo[0].childname : null;
        this.clientId = this.activatedRoute.snapshot.paramMap.get('clientid');
        this.gapSubsidyId = this.activatedRoute.snapshot.paramMap.get('removalId');
        this.removalId = this.gapData.demographicsInfo && this.gapData.demographicsInfo.length > 0 ? this.gapData.demographicsInfo[0].al_removal_id : null;
        this._authService.setAuthDetail('ivegap', response.gapData.userresources);
        this._dataStore.setData('ivepersonnameselected', this.child_name);
        this._dataStore.setData('ivepersoncjamspidselected', this.clientId);
      }

    });

  }

    ngOnInit() {
      this.moduleview = this._authService.isModuleAccessable('ivegap', 'ivegap');
      this.userInfo = this._authService.getCurrentUser();
      this.getNarrative(this.clientId);
      this.activeModule = this.storage.getItem('activeModuleNav');
      if(this.activeModule === '4E Analyst'){
        this.getcaseassignment();
      }else{
        this._dataStore.setData('isivereadonly', false);
      }
      this.activatedRoute.queryParams.subscribe(params => {
        if(params['retrydocument']) {
          $('#attachmentBtnTrigger').click();          
        }
      });
    }

    getcaseassignment() {
      const data = {
        clientId: this.clientId,
        removalId: this.removalId,
        module: 'gap'
      }
      this._commonHttpService.create(data, Titile4eUrlConfig.EndPoint.getiveassignment).subscribe(
        (response: any) => {
          if(response && response.length > 0 && response[0].getiveassignment === this.userInfo.user.securityusersid){
            this._dataStore.setData('isivereadonly', false);
          }else{
            this._dataStore.setData('isivereadonly', true);
          }
        });
    }

    navigateCaseNumber(data: any){
      this.navigateutil.routToServiceCase(data);
    }
    navigateToFostercare(){
      this.navigateutil.loadFostcareIVE(this.clientId, this.removalId, this.placementId );
    }

    submitDetermination(){
      const eligibilityBtn = document.getElementById('gapEligibilityDetailsBtnTrigger');
      if (eligibilityBtn) {
          eligibilityBtn.click();
      }
    }

    
    getNarrative(clientId:any) {
      this._commonHttpService
      .create(
        {entitytypeid: clientId,
          entitytype: 'IVEGAP'},
          Titile4eUrlConfig.EndPoint.getNarrative
      )
      .subscribe(
          (response: any) => {
              if (response && response.length > 0 && response[0] !== '') {
                this.progressNote = response[0];
                this._dataStore.setData('addNarrative', true);
              }
              else{
                this._dataStore.setData('addNarrative', false);
              }
          },
          error => {
              return false;
          }
      );
    }
    addUpdateNarrative() {
       // hard coded progressnotetypeid to 'note' type and entitytype to 'IVEGAP'
        this.progressNote.progressnotetypeid = 'a1f78e9f-ea8d-4f0b-8df5-7d4c0eda21cc';
        this.progressNote.entitytypeid = this.clientId;
        this.progressNote.entitytype = 'IVEGAP';
        this._commonHttpService
            .create(
                this.progressNote,
                Titile4eUrlConfig.EndPoint.addUpdateNarrative
            )
            .subscribe(
                (response: any) => {
                    if (response) {
                      this._alertService.success('Narrative saved successfully.');
                      this.getNarrative(this.clientId);
                    }
                },
                error => {
                    this._alertService.error('Unable to save narrative.');
                    this.getNarrative(this.clientId);
                    return false;
                }
            );
    }

}
