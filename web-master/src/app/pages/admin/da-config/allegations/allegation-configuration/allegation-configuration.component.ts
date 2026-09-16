import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

import { AlertService, CommonHttpService } from '../../../../../@core/services';
import { AdminUrlConfig } from '../../../admin-url.config';
import { AllegationConfiguration } from '../../_entities/daconfig.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'allegation-configuration',
    templateUrl: './allegation-configuration.component.html',
    standalone: false
})
export class AllegationConfigurationComponent implements OnInit {
    selectedConfiguration: string[] = [];
    selectedItems: string[] = [];
    formGroup!: FormGroup;
    leftItems: AllegationConfiguration[] = [];
    rightItems: AllegationConfiguration[] = [];

    private rightSelectedItems: AllegationConfiguration[] = [];
    private leftSelectedItems: AllegationConfiguration[] = [];
    noitemselectedmsg = 'No items selected.';
    constructor(private formBuilder: FormBuilder, private _allegationConfigSrvice: CommonHttpService, private _alertService: AlertService, private _changeDetect: ChangeDetectorRef) {}
    ngOnInit() {
        this.getAvailableConfiguration();
        this.getSelectedConfiguration();
    }

    getAvailableConfiguration() {
        this._allegationConfigSrvice
            .getArrayList(
                {
                    nolimit: true,
                    where: { activeFlag: 1 },
                    method: 'get'
                },
                AdminUrlConfig.EndPoint.DAConfig.AllegationConfigListUrl + '?filter'
            )
            .subscribe((result) => {
                this.leftItems = result;
                this.getSelectedConfiguration();
            });
    }

    getSelectedConfiguration() {
        this._allegationConfigSrvice
            .getArrayList(
                {
                    where: { name: 'Inv_AllegationNewAssessmentsConfigs' },
                    method: 'get'
                },
                AdminUrlConfig.EndPoint.DAConfig.ConfigurationSettingsUrl + '?filter'
            )
            .subscribe((result) => {
                if (result && result[0] && result[0].value) {
                    this.selectedConfiguration = result[0].value.split(',');
                    this.preSelect();
                }
            });
    }

    private preSelect() {
        if (this.selectedConfiguration) {
            this.rightItems = this.rightItems.map((item) => {
                this.selectedConfiguration.forEach((id) => {
                    if (item.assessmenttemplateid === id) {
                        item.isSelected = true;
                    }
                });
                return item;
            });
        }
    }
    saveItem() {
        this._allegationConfigSrvice.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AllegationConfigurationUrl;
        const selectedItems = this.rightItems.filter((item) => item.isSelected).map((item) => {
            return item.assessmenttemplateid;
        });
        this._allegationConfigSrvice
            .create({
                name: 'Inv_AllegationNewAssessmentsConfigs',
                category: 'Investigation',
                assesssmenttemplateid: [selectedItems]
            })
            .subscribe((response) => {
                this._alertService.success('Allegation configured successfully');
                this.getAvailableConfiguration();
                this.rightItems = [];
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
    selectItem(position: string, selectedItem: AllegationConfiguration, control: any) {
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
    private moveItems(source: AllegationConfiguration[], target: AllegationConfiguration[], selectedItems: AllegationConfiguration[]) {
        selectedItems.forEach((item: AllegationConfiguration, i) => {
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
            this.leftSelectedItems = [];
        } else {
            this.rightSelectedItems = [];
        }
    }
}
