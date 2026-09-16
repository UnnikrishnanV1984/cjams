import { Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import _ from 'lodash';
import { CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { RowgridAttributes } from './ViewAssessmentCansSummary.model';
import { ViewAssessmentCansSummaryService } from './view-assessment-cans-summary.service';
import { CommonModule } from '@angular/common';

@Component({
    selector: 'view-assessment-cans-summary',
    templateUrl: './view-assessment-cans-summary.component.html',
    styleUrls: ['./view-assessment-cans-summary.component.scss'],
    imports:[CommonModule],
    providers: [ViewAssessmentCansSummaryService],
    standalone: true
})
export class ViewAssessmentCansSummaryComponent implements OnInit, OnChanges {
  si_level!: string;
  printButtonEnable: boolean = false;
  qrtp_recommendation!: string;
  defaultValue: string = 'N/A';
  row1grid1!: RowgridAttributes | null;
  row1grid2!: RowgridAttributes | null;
  row2grid1!: RowgridAttributes | null;
  row2grid2!: RowgridAttributes | null;
  row2grid3!: RowgridAttributes | null;
  ratings: any[] = ['0','1','2','3'];
  
  @Input() sinl: any = new BehaviorSubject(null);

  constructor(
    private _dataStoreService: DataStoreService,
    private _viewAssessmentCansSummaryService: ViewAssessmentCansSummaryService,
    private _commonService: CommonHttpService
    ) {}

  // When ever summary tab is clicked modified data changes can be re-calculated
  ngOnChanges(changes: SimpleChanges): void {
    this.sinl = this._dataStoreService.getData('PRINTDATA'); // Fetch page data from localstorage
    // let checkDataIfThere = _.isEmpty(this.sinl?.childform);
    this.retriveDataFn();
  }

  ngOnInit(): void {
    this.si_level = this.defaultValue;
    this.qrtp_recommendation = this.defaultValue;
    this.retriveDataFn();
  }

  retriveDataFn () {
    // When ever transaction opens removing the cached data
    this.row1grid1 = this.row1grid2 = this.row2grid1 = this.row2grid2 = this.row2grid3 = null;
    if(!_.isEmpty(this.sinl?.childform)){
      this.printButtonEnable = true;
      const ben_criterion_rating_count  = this._viewAssessmentCansSummaryService.countFn(this._viewAssessmentCansSummaryService.ben_criterion,this.sinl.childform,'2','3'); // To get calculated 3's and 2's count of ben criterion (CHILD BEHAVIORAL / EMOTIONAL HEALTH) 
      const risk_criterion_rating_count = this._viewAssessmentCansSummaryService.countFn(this._viewAssessmentCansSummaryService.risk_criterion,this.sinl.childform,'2','3'); // To get calculated 3's and 2's count of risk criterion (CHILD RISK BEHAVIORS)
      const ldf_criterion_rating_count = this._viewAssessmentCansSummaryService.countFn(this._viewAssessmentCansSummaryService.ldf_criterion,this.sinl.faceLifeForm,'2','3'); // To get calculated 3's and 2's count of ldf criterion (LIFE DOMAIN FUNCTIONING)
      const psychosis = (this.sinl.childform['psychosis_rating'] === '3') ? 1 : this.returnPsychosisRatingFn(); // Get the psychosis value from this.sinl
      const serviceLevelOutput = this._viewAssessmentCansSummaryService.ben_risk_ldf_criterion_rating(ldf_criterion_rating_count,risk_criterion_rating_count,ben_criterion_rating_count,psychosis); // Final out of serviceLevelOutput after calculation
      this.si_level = (_.isNil(serviceLevelOutput)) ? 'Low' : serviceLevelOutput;
  
      // Based on Service Intensity Need Level value displaying QRTP Recommendation acordingly
      if(serviceLevelOutput === this._viewAssessmentCansSummaryService.serviceLevelStatus.severe || serviceLevelOutput === this._viewAssessmentCansSummaryService.serviceLevelStatus.significant || serviceLevelOutput === this._viewAssessmentCansSummaryService.serviceLevelStatus.mwr) {
        this.qrtp_recommendation = 'Recommended';
      } else {
        this.qrtp_recommendation = 'Not Recommended';
      }
  
      // Useful Strength and Potential Strengths to Develop / Build	 grid
      this.row1grid1 = this._viewAssessmentCansSummaryService.displayNameOnselectedOptionFn(this._viewAssessmentCansSummaryService.useful_strength,this.sinl.childform,this._viewAssessmentCansSummaryService.useful_strength_rating,{cotp:[],suitp:[],csd:[],nscb:[]});

      // Trauma Experiences (Over Lifetime)	grid
      this.row1grid2 = this._viewAssessmentCansSummaryService.displayNameOnselectedOptionFn(this._viewAssessmentCansSummaryService.trauma_experiences,this.sinl.traumaform,this._viewAssessmentCansSummaryService.trauma_experiences_rating,{teol: []});

      // // Action Needed (Youth) and	Immediate/Intensive Action Needed (Youth) grid
      const row2grid1Temp1 = this._viewAssessmentCansSummaryService.displayNameOnselectedOptionFn(this._viewAssessmentCansSummaryService.trauma_stress,this.sinl.traumaform,this._viewAssessmentCansSummaryService.trauma_stress_rating,{tss2: [],tss3: []});
      // culture_factors
      const row2grid1Temp2 = this._viewAssessmentCansSummaryService.displayNameOnselectedOptionFn(this._viewAssessmentCansSummaryService.culture_factors,this.sinl.cultureFactorForm,this._viewAssessmentCansSummaryService.trauma_stress_rating,{tss2: row2grid1Temp1.tss2,tss3:row2grid1Temp1.tss3});
      // life_domain_functions
      const row2grid1Temp3 = this._viewAssessmentCansSummaryService.displayNameOnselectedOptionFn(this._viewAssessmentCansSummaryService.life_domain_functions,this.sinl.faceLifeForm,this._viewAssessmentCansSummaryService.trauma_stress_rating,{tss2: row2grid1Temp2.tss2,tss3: row2grid1Temp2.tss3});
      // child_risk_behaviors
      const row2grid1Temp4 = this._viewAssessmentCansSummaryService.displayNameOnselectedOptionFn(this._viewAssessmentCansSummaryService.child_risk_behaviors,this.sinl.childform,this._viewAssessmentCansSummaryService.trauma_stress_rating,{tss2: row2grid1Temp3.tss2,tss3: row2grid1Temp3.tss3});
      this.row2grid1 = row2grid1Temp4;

      // Emerging Adult Action Needed and	Emerging Adult Immediate/Intensive Actionable Needed grid
      this.row2grid2 = this._viewAssessmentCansSummaryService.displayNameOnselectedOptionFn(this._viewAssessmentCansSummaryService.emergin_adult,this.sinl.transitionForm,this._viewAssessmentCansSummaryService.emergin_adult_rating,{ead2: [],ead3: []});
      
      // Action Needed (Caregiver) and	Immediate/Intensive Action Needed (Caregiver) grid
      const row2grid3Temp = this._viewAssessmentCansSummaryService.displayNameOnselectedOptionFn(this._viewAssessmentCansSummaryService.permanency_plan,this.sinl.permanencyPlanform,this._viewAssessmentCansSummaryService.permanency_plan_rating,{pp2: [],pp3: []});
      this.row2grid3 = this._viewAssessmentCansSummaryService.cgFormatter(this._viewAssessmentCansSummaryService.current_caregiver_needs_and_strength,this.sinl.careGiver,this._viewAssessmentCansSummaryService.current_caregiver_needs_and_strength_rating, row2grid3Temp);
    } else {
      this.printButtonEnable = false;
    }
  }

  private returnPsychosisRatingFn() {
    return (this.sinl.childform['psychosis_rating'] === '2') ? 2 : 0;
  }

  downloadCansSummarySection() {
    const modal = {
      method: 'post',
      where: {
          "documenttemplatekey": [
              "cansSummarySheet"
            ],
            "payload": {...{si_level: this.si_level,qrtp_recommendation: this.qrtp_recommendation},...this.row1grid1,...this.row1grid2,...this.row2grid1,...this.row2grid2,...this.row2grid3},
      },
      limit: 10,
      order: 'desc',
      page: 1,
      count: -1
    };

    this._commonService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
            const blob = new Blob([new Uint8Array(res)]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = `cansSummarySheet.pdf`;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
    }

    get ppDataFn(): any[] {
      if (!this.row2grid3?.pp2 || !this.row2grid3?.pp3) {
        return [];
      }
      return this.row2grid3.pp2.length > this.row2grid3.pp3.length ? this.row2grid3.pp2 : this.row2grid3.pp3;
    }

    get eadDataFn(): any[] {
      if (!this.row2grid2?.ead2 || !this.row2grid2?.ead3) {
        return [];
      }
      return this.row2grid2.ead2.length > this.row2grid2.ead3.length ? this.row2grid2.ead2 : this.row2grid2.ead3;
    }

    get tssDataFn(): any[] {
      if (!this.row2grid1?.tss2 || !this.row2grid1?.tss3) {
        return [];
      }
      return this.row2grid1.tss2.length > this.row2grid1.tss3.length ? this.row2grid1.tss2 : this.row2grid1.tss3;
    }

    get csdDataFn(): any[] {
      if (!this.row1grid1?.csd || !this.row1grid1?.nscb) {
        return [];
      }
      return this.row1grid1.csd.length > this.row1grid1.nscb.length ? this.row1grid1.csd : this.row1grid1.nscb;
    }

    get suitpDataFn(): any[] {
      if (!this.row1grid1?.suitp || !this.row1grid1?.cotp) {
        return [];
      }
      return this.row1grid1.suitp.length > this.row1grid1.cotp.length ? this.row1grid1.suitp : this.row1grid1.cotp;
    }
    
}
