import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProviderChecklistSearchComponent } from './provider-checklist-search.component';

describe('ProviderChecklistSearchComponent', () => {
  let component: ProviderChecklistSearchComponent;
  let fixture: ComponentFixture<ProviderChecklistSearchComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ProviderChecklistSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProviderChecklistSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
