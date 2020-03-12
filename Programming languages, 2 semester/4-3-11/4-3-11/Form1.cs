using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _4_3_11
{
    public partial class Form1 : Form
    {
        public double x;
        public double SinSqr(double a)
        {
            return (Math.Sin(a)) * (Math.Sin(a));
        }
        public double CosSqr(double a)
        {
            return (Math.Cos(a)) * (Math.Cos(a));
        }
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int i = 0;
            for(double a = -(Math.PI); a <= (Math.PI); a+= (Math.PI) / 4)
            {
                dataGridView1.Rows[0].Cells[i].Value = Convert.ToString(Math.Round(SinSqr(a), 4));
                i++;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            int i = 0;
            for (double a = -(Math.PI); a <= (Math.PI); a += (Math.PI) / 4)
            {
                dataGridView1.Rows[1].Cells[i].Value = Convert.ToString(Math.Round(CosSqr(a), 4));
                i++;
            }
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            dataGridView1.RowCount = 2;
            dataGridView1.ColumnCount = 9;
        }
    }
}
