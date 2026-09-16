import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProviderChecklistComponent } from './provider-checklist.component';

describe('ProviderChecklistComponent', () => {
  let component: ProviderChecklistComponent;
  let fixture: ComponentFixture<ProviderChecklistComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ProviderChecklistComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProviderChecklistComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
