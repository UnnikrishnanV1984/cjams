
import {map, share, pluck} from 'rxjs/operators';
import { ChangeDetectorRef, Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable ,  forkJoin } from 'rxjs';

import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { GenericService, ValidationService } from '../../../../../@core/services';
import { AlertService } from '../../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { AdminUrlConfig } from '../../../admin-url.config';
import { DATypeScreenStatus, ManageAlertsConfig } from '../_entities/da-type-config.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'manage-alerts',
    templateUrl: './manage-alerts.component.html',
    styleUrls: ['./manage-alerts.component.scss'],
    standalone: false
})
export class ManageAlertsComponent implements OnInit {
    @Input()
    id!: string;
    @Input()
    screenStatus!: DATypeScreenStatus;
    alertEventDropdownList$!: Observable<DropdownModel[]>;
    teamTypedropdownList$!: Observable<DropdownModel[]>;
    leftItems: Array<ManageAlertsConfig> = [];
    rightItems: Array<ManageAlertsConfig> = [];
    confimedItems = new Array<string>();
    manageAlert$!: Observable<ManageAlertsConfig[]>;
    manageAlertsForm!: FormGroup;
    private rightSelectedItems: ManageAlertsConfig[] = [];
    private leftSelectedItems: ManageAlertsConfig[] = [];
    configalerturl = 'daconfig/servicerequesttypeconfigalert/';
    noitemselectedmsg = 'No items selected.';
    constructor(
        private formBuilder: FormBuilder,
        private _manageAlertsCommonSerive: CommonHttpService,
        private _manageAlertsService: GenericService<ManageAlertsConfig>,
        private _alertService: AlertService,
        private _changeDetect: ChangeDetectorRef
    ) {
        this._manageAlertsService.endpointUrl =  this.configalerturl;
    }
    ngOnInit() {
        this.formGroupInitilize();
        this.manageAlertsDropdownList();
        if (this.id !== '0') {
            this.loadManageAlert();
        }
    }
    formGroupInitilize() {
        this.manageAlertsForm = this.formBuilder.group({
            alerteventkey: [''],
            alerttimeinterval: [
                '',
                [Validators.required, ValidationService.range(1, 100)]
            ],
            teamtypekey: [''],
            alerttimetype: ['Days', Validators.required]
        });
    }
    private manageAlertsDropdownList() {
        const source = forkJoin([
            this._manageAlertsCommonSerive.getArrayList({}, AdminUrlConfig.EndPoint.DAConfig.GetAlertEventTypeUrl),
            this._manageAlertsCommonSerive.getArrayList({}, AdminUrlConfig.EndPoint.TeamPosition.TeamTypeListUrl)
        ]).pipe(
            map(result => {
                return {
                    alertEventList: result[0].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.alerteventkey
                            })
                    ),
                    teamTypeList: result[1].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.teamtypekey
                            })
                    )
                };
            }),
            share(),);
        this.alertEventDropdownList$ = source.pipe(pluck('alertEventList'));
        this.teamTypedropdownList$ = source.pipe(pluck('teamTypeList'));
    }
    changeItem(event: any) {
        this.confimedItems = [];
        if (event.selected !== undefined) {
            event.selected.map((selectvalue: { value: string; }) =>
                this.confimedItems.push(selectvalue.value)
            );
        }
    }
    teamRoleType(teamtypekey: any) {
        teamtypekey = teamtypekey.value;
        if (teamtypekey) {
            const teamTypeUrl =
                AdminUrlConfig.EndPoint.TeamPosition.PositionTitleUrl + '?filter';
            this._manageAlertsCommonSerive
                .getArrayList({where: {teamtypekey: teamtypekey },
                method: 'get'}, teamTypeUrl)
                .subscribe(result => {
                    this.leftItems = result;
                });
        }
    }
    saveManageAlert(modal: ManageAlertsConfig) {
        this._manageAlertsService.endpointUrl = this.configalerturl;
        modal = Object.assign(new ManageAlertsConfig(), modal);
        modal.servicerequesttypeconfigid = this.id;
        this._manageAlertsService.create(modal).subscribe((response: any) => {
                if (response.servicerequesttypeconfigid) {
                    this.loadManageAlert();
                }
            }, (err: any) => {
                console.error(err);
            }
        );
        this.formGroupInitilize();
        this.leftItems = new Array<ManageAlertsConfig>();
        this.rightItems = new Array<ManageAlertsConfig>();
    }
    selectItem(position: string, selectedItem: ManageAlertsConfig, control: any) {
        if (position === 'left') {
            if (control.target.checked) {
                this.leftSelectedItems.push(selectedItem);
            } else {
                const index = this.leftSelectedItems.indexOf(selectedItem);
                this.leftSelectedItems.splice(index, 1);
            }
        } else {
            if (control.target.checked) {
                this.rightSelectedItems.push(selectedItem);
            } else {
                const index = this.rightSelectedItems.indexOf(selectedItem);
                this.rightSelectedItems.splice(index, 1);
            }
        }
    }
    loadManageAlert() {
        // tslint:disable-next-line:max-line-length
        this.manageAlert$ = this._manageAlertsCommonSerive
            .getArrayList({
                where: {servicerequesttypeconfigid: this.id,
                        activeflag: 1},
                method: 'get'},
                AdminUrlConfig.EndPoint.DAConfig.GetTypeCongigAlertUrl + '?filter'
            ).pipe(
            map(result => {
                const mangealerts = result.map(
                    model => new ManageAlertsConfig(model)
                );
                this.screenStatus.hasManageAlerts = !(
                    mangealerts === null || mangealerts.length === 0
                );
                return mangealerts;
            }));
    }
    deleteItem(data: any) {
        this._manageAlertsCommonSerive.endpointUrl = this.configalerturl;
        this._manageAlertsCommonSerive
            .patch(data.servicerequesttypeconfigalertid, { activeflag: 0 })
            .subscribe(response => {
                if (response) {
                    this.loadManageAlert();
                }
            });
    }
    selectAll() {
        if (this.leftItems.length) {
            this.moveItems(this.leftItems, this.rightItems, Object.assign([], this.leftItems));
            this.clearSelectedItems('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    select() {
        if (this.leftSelectedItems.length) {
            this.moveItems(this.leftItems, this.rightItems, this.leftSelectedItems);
            this.clearSelectedItems('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    unSelect() {
        if (this.rightSelectedItems.length) {
            this.moveItems(this.rightItems, this.leftItems, this.rightSelectedItems);
            this.clearSelectedItems('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    unSelectAll() {
        if (this.rightItems.length) {
            this.moveItems(this.rightItems, this.leftItems, Object.assign([], this.rightItems));
            this.clearSelectedItems('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }

    private moveItems(source: ManageAlertsConfig[], target: ManageAlertsConfig[], selectedItems: ManageAlertsConfig[]) {
        selectedItems.forEach((item: ManageAlertsConfig, i) => {
            const selectedIndex = source.indexOf(item);
            if (selectedIndex !== -1) {
                source.splice(selectedIndex, 1);
                target.push(item);
            }
        });
        this._changeDetect.detectChanges();
    }
    private clearSelectedItems(position: string) {
        if (position === 'left') {
            this.rightSelectedItems = [];
        } else {
            this.leftSelectedItems = [];
        }
    }
}
