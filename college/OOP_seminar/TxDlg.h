#pragma once
#include "afxwin.h"


// CTxDlg dialog

class CTxDlg : public CDialogEx
{
	DECLARE_DYNAMIC(CTxDlg)

public:
	CTxDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CTxDlg();

// Dialog Data
	enum { IDD = IDD_DIALOG_TEXT };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
public:
	CString m_text;
	afx_msg void OnEnChangeEdit1();
	CEdit m_txtEdit;
	virtual void OnOK();
};
