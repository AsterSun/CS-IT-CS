using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _5_1_11Ext
{
    public partial class Form1 : Form
    {
        Int32[] arr = new Int32[100];
        public Form1()
        {
            InitializeComponent();
        }

        static Int32 add2pyramid(Int32[] arr, Int32 i, Int32 N)
        {
            Int32 imax;
            Int32 buf;
            if ((2 * i + 2) < N)
            {
                if (arr[2 * i + 1] < arr[2 * i + 2]) imax = 2 * i + 2;
                else imax = 2 * i + 1;
            }
            else imax = 2 * i + 1;
            if (imax >= N) return i;
            if (arr[i] < arr[imax])
            {
                buf = arr[i];
                arr[i] = arr[imax];
                arr[imax] = buf;
                if (imax < N / 2) i = imax;
            }
            return i;
        }

        static void Pyramid_Sort(Int32[] arr, Int32 len)
        {
            for (Int32 i = len / 2 - 1; i >= 0; --i)
            {
                long prev_i = i;
                i = add2pyramid(arr, i, len);
                if (prev_i != i) ++i;
            }
            Int32 buf;


            for (Int32 k = len - 1; k > 0; --k)
            {
                buf = arr[0];
                arr[0] = arr[k];
                arr[k] = buf;
                Int32 i = 0, prev_i = -1;
                while (i != prev_i)
                {
                    prev_i = i;
                    i = add2pyramid(arr, i, k);
                }
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            dataGridView1.RowCount = 3;
            dataGridView1.ColumnCount = 100;
            for (Int32 i = 0; i < arr.Length; ++i)
            {
                dataGridView1.Rows[0].Cells[i].Value = "a[" + Convert.ToString(i) + "]";
            }
            Random rd = new Random();
            for (Int32 i = 0; i < arr.Length; ++i)
            {
                arr[i] = rd.Next(1, 101);
                dataGridView1.Rows[1].Cells[i].Value = Convert.ToString(arr[i]);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int h = Convert.ToInt32(textBox2.Text);
            int g = IndexOf(ref X, h);
            if (g == -1) textBox3.Text = "Этого числа нет в массиве" + Environment.NewLine;
            else textBox3.Text = "Число под индексом " + g + Environment.NewLine;
            int k = 0;
            for (int i = 0; i < 100; i++)
                if (X[i] == h) k++;
            textBox3.Text += "Количество интераций " + k;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Pyramid_Sort(arr, arr.Length);
            for (int i = 0; i < 100; i++)
                textBox4.Text += "X[" + Convert.ToString(i) + "] = " + Convert.ToString(X[i]) + Environment.NewLine;
        }

        private void button3_Click(object sender, EventArgs e)
        {

            int h = Convert.ToInt32(textBox5.Text);
            int g = IndexOf(ref X, h, 0, 100);
            if (g == -1) textBox6.Text = "Этого числа нет в массиве" + Environment.NewLine;
            else textBox6.Text = "Число под индексом " + g + Environment.NewLine;
            int k = 0;
            for (int i = 0; i < 100; i++)
                if (X[i] == h) k++;
            textBox6.Text += "Количество интераций " + k;
        }
    }
}
