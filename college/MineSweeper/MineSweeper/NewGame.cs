using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace MineSweeper
{
    public partial class NewGame : Form
    {
        public NewGame()
        {
            InitializeComponent();
            this.Text = "Nova Igra";
        }

        MineSweeper.MainForm m_parent;

        public void setParent(MineSweeper.MainForm parent)
        {
            m_parent = parent;
        }

        private void bttn_start_Click(object sender, EventArgs e)//započinje novu igru na odabranoj težini
        {
            int diff = 0;
            if (rb_hard.Checked)
            {
                diff = 3;
            }
            else if (rb_medium.Checked)
            {
                diff = 2;
            }
            else
            {
                diff = 1;
            }

            m_parent.startGame(diff);

            Close();
        }

        private void btn_cancel_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
