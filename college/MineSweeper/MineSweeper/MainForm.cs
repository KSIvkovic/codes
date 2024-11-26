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
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            this.Text = "Minotragač";
            this.BackColor = Color.LightSteelBlue;
        }

        private void newGameToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MineSweeper.NewGame newGame = new MineSweeper.NewGame();
            newGame.setParent(this);
            newGame.ShowDialog();
        }

        void removeBlank(int x, int y)//otvaranje slobodnih polja u okolici klika
        {
            if (btn_grid[x, y].Visible)
            {
                noMineCount++;//broji polja bez mina
                btn_grid[x, y].Visible = false;//uklanja vidljivost botuna
                for (int xx = -1; xx < 2; xx++)
                {
                    for (int yy = -1; yy < 2; yy++)
                    {
                        if (x + xx >= 0 && y + yy >= 0 && x + xx < width && y + yy < height)
                        {
                            if (btn_grid[x + xx, y + yy].Visible)
                            {
                                btn_grid[x, y].Visible = false;
                                if (grid[x, y] == 0)
                                {
                                    removeBlank(x + xx, y + yy);//rekurzivni poziv, kako bi se otvorila sva prazna polja u okolici kliknutog
                                }
                            }
                        }
                    }
                }
                flag++;//uvećava se kako bi pokazao da nije riječ o prvom kliku
            }
        }


        void bttnOnclick(object sender, System.EventArgs e)
        {
            if (flag == 0)
            {
                tmr_ElapsedTime.Start();//pokreni tajmer na prvi klik
            }

            if (!tmr_ElapsedTime.Enabled)
            {
                return;
            }

            Button bttnClick = sender as Button;

            if (bttnClick == null)//ukoliko nije kliknut botun
            {
                return;
            }

            string[] split = bttnClick.Name.Split(new Char[] { ' ' });//razdvaja ime na x i y koordinatu

            int x = System.Convert.ToInt32(split[0]);
            int y = System.Convert.ToInt32(split[1]);

            if (btn_grid[x, y].BackColor == Color.Red)//spriječi klik ukoliko je polje označeno crveno, sadrži minu
            {
                return;
            }

            if (grid[x, y] == -1 && flag == 0)//ako prvo kliknuto polje sadrži minu, potrebno obaviti zamjenu
            {
                int countMines = 0;

                for (int xx = -1; xx < 2; xx++)
                {
                    for (int yy = -1; yy < 2; yy++)
                    {
                        if (x + xx >= 0 && y + yy >= 0 && x + xx < width && y + yy < height)
                        {
                            if (grid[x + xx, y + yy] == -1)
                            {
                                countMines++;//dodaj sve susjede koji sadrže minu, uključujući sebe
                            }
                        }
                    }
                }
                countMines--;// isključi sebe
                switch_first();//poziv funkcije za premještanje mine na prazno polje
                lbl_grid[x, y].Text = countMines.ToString();
                lbl_grid[x, y].Font = new Font("Microsoft Sans Serif", 15.75f, lbl_grid[x, y].Font.Style, lbl_grid[x, y].Font.Unit);
                lbl_grid[x, y].Location = new System.Drawing.Point(lbl_grid[x, y].Location.X + 5, lbl_grid[x, y].Location.Y);
                grid[x, y] = 0;

                for (int xxx = 0; xxx < width; xxx++) //treba ponovno postaviti brojeve susjeda nakon zamjene
                {
                    for (int yyy = 0; yyy < height; yyy++)
                    {
                        if (grid[xxx, yyy] != -1)// ako nije mina, treba ažurirati labelu
                        {
                            countMines = 0;
                            for (int xx = -1; xx < 2; xx++)
                            {
                                for (int yy = -1; yy < 2; yy++)
                                {
                                    if (xxx + xx >= 0 && yyy + yy >= 0 && xxx + xx < width && yyy + yy < height)
                                    {
                                        if (grid[xxx + xx, yyy + yy] == -1)
                                        {
                                            countMines++;// zbrajaj susjedne mine
                                        }
                                    }
                                }
                            }
                            grid[xxx, yyy] = countMines;

                            if (countMines == 0)//ako nema mina
                            {
                                lbl_grid[xxx, yyy].Text = " ";
                            }
                            else//ako okolna polja sadrže mine
                            {
                                lbl_grid[xxx, yyy].Text = countMines.ToString();
                                lbl_grid[xxx, yyy].Font = new Font("Microsoft Sans Serif", 15.75f, lbl_grid[xxx, yyy].Font.Style, lbl_grid[xxx, yyy].Font.Unit);
                                lbl_grid[xxx, yyy].Location = new System.Drawing.Point(lbl_grid[xxx, yyy].Location.X, lbl_grid[xxx, yyy].Location.Y);
                            }
                        }
                    }
                }
            }

            if (grid[x, y] == -1)//ukoliko je kliknuto polje s minom (game over)
            {
                tmr_ElapsedTime.Enabled = false;

                for (int xx = 0; xx < width; xx++)//otvori sva polja koja sadrže mine
                {
                    for (int yy = 0; yy < height; yy++)
                    {
                        if (grid[xx, yy] == -1)
                        {
                            btn_grid[xx, yy].Visible = false;
                        }
                    }
                }
                msg = "Boom! Ni najbolji kirurzi vas neće moći opet sastaviti. XD";
                WLForm l = new WLForm(msg, timer);
                l.setParent(this);
                l.ShowDialog();
                return;
            }
            removeBlank(x, y);
            if (this.buttonCount - this.noMineCount == mineNr)//ukoliko su otvorena sva prazna polja (pobjeda)
            {
                tmr_ElapsedTime.Enabled = false;

                for (int xx = 0; xx < width; xx++)//otvori sva polja koja sadrže mine
                {
                    for (int yy = 0; yy < height; yy++)
                    {
                        if (grid[xx, yy] == -1)
                        {
                            btn_grid[xx, yy].Visible = false;
                        }
                    }
                }
                msg = "Čestitke! Zaslužili ste keks i krug oko zgrade! :D";
                WLForm w = new WLForm(msg, timer);
                w.setParent(this);
                w.ShowDialog();
                return;
            }
            bttnClick.Visible = false;
        }

        void bttnOnRightClick(object sender, MouseEventArgs e)//desni klik, označi da polje sadrži minu
        {
            if (e.Button == MouseButtons.Right)
            {
                Control control = (Control)sender;
                if (control.BackColor != Color.Red)//zacrveni polje
                {
                    control.BackColor = Color.Red;
                    this.mintCount--;//umanji brojač mina
                    lbl_mines.Text = mintCount.ToString();
                }
                else if (control.BackColor == Color.Red)//ako je već crveno, novi klik vraća polje u izvorno, neoznačeno stanje
                {
                    control.BackColor = Color.Empty;
                    this.mintCount++;
                    lbl_mines.Text = mintCount.ToString();
                }
            }
        }

        private Button createButton(int x, int y, int gridX, int gridY)//stvara botune
        {
            Button bttn = new Button();

            bttn.Text = "";
            bttn.Name = gridX.ToString() + " " + gridY.ToString();
            bttn.Size = new System.Drawing.Size(24, 24);
            bttn.Location = new System.Drawing.Point(x, y);
            Controls.AddRange(new System.Windows.Forms.Control[] { bttn, });
            bttn.Click += new System.EventHandler(bttnOnclick);
            bttn.MouseDown += new System.Windows.Forms.MouseEventHandler(this.bttnOnRightClick);

            return bttn;
        }

        private Label createLables(int x, int y)//stvara labele
        {
            Label lbl = new Label();
            lbl.Name = x.ToString() + " " + y.ToString();
            lbl.Text = "0";
            lbl.Size = new System.Drawing.Size(24, 24);
            lbl.Font = new Font("Microsoft Sans Serif", 15.75f, lbl.Font.Style, lbl.Font.Unit);
            lbl.Location = new System.Drawing.Point(x, y);
            Controls.AddRange(new System.Windows.Forms.Control[] { lbl, });
            return lbl;
        }

        private int[,] grid;
        private Button[,] btn_grid;
        private Label[,] lbl_grid;
        private int timer = 0;

        public int mintCount, noMineCount, buttonCount, mineNr, width, height, diff, flag, startX = 15, startY = 68;
        //mintcount je brojač mina, noMineCount je brojač polja bez mina, mineNr pamti ukupan broj mina radi provjere pobjede
        //buttonCount broji koliko botuna tvori mrežu, diff pamti broj za težinu igre, flag se inkrementira da bi se razlikovao prvi klik od ostalih
        public string msg;
        private bool createGrid()//iscrtava polje
        {
            this.Width = startX * 2 + (width + 1) * 24 - 5;
            this.Height = startY * 2 + (height) * 24;

            grid = new int[width, height];
            btn_grid = new Button[width, height];
            lbl_grid = new Label[width, height];

            Random rnd1 = new Random();

            //dodaj botune i labele
            for (int x = 0; x < width; x++)
            {
                for (int y = 0; y < height; y++)
                {
                    grid[x, y] = 0;

                    btn_grid[x, y] = createButton(startX + 24 * (x + 0), startY + 24 * (y + 0), x, y);
                    lbl_grid[x, y] = createLables(startX + 24 * (x + 0), startY + 24 * (y + 0));
                }
            }

            int currMineCount = mintCount;
            //dodaj mine
            while (currMineCount > 0)
            {
                int mineX = rnd1.Next(width);
                int mineY = rnd1.Next(height);

                if (grid[mineX, mineY] == 0)
                {
                    lbl_grid[mineX, mineY].Text = "*";
                    lbl_grid[mineX, mineY].Font = new Font("Microsoft Sans Serif", 30.75f, lbl_grid[mineX, mineY].Font.Style, lbl_grid[mineX, mineY].Font.Unit);
                    lbl_grid[mineX, mineY].Location = new System.Drawing.Point(lbl_grid[mineX, mineY].Location.X - 5, lbl_grid[mineX, mineY].Location.Y);
                    grid[mineX, mineY] = -1; //dodaj minu
                    currMineCount--;
                }
            }

            //izračunaj brojeve
            for (int x = 0; x < width; x++)
            {
                for (int y = 0; y < height; y++)
                {
                    if (grid[x, y] != -1)
                    {
                        int numMines = 0;
                        for (int xx = -1; xx < 2; xx++)
                        {
                            for (int yy = -1; yy < 2; yy++)
                            {
                                if (x + xx >= 0 && y + yy >= 0 && x + xx < width && y + yy < height)
                                {
                                    if (grid[x + xx, y + yy] == -1)
                                    {
                                        numMines++;//zbroji mine u okolici polja
                                    }
                                }
                            }
                        }
                        grid[x, y] = numMines;

                        if (numMines == 0)//ako u okolici polja nema mina
                        {
                            lbl_grid[x, y].Text = " ";
                        }
                        else//ako u oklici polja postoje mine
                        {
                            lbl_grid[x, y].Text = numMines.ToString();
                        }
                    }
                }
            }
            return true;
        }


        private void clearPreviousGame()//očisti prethodnu igru
        {
            if (btn_grid != null)
            {
                for (int x = 0; x < width; x++)
                {
                    for (int y = 0; y < height; y++)
                    {
                        if (Controls.Contains(btn_grid[x, y]))
                        {
                            Controls.Remove(btn_grid[x, y]);
                        }

                        if (Controls.Contains(lbl_grid[x, y]))
                        {
                            Controls.Remove(lbl_grid[x, y]);
                        }
                    }
                }
            }
        }


        public void startGame(int difficulty)
        {
            clearPreviousGame();
            lbl_ElapsedTime.Text = "0";
            timer = 0;
            bool error = false;
            diff = difficulty;
            buttonCount = noMineCount = mineNr = 0;
            flag = 0;

            switch (difficulty)//postavlja dimenzije ovisno o odabranoj težini
            {
                case 1:
                    mintCount = 10;
                    width = 9;
                    height = 9;

                    break;
                case 2:
                    mintCount = 40;
                    width = 16;
                    height = 16;
                    break;
                case 3:
                    mintCount = 99;
                    width = 30;
                    height = 16;
                    break;
                default:
                    error = true;
                    break;
            }

            lbl_mines.Text = mintCount.ToString();
            mineNr = mintCount;
            buttonCount = width * height;

            if (!error)
            {
                createGrid();
            }
            else
            {
                MessageBox.Show("Greška! Igra još nije učitana!");
                return;
            }
        }

        private void tmr_ElapsedTime_Tick(object sender, EventArgs e)
        {
            timer++;
            lbl_ElapsedTime.Text = timer.ToString();
        }

        private void resetToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.startGame(this.diff);
        }

        private void switch_first()//zamjena ukoliko prvo kliknuto polje sadrži minu
        {
            int x, y;
            for (x = 0; x < width; x++)
            {
                for (y = 0; y < height; y++)
                {
                    if (lbl_grid[x, y].Text != "*" && flag == 0)//ukoliko je prvi klik i polje ne sadrži minu
                    {
                        lbl_grid[x, y].Text = "*";
                        lbl_grid[x, y].Font = new Font("Microsoft Sans Serif", 30.75f, lbl_grid[x, y].Font.Style, lbl_grid[x, y].Font.Unit);
                        lbl_grid[x, y].Location = new System.Drawing.Point(lbl_grid[x, y].Location.X - 5, lbl_grid[x, y].Location.Y);
                        grid[x, y] = -1;
                        flag++;
                        return;
                    }
                }
            } 
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)//izlaz iz aplikacije
        {
            Application.Exit();
        }

        private void oAplikacijiToolStripMenuItem_Click(object sender, EventArgs e)//info
        {
            MessageBox.Show("Minotragač\nAplikacija za kolegij PZW\n\u00A9 2014 Krešimir Srećko Ivković\nFESB Split");
        }
    }
}