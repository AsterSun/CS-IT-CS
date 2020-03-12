using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _3_1_14
{
    public partial class Form1 : Form
    {
        int[,] arr;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            arr = new int[16, 16];
            dataGridView1.RowCount = 16;
            dataGridView1.ColumnCount = 16;
            dataGridView2.RowCount = 16;
            dataGridView2.ColumnCount = 16;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Random rand = new Random();
            int i, j;
                for (i = 0; i < 16; i++)
                    for (j = 0; j < 16; j++)
                        arr[i, j] = rand.Next(-100, 100);
                for (i = 0; i < 16; i++)
                    for (j = 0; j < 16; j++)
                        dataGridView1.Rows[i].Cells[j].Value = Convert.ToString(arr[i, j]);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int [] arrmax = new int[16];
            for (int i = 0; i < 16; i++)
            {
                arrmax[i] = -101;
                for (int j = 0; j < 16; j++)
                {
                    if (arr[i, j] > arrmax[i])
                        arrmax[i] = arr[i, j];
                }
            }
            for (int i = 0; i < 16; i++)
                for (int j = 0; j < 16; j++)
                {
                    if (i==j) dataGridView2.Rows[i].Cells[j].Value = Convert.ToString(arrmax[i]);
                    else dataGridView2.Rows[i].Cells[j].Value = Convert.ToString(arr[i, j]);
                }


        }
    }
}
