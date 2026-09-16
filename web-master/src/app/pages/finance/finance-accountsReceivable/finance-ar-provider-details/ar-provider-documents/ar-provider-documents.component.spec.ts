import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ArProviderDocumentsComponent } from './ar-provider-documents.component';

describe('ArProviderComponent', () => {
  let component: ArProviderDocumentsComponent;
  let fixture: ComponentFixture<ArProviderDocumentsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ArProviderDocumentsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ArProviderDocumentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
