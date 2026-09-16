import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

import { GenericService } from '../../@core/services';
import { AdminUrlConfig } from '../admin/admin-url.config';
import { ResourcePermission, SaveResource } from '../admin/user-security-profile/_entites/user-security-profile.data.modal';
import { NewUrlConfig } from '../newintake/newintake-url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'resource',
    templateUrl: './resource.component.html',
    styleUrls: ['./resource.component.scss'],
    standalone: false
})
export class ResourceComponent implements OnInit {
    controlPermission!: ResourcePermission[];
    narrativeTooltipForm!: FormGroup;
    constructor(private formBuilder: FormBuilder, private _resourceService: GenericService<ResourcePermission>, private _saveResource: GenericService<SaveResource>) {}

    ngOnInit() {
        this.narrativeTooltipForm = this.formBuilder.group({
            tooltip: ['']
        });
        this.narrativeTooltip();
        this.resourceList();
    }
    // 'b786ed04-3e5d-42f9-b1b4-82d1bcfaba94' '5ef6bc22-5618-4ea1-b401-a7a80368cc78',
    saveTooltip() {
        this._saveResource
            .patch(
                '5ef6bc22-5618-4ea1-b401-a7a80368cc78',
                {
                    tooltip: this.narrativeTooltipForm.value.tooltip
                },
                AdminUrlConfig.EndPoint.UserProfile.UpdateNarrativeTooltipUrl
            )
            .subscribe(
                (result: any) => {
                    this.narrativeTooltip();
                },
                (err: any) => {
                    // No content to add or call
                }
            );
    }
    private narrativeTooltip() {
        this._resourceService
            .getArrayList(
                {
                    method: 'get',
                    where: {
                        resourcetype: [3],
                        // parentid: '5c70b495-4a13-4b70-83fa-ab0e2b341cb8'
                        parentid: 'f9c6ea93-5699-4df2-b7a9-92c32b9b325c'
                    }
                },
                NewUrlConfig.EndPoint.Intake.ResourceTooltipUrl + '?filter'
            )
            .subscribe((result) => {
                if (result) {
                    result.forEach((item) => {
                        if (item.name === 'Narrative') {
                            this.narrativeTooltipForm.patchValue({ tooltip: item.tooltip });
                        }
                    });
                }
            });
    }
    private resourceList() {
        this._resourceService
            .getArrayList(
                {
                    method: 'get',
                    where: {
                        resourcetype: [3],
                        // parentid: '5c70b495-4a13-4b70-83fa-ab0e2b341cb8'
                        parentid: 'f9c6ea93-5699-4df2-b7a9-92c32b9b325c'
                    }
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceListUrl + '?filter'
            )
            .subscribe((result) => {
                this.controlPermission = result;
            });
    }
}
