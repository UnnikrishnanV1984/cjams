import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../../../../../@core/services';

import {saveAs} from 'file-saver';
declare let google: any;
@Component({
    selector: 'subsidy-download',
    templateUrl: './subsidy-download.component.html',
    standalone: false
})
export class SubsidyDownloadComponent implements OnInit {

    subsidydownloadList: any = [];
  
  constructor(
    private _commonHttp: CommonHttpService
  ) { }
    
  ngOnInit() {
    this.getsubsidydownloadList();
    }

    
    downloadsubsidyfile (key: any, description: any) {
        this._commonHttp.getArrayList(
          {
            where: { refkey: key },
            method: 'get'
          },
          'adoptionagreement/printAdoptionDocument?filter'
        ).subscribe((result: any) => {             
         var data = this.b64toBlob(result['$data'], 'application/pdf');
          saveAs(data, description +'.pdf');
        });
      }

      b64toBlob(b64Data: any, contentType: any) {
        contentType = contentType || '';
        var sliceSize = 512;
        b64Data = b64Data.replace(/^[^,]+,/, '');
        b64Data = b64Data.replace(/\s/g, '');
        var byteCharacters = window.atob(b64Data);
        var byteArrays = [];
    
        for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
            var slice = byteCharacters.slice(offset, offset + sliceSize);
    
            var byteNumbers = new Array(slice.length);
            for (var i = 0; i < slice.length; i++) {
                byteNumbers[i] = slice.charCodeAt(i);
            }
    
            var byteArray = new Uint8Array(byteNumbers);
    
            byteArrays.push(byteArray);
        }
    
        return new Blob(byteArrays, {type: contentType});
      }
    
      getsubsidydownloadList() {
        this._commonHttp.getArrayList(
          {
            where: { referencetypeid: 572 },
            method: 'get',
            nolimit: true
          },
          'referencetype/gettypes?filter'
        ).subscribe((subsidyList) => {
          this.subsidydownloadList = subsidyList;
        });
    
      }

}
