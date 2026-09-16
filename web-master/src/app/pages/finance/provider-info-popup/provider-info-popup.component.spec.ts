import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProviderInfoPopupComponent } from './provider-info-popup.component';

describe('ProviderInfoPopupComponent', () => {
  let component: ProviderInfoPopupComponent;
  let fixture: ComponentFixture<ProviderInfoPopupComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ProviderInfoPopupComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProviderInfoPopupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
