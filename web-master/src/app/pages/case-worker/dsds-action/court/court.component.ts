import { ChangeDetectionStrategy, Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute ,Router} from '@angular/router';
import { CommonHttpService, AuthService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { CourtResolverService } from './court-resolver-service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'court',
    templateUrl: './court.component.html',
    styleUrls: ['./court.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})
export class CourtComponent implements OnInit {
  id: string;
  isCursorDisble: boolean;
  agency;
  moduleview: any;
  isAdoptioncase = false;
  constructor(
    private readonly _commonHttpService: CommonHttpService,
    private readonly _formBuilder: FormBuilder,
    private readonly route: ActivatedRoute,
    private readonly router :Router,
    private readonly _authService: AuthService,
    private readonly _dataStoreService: DataStoreService,
    private readonly _session: SessionStorageService,
    private courtResolverService: CourtResolverService
  ) {
    this.isCursorDisble = false;
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.agency = this._authService.getAgencyName();
  //   this.route.data.subscribe(data => {
  //     if (data && data.hasOwnProperty('result')) {
  //       _authService.setAuthDetail('court',data.result);
  //     }
  // });
  }

  ngOnInit() {
    this.courtResolverService.getCourt().subscribe({
        next: (data: any) => {
            this._authService.setAuthDetail('court',data);
        }
    })
    this.moduleview = this._authService.isModuleAccessable('court', 'court');
    const dsdsInfo = this._dataStoreService.getData('dsdsActionsSummary');
     if( dsdsInfo && dsdsInfo.adoptioncasenumber ){
       this.isAdoptioncase = true;
     }
     if(this.isAdoptioncase){
      this.router.navigate(['./court-tpr'], { relativeTo: this.route });
  }
  }
  

  getPetitionDetails() {
    this._commonHttpService
      .getArrayList(
        {
          where: {
            intakeservicerequestid: this.id
          },
          method: 'get'
        },
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionDetailslist}?filter`
      )
      .subscribe(res => {
        if (res[0]) {
          this.isCursorDisble = false;
        } else {
          this.isCursorDisble = true;
        }
      });
  }


}
