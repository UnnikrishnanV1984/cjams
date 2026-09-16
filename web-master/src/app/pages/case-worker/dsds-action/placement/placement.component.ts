import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { DsdsService } from '../_services/dsds.service';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement',
    templateUrl: './placement.component.html',
    styleUrls: ['./placement.component.scss'],
    standalone: false
})
export class PlacementComponent implements OnInit, OnDestroy {
    hearingoutcometypekey!: string;
    id!: string;
    enabledTab!: string;
    isChildRemoval = false;
    caseType!: string;
    isServiceCase: any;
    constructor(private _commonHttpService: CommonHttpService,
        private route: ActivatedRoute,
        private _dataStore: DataStoreService,
        private _router: Router,
        private _dataStoreService: DataStoreService,
        private _dsdsService: DsdsService) { }

    ngOnInit() {
        this.id = this._dataStore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.isServiceCase = this._dsdsService.isServiceCase();
        this.caseType = this._dataStore.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        if (this.isServiceCase || this.caseType) {
            this.isChildRemoval = true;
        } else {
            this.getChildRemoval();
        }

        this.getCourtDetails();
        this._dataStore.currentStore.subscribe(storeData => {
            if (storeData.ENFORCE_SUBSCRIPTION && storeData['permanencyPlan'] && storeData['permanencyPlan'].primarypermanency) {
                this.enabledTab = storeData['permanencyPlan'].primarypermanency[0].permanencyplantypekey;
            }
        });
    }
    getChildRemoval() {
       
        this._commonHttpService.getSingle(
            {
                where: { intakeserviceid: this.id, isgroup: 1 },
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                .GetChildRemovalList + '?filter'
        )
            .subscribe(result => {
                if (result && result.length) {
                    this.isChildRemoval = true;
                } else {
                    if (!this.caseType) {
                        const id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
                        const daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
                        this._router.navigate([
                            '/pages/case-worker/' +
                            id +
                            '/' +
                            daNumber +
                            '/dsds-action/assessment'
                        ]);
                    }
                }
            });
    }
    private getCourtDetails() {
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {
                    intakeserviceid: this.id
                }
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl + '?filter'
        ).subscribe((res) => {
            if (res && res.length) {
                this.hearingoutcometypekey = res[0].hearingoutcometypekey;
            }
        });
    }
    ngOnDestroy() {
        this._dataStore.setData('permanencyPlan', {}, true);
        this._dataStore.setData('TPRRecommendationList', null, true);
        this._dataStore.setData('TPRRecommendationId', null, true);
    }
}
