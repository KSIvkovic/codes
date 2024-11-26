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
    public partial class WLForm : Form
    {
        public WLForm(string m, int t)//prikazuje rezultat igre
        {
            InitializeComponent();
            this.Text = "Rezultat";
            label1.Text = m;
            label2.Text = "Vaše vrijeme: " + t.ToString() + "s";
        }

        MineSweeper.MainForm m_parent;

        public void setParent(MineSweeper.MainForm parent)
        {
            m_parent = parent;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            m_parent.startGame(m_parent.diff);
            Close();
        }
    }
}
