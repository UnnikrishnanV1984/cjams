import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PrimaryPhoneNumberDialogComponent } from './primary-phone-number-dialog.component';

describe('PrimaryPhoneNumberDialogComponent', () => {
  let component: PrimaryPhoneNumberDialogComponent;
  let fixture: ComponentFixture<PrimaryPhoneNumberDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PrimaryPhoneNumberDialogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PrimaryPhoneNumberDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});