import { Component, OnInit } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../@core/services';
import { ActivatedRoute } from '@angular/router';
import { ServiceCaseParticipants } from './_entity';
import { Observable } from 'rxjs';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { ParticipationResolverService } from './participations-resolver-service';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'participations',
    templateUrl: './participations.component.html',
    styleUrls: ['./participations.component.scss'],
    standalone: false
})
export class ParticipationsComponent implements OnInit {
  id: string;
  isShow!: string;
  ServicecaseParticipants$!: Observable<ServiceCaseParticipants[]>;
  moduleview: any;
  constructor(private _commonHttpService: CommonHttpService,private _authService: AuthService, private route: ActivatedRoute, private _dataStoreService: DataStoreService, private participationResolverService: ParticipationResolverService) {
  //   this.route.data.subscribe(data => {
  //     if (data && data.hasOwnProperty('result')) {
  //       _authService.setAuthDetail('participation',data.result);
  //     }
  // });
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
  }

  ngOnInit() {
    this.participationResolverService.getParticipation().subscribe({
        next: (data: any) => {
            this._authService.setAuthDetail('participation',data);
        }
    })
    this.moduleview = this._authService.isModuleAccessable('participation', 'participation');
    this.getParticipants();
  }
  getParticipants() {
    this.ServicecaseParticipants$ = this._commonHttpService
        .getArrayList(
            {
                where: { servicecaseid : this.id},
                method: 'get'
            },
            'Intakedastagings/getpriorbyservicecase?filter'
        );
}
toggleClient(modal: any) {
  this.isShow = modal;
}
}
