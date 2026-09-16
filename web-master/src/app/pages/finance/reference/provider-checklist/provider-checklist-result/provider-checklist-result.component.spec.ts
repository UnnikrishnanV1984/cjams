import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProviderChecklistResultComponent } from './provider-checklist-result.component';

describe('ProviderChecklistResultComponent', () => {
  let component: ProviderChecklistResultComponent;
  let fixture: ComponentFixture<ProviderChecklistResultComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ProviderChecklistResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProviderChecklistResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
