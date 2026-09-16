import { FormArray, FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { CheckboxModel } from '../entities/common.entities';
declare let $: any;
export class ControlUtils {
    public static buildCheckBoxGroup(formBuilder: FormBuilder, checkboxItems: CheckboxModel[], selectedIds: string[]): FormArray {
        checkboxItems = checkboxItems.map((item) => {
            if (selectedIds.length) {
                selectedIds.forEach((id) => {
                    if (item.value === id) {
                        item.isSelected = true;
                    }
                });
            }
            return item;
        });
        const selectedCheckBoxes = checkboxItems.map((item) => {
            return formBuilder.control(item.isSelected);
        });
        return formBuilder.array(selectedCheckBoxes);
    }
    public static validateAllFormFields(formGroup: FormGroup) {
        Object.keys(formGroup.controls).forEach((field) => {
            const control = formGroup.get(field);
            if (control instanceof FormControl) {
                control.markAsTouched({ onlySelf: true });
            } else if (control instanceof FormGroup) {
                this.validateAllFormFields(control);
            }
        });
    }
    public static setFocusOnInvalidFields() {
        const invalidItem = $('.ng-invalid');
        if (invalidItem.length) {
            $('input.ng-invalid')
                .first()
                .focus();
        }
    }
    public static setFocus(controlId: any) {
        const control = $('#' + controlId);
        if (control.length) {
            control.first().focus();
        }
    }

    public static disableElements(el: any, exclusionList: string[] = []) {
        for (let row of el) {
            if (exclusionList.length) {
                if (exclusionList.indexOf(row.id) > -1) {
                    continue;
                }
            }
            if (row.nodeName !== 'A') {
                row.disabled = true;
                this.disableElements(row.children, exclusionList);
            }
        }
    }

    public static enableElements(el: any) {
        for (let row of el) {
            row.disabled = false;
            this.enableElements(row.children);
        }
    }

    public static markFormGroupTouched(formGroup: FormGroup) {
        (<any>Object).values(formGroup.controls).forEach((control: any) => {
            control.markAsTouched();

            if (control.controls) {
                control.controls.forEach((c: any) => this.markFormGroupTouched(c));
            }
        });
    }
}
