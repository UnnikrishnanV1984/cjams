import {Component, OnInit} from '@angular/core';
import {NytdService} from './../nytd.service';
import {saveAs} from "file-saver";

declare var $: any;
@Component({
    selector: 'app-nytd',
    templateUrl: './nytd.component.html',
    styleUrls: ['./nytd.component.scss'],
    standalone: false
})
export class NytdComponent implements OnInit {

    constructor(public service: NytdService) { }

    validated = false;

    saveSuccessful = false;

    reportSelectorColumns: any = {
        name: (row:any) => row.period
    };

    personSelectorColumns: any = {
        name: (row:any) => row.firstName + ' ' + row.lastName,
        id: (row:any) => row.id
    };

    ngOnInit() {
        this.service.load();

        this.service.didSuccessfullySubmit.subscribe(
            response => {
                this.saveSuccessful = true;
            },
            err => { console.error(err); }
        );
    }

    onClickDownload() {
        this.service.downloadAsXml().subscribe(
            response => {
                saveAs(response, 'nytd-' + this.service.loadedReport?.period + '.xml');
            },
            err => { console.error(err); }
        );
    }

    onClose($event:MouseEvent) {
        this.closeAndResetModal();
    }

    closeAndResetModal() {
        $('#survey-save-modal').modal('hide');

        setTimeout(() => {
            this.saveSuccessful = false;
        }, 1000);
    }

    get saveButtonText() {
        if (this.service.isSubmitting) {
            return 'Saving Survey...';
        }
        return (this.validated) ? 'Save Validated' : 'Save Unvalidated';
    }

    onClickSave($event:MouseEvent) {
        this.service.saveAnswers($event);
    }

    onClickSubmit($event:MouseEvent){
        this.service.onSubmit({ validated: this.validated});
    }
}
