import { Injectable } from '@angular/core';
import * as FileSaver from 'file-saver';
import ExcelJS from 'exceljs';

const EXCEL_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
const EXCEL_EXTENSION = '.xlsx';

@Injectable({
  providedIn: 'root'
})
export class ExcelService {

  async exportAsExcelFile(json: any[], excelFileName: string): Promise<void> {

    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('data');

    if (json.length > 0) {

      worksheet.columns = Object.keys(json[0]).map(key => ({
        header: key,
        key: key,
        width: 20
      }));

      worksheet.addRows(json);
    }

    const buffer = await workbook.xlsx.writeBuffer();

    const blob = new Blob([buffer],{
        type: EXCEL_TYPE
      });

    FileSaver.saveAs(blob,`${excelFileName}_export_${Date.now()}.${EXCEL_EXTENSION}`);
  }
}