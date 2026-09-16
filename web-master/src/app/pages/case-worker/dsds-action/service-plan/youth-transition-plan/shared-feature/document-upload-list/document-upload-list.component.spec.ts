import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DocumentUploadListComponent } from './document-upload-list.component';

describe('DocumentUploadListComponent', () => {
  let component: DocumentUploadListComponent;
  let fixture: ComponentFixture<DocumentUploadListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DocumentUploadListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DocumentUploadListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
