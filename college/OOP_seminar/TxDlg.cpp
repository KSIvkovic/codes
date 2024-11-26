// TxDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Fesb.h"
#include "TxDlg.h"
#include "afxdialogex.h"


// CTxDlg dialog

IMPLEMENT_DYNAMIC(CTxDlg, CDialogEx)

CTxDlg::CTxDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CTxDlg::IDD, pParent)
{

}

CTxDlg::~CTxDlg()
{
}

void CTxDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT1, m_txtEdit);
}


BEGIN_MESSAGE_MAP(CTxDlg, CDialogEx)
	ON_EN_CHANGE(IDC_EDIT1, &CTxDlg::OnEnChangeEdit1)
END_MESSAGE_MAP()


// CTxDlg message handlers


void CTxDlg::OnEnChangeEdit1()
{
	// TODO:  If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialogEx::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.

	// TODO:  Add your control notification handler code here
}


void CTxDlg::OnOK()
{
	m_txtEdit.GetWindowTextA(m_text);
	CDialogEx::OnOK();
}
