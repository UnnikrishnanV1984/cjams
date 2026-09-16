import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ArProviderHistoryComponent } from './ar-provider-history.component';

describe('ArProviderHistoryComponent', () => {
  let component: ArProviderHistoryComponent;
  let fixture: ComponentFixture<ArProviderHistoryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ArProviderHistoryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ArProviderHistoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
