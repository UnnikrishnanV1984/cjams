
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, ChangeDetectorRef, Injector } from '@angular/core';
import { Assessments, GetintakAssessment, IntakeAssessmentRequestIds, AssessmentScores } from '../../_entities/newintakeModel';
import { Observable ,  Subject } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { AuthService, GenericService, CommonHttpService, SessionStorageService, AlertService, DataStoreService } from '../../../../../@core/services';
import { DomSanitizer } from '@angular/platform-browser';
import { HttpService } from '../../../../../@core/services/http.service';
import { AppConfig } from '../../../../../app.config';
import { PaginationRequest, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { IntakeStoreConstants } from '../../my-newintake.constants';

@Component({
    selector: 'intake-referral-assesmentsgrid',
    templateUrl: './intake-referral-assesmentsgrid.component.html',
    styleUrls: ['./intake-referral-assesmentsgrid.component.scss'],
    standalone: false
})
export class IntakeReferralAssesmentsgridComponent implements OnInit {

  showAssmnt!: boolean;
  startAssessment$!: Observable<Assessments[]>;
  getAsseesmentHistory: GetintakAssessment[] = [];
  private assessmentRequestDetail!: IntakeAssessmentRequestIds;
  showAssesment = -1;
  totalRecords$!: Observable<number>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageSubject$ = new Subject<number>();
  private token!: AppUser;
  assmntScores: AssessmentScores = new AssessmentScores();
  safeCKeys: string[];
  agency = '';
  id!: string;
  store: any;
  private _authService: AuthService;
  private _http: HttpService;
  private _commonService: CommonHttpService;
  private storage: SessionStorageService;
  private _alertService: AlertService;
  public sanitizer: DomSanitizer;
  constructor(
    private readonly injector : Injector,
    private _service: GenericService<Assessments>,
    private _cd: ChangeDetectorRef,
    private _dataStore: DataStoreService) {
      this._authService = this.injector.get<AuthService>(AuthService);
      this._http = this.injector.get<HttpService>(HttpService);
      this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
      this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
      this._alertService = this.injector.get<AlertService>(AlertService);
      this.sanitizer = this.injector.get<DomSanitizer>(DomSanitizer);

      this.store = this._dataStore.getCurrentStore();
      this.safeCKeys = [
          'caregiverdescribes',
          'caregiverfailstoprotect',
          'caregivermadeaplausible',
          'caregiverrefuses',
          'caregiversemotionalinstability',
          'caregiversexplanation',
          'caregiversjustification',
          'caregiverssuspected',
          'childscurrentimminent',
          'childsexualabuse',
          'childswhereabouts',
          'currentactofmaltreatment',
          'domesticviolence',
          'extremelyanxious',
          'multiplereports',
          'servicestothecaregiver',
          'specialneeds',
          'unabletoprotect',
          'servicestothecaregiver2'
      ];
     }

  ngOnInit() {
    this.agency = this._authService.getAgencyName();
    this.id = this.store[IntakeStoreConstants.intakenumber];
    this.token = this._authService.getCurrentUser();
    this.pageSubject$.subscribe((pageNumber) => {
        this.paginationInfo.pageNumber = pageNumber;
        this.getPage(this.paginationInfo.pageNumber);
    });

    this.getIntakeAssessmentDetails();
    this.getPage(1);
  }

  showAssessment(id: number, row: any) {
    this.getAsseesmentHistory = row;
    if (this.showAssesment !== id) {
      this.showAssesment = id;
    } else {
      this.showAssesment = -1;
    }
  }

  isAssmentCompelete(submissionData: any) {
    if (submissionData) {
      if (submissionData.Complete === true) {
        return 1;
      }
      if (submissionData.submit === true) {
        return 2;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  getPage(page: number) {
    if (this.assessmentRequestDetail) {
        this._http.overrideUrl = false;
        this._http.baseUrl = AppConfig.baseUrl;
        this.showAssesment = -1;
        const source = this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: this.paginationInfo.pageSize,
                    where: this.assessmentRequestDetail,
                    method: 'get'
                }),
                'admin/assessmenttemplate/getintakeassessment?filter'
            ).pipe(
            map(result => {
                this.getDRAIScore(result);
                this.getMCAPScore(result);
                return { data: result.data, count: result.count };
            }),
            share(),);
        this.startAssessment$ = source.pipe(pluck('data'));
        if (page === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
        }
    }
}

getDRAIScore(result: any) {
  if (result && result.data) {
      result.data.forEach((element: any) => {
          if (element.titleheadertext === 'Intake Detention Risk Assessment Instrument') {
              if (element.intakassessment && element.intakassessment.length > 0) {
                  const latestDrai = element.intakassessment[0].submissiondata;
                  const scores = {
                      score: latestDrai.score,
                      value: latestDrai.value,
                      AD: latestDrai.AD,
                      SD: latestDrai.SD,
                      SD2: latestDrai.SD2
                  };
                  this.assmntScores.DRAI = scores;
                  this._dataStore.setData(IntakeStoreConstants.assessmentScore, this.assmntScores);
              }
          }
      });
  }
}
getMCAPScore(result: any) {
  if (result && result.data) {
      result.data.forEach((element: any) => {
          if (element.titleheadertext === 'MCASP Risk Assessment') {
              if (element.intakassessment && element.intakassessment.length > 0) {
                  const latestMcasp = element.intakassessment[0].submissiondata;
                  const scores = {
                      dhs: latestMcasp.dhs1,
                      shs: latestMcasp.shs2,
                      risklevel: latestMcasp.risklevel
                  };
                  this.assmntScores.MCASP = scores;
                  this._dataStore.setData(IntakeStoreConstants.assessmentScore, this.assmntScores);
              }
          }
      });
  }
}


private getIntakeAssessmentDetails() {
  this.assessmentRequestDetail = Object.assign({});
  this.token = this._authService.getCurrentUser();
  const assessmentRequest = new IntakeAssessmentRequestIds();
  assessmentRequest.intakeservicerequesttypeid = '';
  assessmentRequest.intakeservicerequestsubtypeid = '';
  assessmentRequest.agencycode = this.agency;
  assessmentRequest.intakenumber = this.id;
  assessmentRequest.target = 'Intake';
  this.assessmentRequestDetail = assessmentRequest;
  this.getPage(1);
}

}
