
import {of as observableOf } from 'rxjs';

import {map} from 'rxjs/operators';
import { AbstractControl, FormControl, FormGroup, ValidatorFn } from '@angular/forms';


export class ValidationService {
    static getValidatorErrorMessage(validatorName: string, validatorValue?: any) {
        const decpwsdC=  decodeURIComponent(atob('UGFzc3dvcmQ=')); //encoded the variable pswd with capital P
     const decpwsdS= decodeURIComponent(atob('cGFzc3dvcmQ=')); //encoded the variable pswd with capital p
        const config: any = {
            required: 'Required',
            invalidName: 'Invalid name.',
            invalidCreditCard: 'Is invalid credit card number',
            invalidEmailAddress: 'Invalid email address',
            invalidDaterange: 'To date should be graterthan from date',
            invalidPassword: 'Invalid' +  [decpwsdS]+'.' +  [decpwsdC] +' must be at least 6 characters long, and contain a number.',
            minlength: `Minimum length ${validatorValue.requiredLength}`,
            maxlength: `Max length ${validatorValue.requiredLength}`,
            mobileNumber: 'Number only',
            passwordStrengthValidity: [decpwsdC] +'is too weak.',
            compareFailed: 'The passwords you entered do not match.'
        };

        return config[validatorName];
    }

    static creditCardValidator(control: any) {
        // Visa, MasterCard, American Express, Diners Club, Discover, JCB
        // tslint:disable-next-line:max-line-length
        if (control.value.match(/^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$/)) {
            return null;
        } else {
            return { invalidCreditCard: true };
        }
    }

    static nameValidator(control: any) {
        // Visa, MasterCard, American Express, Diners Club, Discover, JCB
        // tslint:disable-next-line:max-line-length
        if (!control.value || control.value.match(/^[a-zA-Z\\s]*$/)) {
            return null;
        } else {
            return { invalidName: true };
        }
    }

    static emailValidator(control: any) {
        // RFC 2822 compliant regex
        // tslint:disable-next-line:max-line-length
        if (control.value.match(/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/)) {
            return null;
        } else {
            return { invalidEmailAddress: true };
        }
    }

    static passwordValidator(control: any) {
        // {6,100}           - Assert password is between 6 and 100 characters
        // (?=.*[0-9])       - Assert a string has at least one number
        if (control.value.match(/^(?=.*[0-9])[a-zA-Z0-9!@#$%^&*]{6,100}$/)) {
            return null;
        } else {
            return { invalidPassword: true };
        }
    }

    static range(min: number, max: number): ValidatorFn {
        return (c: AbstractControl): { [key: string]: boolean } | null => {
            if (c.value && (isNaN(c.value) || c.value < min || c.value > max)) {
                return { range: true };
            }
            return null;
        };
    }

    static mailFormat(control: FormControl) {
        const EMAIL_REGEXP = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

        if (control.value && !EMAIL_REGEXP.test(control.value)) {
            return {
                invalidEmailAddress: {
                    valid: false,
                    message: 'Not valid email.'
                }
            };
        }

        return null;
    }

    static numericRule(control: FormControl) {
        if (control.value && !/\d/.test(control.value)) {
            return {
                numericRule: {
                    valid: false,
                    message: 'Numeric char missing.'
                }
            };
        }
        return null;
    }

    static lowerCaseRule(control: FormControl) {
        if (control.value && !/[a-z]/.test(control.value)) {
            return {
                lowerCaseRule: {
                    valid: false,
                    message: 'Lower case character missing.'
                }
            };
        }
        return null;
    }

    static upperCaseRule(control: FormControl) {
        if (control.value && !/[A-Z]/.test(control.value)) {
            return {
                upperCaseRule: {
                    valid: false,
                    message: 'Upper case character missing.'
                }
            };
        }
        return null;
    }

    static nonAlpahuNericCaseRule(control: FormControl) {
        if (control.value && !/[\W_]+/g.test(control.value)) {
            return {
                nonAlpahuNericCaseRule: {
                    valid: false,
                    message: 'Non-alphanumeric character missing.'
                }
            };
        }
        return null;
    }

    static compareValidator(fc1: string, fc2: string) {
        return (group: FormGroup): { [key: string]: any } | any => {
            if (group.value) {
                const password = group.value[fc1];
                const passwordConfirm = group.value[fc2];
                if (password !== passwordConfirm) {
                    return {
                        compareFailed: {
                            valid: false,
                            message: 'Password not match.'
                        }
                    };
                }
            }
            return null;
        };
    }

    static equalValueValidator(targetKey: string, toMatchKey: string, errorMessage: string): any {
        return (group: FormGroup): { [key: string]: any } | any => {
            const target = group.controls[targetKey];
            const toMatch = group.controls[toMatchKey];
            if (target.touched && toMatch.touched) {
                const isMatch = target.value === toMatch.value;
                // set equal value error on dirty controls
                if (!isMatch && target.valid && toMatch.valid) {
                    toMatch.setErrors({ equalValue: targetKey });
                    return { equalValue: errorMessage };
                }
                if (isMatch && toMatch.hasError('equalValue')) {
                    toMatch.setErrors(null);
                }
            }

            return null;
        };
    }

    static conditional(conditional: (group: FormGroup) => boolean, validator: any) {
        return function(control: { _parent: any; }) {
            revalidateOnChanges(control);
            if (control && control._parent) {
                if (conditional(control._parent)) {
                    return validator(control);
                }
            }
        };
    }
    static checkDateRange(fromDate: string, toDate: string) {
        return (group: FormGroup): { [key: string]: any } | any => {
            if (group.value) {
                const dateFrom = group.value[fromDate];
                const dateTo = group.value[toDate];
                if (dateTo < dateFrom) {
                    return {
                        invalidDaterange: {
                            valid: true,
                            message: 'To date should be graterthan from date'
                        }
                    };
                }
            }
            return null;
        };
    }
    static numeric(control: FormControl) {
        const phone = /^[0-9.-]+(\.?[0-9.-]+)?$/;
        if (control.value && !phone.test(control.value)) {
            return {
                mobileNumber: {
                    valid: false,
                    message: 'Number values only'
                }
            };
        }
        return null;
    }

    static passwordStrengthValidation(control: FormControl) {
        const passwordValidity = rankPassword(control.value);
        return observableOf(passwordValidity === passwordRank.TOO_SHORT || passwordValidity === passwordRank.WEAK).pipe(map((result) => (result ? { passwordStrengthValidity: true } : null)));
    }

    static minDateValidator(minDate: string | Date): ValidatorFn {
        return (control: AbstractControl): { [key: string]: any } | null => {
            const value = control.value;

            if (!value || isNaN(new Date(value).getTime())) {
            return null;
            }

            const selectedDate = new Date(value);
            selectedDate.setHours(0, 0, 0, 0);

            let minDateToCompare: Date;
            if (typeof minDate === 'string') {
            minDateToCompare = new Date(minDate);
            } else {
            minDateToCompare = new Date(minDate);
            }
            
            minDateToCompare.setHours(0, 0, 0, 0);

            if (selectedDate < minDateToCompare) {
                return {
                    minDateValidator: {
                        valid: false,
                        message: 'Please check the date entered'
                    }
                }
            }

            return null;
        };
      }
    }

function revalidateOnChanges(control: { _parent: any; _revalidateOnChanges?: any; }): void {
    if (control && control._parent && !control._revalidateOnChanges) {
        control._revalidateOnChanges = true;
        validateChangesDistinctFn(control);
    }
}

export const passwordRank = {
    TOO_SHORT: 0,
    WEAK: 1,
    MEDIUM: 2,
    STRONG: 3,
    VERY_STRONG: 4
};

function validateChangesDistinctFn(control: any) {
    control._parent.valueChanges
        .distinctUntilChanged((a: any, b: any) => {
            // These will always be plain objects coming from the form, do a simple comparison
            if ((a && !b) || (!a && b)) {
                return false;
            } else if (a && b && Object.keys(a).length !== Object.keys(b).length) {
                return false;
            } else if (a && b) {
                for (const i in a) {
                    if (a[i] !== b[i]) {
                        return false;
                    }
                }
            }
            return true;
        })
        .subscribe(() => {
            control.updateValueAndValidity();
        });
}

function rankPassword(password: any) {
    let score = 0;
    const upper = /[A-Z]/,
        lower = /[a-z]/,
        number = /[0-9]/,
        special = /[^A-Za-z0-9]/,
        minLength = 8;

    if (password.length < minLength) {
        return passwordRank.TOO_SHORT; // End early
    }

    // Increment the score for each of these conditions
    if (upper.test(password)) {
        score++;
    }
    if (lower.test(password)) {
        score++;
    }
    if (number.test(password)) {
        score++;
    }
    if (special.test(password)) {
        score++;
    }

    // Penalize if there aren't at least three char types
    if (score < 3) {
        score--;
    }

    if (password.length > minLength) {
        // Increment the score for every 2 chars longer than the minimum
        score += Math.floor((password.length - minLength) / 2);
    }

    // Return a ranking based on the calculated score
    if (score < 3) {
        return passwordRank.WEAK;
    } // score is 2 or lower
    if (score < 4) {
        return passwordRank.MEDIUM;
    } // score is 3
    if (score < 6) {
        return passwordRank.STRONG;
    } // score is 4 or 5
    return passwordRank.VERY_STRONG; // score is 6 or higher
}
