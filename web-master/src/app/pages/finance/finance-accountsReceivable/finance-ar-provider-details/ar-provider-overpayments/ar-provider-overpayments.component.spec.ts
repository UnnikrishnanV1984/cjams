import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ArProviderOverpaymentsComponent } from './ar-provider-overpayments.component';

describe('ArProviderOverpaymentsComponent', () => {
  let component: ArProviderOverpaymentsComponent;
  let fixture: ComponentFixture<ArProviderOverpaymentsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ArProviderOverpaymentsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ArProviderOverpaymentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
