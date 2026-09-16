import { Component, OnInit, AfterViewInit } from '@angular/core';
import { FormArray, FormGroup } from '@angular/forms';
import { ControlUtils } from '../../../../@core/common/control-utils';
import { CheckboxModel, DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService, DataStoreService } from '../../../../@core/services';
import { Observable  } from 'rxjs';

import { ReportSummary, PersonAddress, AssessmentScores } from '../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { SpeechSynthesizerService } from '../../../../shared/modules/web-speech/shared/services/speech-synthesizer.service';
import { IntakeStoreConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'report-summary-djs',
    templateUrl: './report-summary-djs.component.html',
    styleUrls: ['./report-summary-djs.component.scss'],
    standalone: false
})
export class ReportSummaryDjsComponent implements OnInit, AfterViewInit {
    disableNo!: boolean;
    disableAddress!: boolean;
    id: string;
    daNumber: string;
    possibleIllegalActivityDropdown!: FormArray;
    reportSummaryForm!: FormGroup;
    illegalActivityDd = false;
    significantEventDd = false;
    significantEventDropdownItems$!: Observable<DropdownModel[]>;
    sourceDropdownItems$!: Observable<DropdownModel[]>;
    possibleCheckboxItems: CheckboxModel[] = [];
    reportSummary!: ReportSummary;
    reportSummaryDangerAddress!: PersonAddress;
    disabledetention = false;
    private selectedIllegalActivities: string[] = [];
    private speaking = false;
    private paused = false;
    private voiceNotStarted = true;
    private config = { 'isNarrativeNeeded': true, 'youthSummary': false };
    headerSummary: any;
    assmentScores: AssessmentScores = { DRAI: null, MCASP: null };
    isDetention!: boolean;
    youthStatus: any[] = [];
    detentionDescription!: string;
    notesPlaceholder = 'Detention Notes...';
    constructor(
        private _authService: AuthService,
        private _alertService: AlertService,
        private _commonHttpService: CommonHttpService,
        private _reportSummaryService: GenericService<ReportSummary>,
        private _dataStoreService: DataStoreService,
        private _speechSynthesizer: SpeechSynthesizerService
    ) {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }
    ngOnInit() {
        this._dataStoreService.currentStore.subscribe(storeObj => {
            const youthStatus = storeObj[IntakeStoreConstants.youthStatus];
            if (youthStatus && Array.isArray(youthStatus)) {
                this.isDetention = youthStatus.includes('Detention');
            }
        });
        this._speechSynthesizer.initSynthesis();


        this._dataStoreService.currentStore.subscribe((store) => {
            if (store['da_status'] === 'Closed') {
                ControlUtils.disableElements($('#Involved-Persons').children());
            }
            if (store['dsdsActionsSummary']) {
                this.headerSummary = store['dsdsActionsSummary'];
            }

        });
        if (this.id !== '0') {
            this.listReportSummary(this.id);
        }
    }

    ngAfterViewInit() {
        const intakeCaseStore = this._dataStoreService.getData('IntakeCaseStore');
        if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
            this.disabledetention = true;
            $(':button').prop('disabled', true);
            $('dd button').css({'pointer-events': 'none',
                                    'cursor': 'default',
                                    'opacity': '0.5',
                                    'text-decoration': 'none'});
        }
    }

    openDetentionNotesPopup() {
        this.detentionDescription = '';
        $('#detention-notes').modal('show');
    }

    toggleDetetionStatus() {
        if (!this.detentionDescription) {
            this._alertService.warn('Please enter Detention notes.');
            return;
        }
        const request: any = {
            personid: this._dataStoreService.getData('da_personid'),
            focuspersonstatustypekey: 'DET',
            status: '',
            intakeserviceid: this.id,
            intakenumber: this._dataStoreService.getData('da_intakenumber'),
            opennotes: null,
            closenotes: null
        };

        if (!this.isDetention) {
            request.status = 'Open';
            request.opennotes = this.detentionDescription;
        } else {
            request.status = 'Closed';
            request.closenotes = this.detentionDescription;
        }

        this._commonHttpService.create(request, CommonUrlConfig.EndPoint.PERSON.YOUTHSTATUS.UpdateStatus).subscribe(result => {
            this._alertService.success('Youth Status Updated successfully!');
            this._dataStoreService.setData(IntakeStoreConstants.statusChanged, true);
            $('#detention-notes').modal('hide');
        }, error => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        });
    }
    private listReportSummary(id: string) {
        this._reportSummaryService.getSingle(new PaginationRequest({}),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + this.id).subscribe((result) => {
                this.reportSummary = result;
                this._dataStoreService.setData('da_intakeservicerequestactor', result.intakeservicerequestactor);
                this.processAssessmentScore(this.reportSummary['assessments']);
            });
    }

    downloadDocument(document: any) {
        this._dataStoreService.setData('documentsToDownload', [document.key]);
    }

    processAssessmentScore(givenAssessments: any) {
        if (givenAssessments) {
            givenAssessments.forEach((assessments: any) => {
                if (assessments.intakassessment && assessments.intakassessment.length > 0) {
                    if (assessments.intakassessment[0].titleheadertext === 'Intake Detention Risk Assessment Instrument') {
                        const latestDrai = assessments.intakassessment[0].submissiondata;
                        const scores = {
                            score: latestDrai.score,
                            value: latestDrai.value,
                            AD: latestDrai.AD,
                            SD: latestDrai.SD,
                            SD2: latestDrai.SD2
                        };
                        this.assmentScores.DRAI = scores;
                    }
                    if (assessments.intakassessment[0].titleheadertext === 'MCASP Risk Assessment') {
                        const latestMcasp = assessments.intakassessment[0].submissiondata;
                        const scores = {
                            dhs: latestMcasp.dhs1,
                            shs: latestMcasp.shs2,
                            risklevel: this.setMCASPRiskLevel(latestMcasp.risklevel)
                        };
                        this.assmentScores.MCASP = scores;
                    }
                }
            });
        }
    }

    setMCASPRiskLevel(risklevel: string): string {
        switch (risklevel) {
            case 'h':
            case 'H':
                return 'High';
            case 'l':
            case 'L':
                return 'Low';
            case 'm':
            case 'M':
                return 'Moderate';
            default:
                return risklevel;
        }
    }



}
