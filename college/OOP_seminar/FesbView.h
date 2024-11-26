
// FesbView.h : interface of the CFesbView class
//

#pragma once


class CFesbView : public CView
{
protected: // create from serialization only
	CFesbView();
	DECLARE_DYNCREATE(CFesbView)

// Attributes
public:
	CFesbDoc* GetDocument() const;

// Operations
public:

// Overrides
public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);

// Implementation
public:
	virtual ~CFesbView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	afx_msg void OnFilePrintPreview();
	afx_msg void OnRButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	DECLARE_MESSAGE_MAP()

//dodano
	COLORREF m_txtColor;
	COLORREF m_penColor;
public:
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnEditNovitekst();
	afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnEditItalic();
	afx_msg void OnEditBold();
	afx_msg void OnEditUnderline();
};

#ifndef _DEBUG  // debug version in FesbView.cpp
inline CFesbDoc* CFesbView::GetDocument() const
   { return reinterpret_cast<CFesbDoc*>(m_pDocument); }
#endif

