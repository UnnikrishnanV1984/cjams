import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CaseWorkerDocumentCreatorComponent } from './case-worker-document-creator.component';

describe('CaseWorkerDocumentCreatorComponent', () => {
  let component: CaseWorkerDocumentCreatorComponent;
  let fixture: ComponentFixture<CaseWorkerDocumentCreatorComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CaseWorkerDocumentCreatorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CaseWorkerDocumentCreatorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
