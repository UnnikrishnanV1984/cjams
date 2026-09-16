import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProviderPlacmentDetailsComponent } from './provider-placment-details.component';

describe('ProviderPlacmentDetailsComponent', () => {
  let component: ProviderPlacmentDetailsComponent;
  let fixture: ComponentFixture<ProviderPlacmentDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ProviderPlacmentDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProviderPlacmentDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
