import { Component, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Workbook } from 'exceljs';
import { AlertService } from '../../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { ReleaseNoteService } from '../../release-note.service';
import { NgxfUploaderService, NgxfSelectDirective } from 'ngxf-uploader';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CommonControlsModule } from '../../../../shared/modules/common-controls/common-controls.module';

@Component({
    selector: 'upload',
    templateUrl: './upload.component.html',
    standalone: true,
    imports: [
        CommonModule,
        FormsModule,
        ReactiveFormsModule,
        NgxfSelectDirective,
        MatFormFieldModule,
        MatInputModule,
        CommonControlsModule
    ],
    providers: [NgxfUploaderService]
})
export class ReleaseNoteUploadComponent {
    @Output() uploadComplete = new EventEmitter<void>();

    uploadForm: FormGroup;
    readonly modalId = 'release-upload';

    constructor(
        private _fb: FormBuilder,
        private _service: ReleaseNoteService,
        private _alert: AlertService
    ) {
        this.uploadForm = this._fb.group({
            releasedate:    [null, Validators.required],
            releaseversion: [null, Validators.required]
        });
    }

    open() {
        this.uploadForm.reset({ releasedate: null, releaseversion: null });
        (<any>$('#' + this.modalId)).modal('show');
    }

    cancel() {
        this.uploadForm.reset({ releasedate: null, releaseversion: null });
        (<any>$('#' + this.modalId)).modal('hide');
    }

    async onFileSelected(event: any) {
        if (!(event instanceof File)) return;
        try {
            const release = this.uploadForm.value;
            const workbook = new Workbook();
            await workbook.xlsx.load(await event.arrayBuffer());

            const itemlist: any[] = [];

            const storiesSheet = workbook.getWorksheet('Stories');
            if (storiesSheet) {
                for (const vrec of this._sheetToJson(storiesSheet)) {
                    itemlist.push(this._buildItem(release, vrec, 'Story', vrec.Story_Id || ''));
                }
            }

            const defectsSheet = workbook.getWorksheet('Defects');
            if (defectsSheet) {
                for (const drec of this._sheetToJson(defectsSheet)) {
                    itemlist.push(this._buildItem(release, drec, 'Defect', drec.Defect_Id || ''));
                }
            }

            this._service.saveReleaseNotes(itemlist).subscribe(
                (success: any) => {
                    if (success === 'Success') {
                        this._alert.success('Release Notes Uploaded Successfully.');
                    } else {
                        this._alert.error('Error in Uploading Release Notes.');
                    }
                    (<any>$('#' + this.modalId)).modal('hide');
                    setTimeout(() => this.uploadComplete.emit(), 4000);
                },
                () => {
                    this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    (<any>$('#' + this.modalId)).modal('hide');
                }
            );
        } catch {
            this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            (<any>$('#' + this.modalId)).modal('hide');
        }
    }

    private _sheetToJson(worksheet: any): any[] {
        const rows: any[] = [];
        let headers: any[] = [];
        worksheet.eachRow((row: any, rowNumber: number) => {
            const vals = row.values;
            if (rowNumber === 1) {
                headers = vals;
            } else {
                const obj: any = {};
                for (let i = 1; i < headers.length; i++) obj[headers[i]] = vals[i];
                rows.push(obj);
            }
        });
        return rows;
    }

    private _buildItem(release: any, rec: any, itemType: string, itemId: string) {
        return {
            Release_Version_Number: release.releaseversion,
            Item_Type: itemType,
            Item_Id: itemId,
            Title: rec.Title ?? '',
            Description: rec.Description ?? '',
            Release_Date: release.releasedate,
            Support_Id: rec.Support_Id ?? null,
            Application: 'CW',
            Document_Link: rec.Document_Link ?? null,
            Raised_By: itemType === 'Story' ? (rec.Raised_By ?? null) : null
        };
    }
}
