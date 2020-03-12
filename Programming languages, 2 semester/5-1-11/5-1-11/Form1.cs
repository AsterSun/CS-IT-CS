using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _5_1_11
{
    public partial class Form1 : Form
    {
        static int IndexOfDyhotomy(ref int[] Array, int Value, int Left, int Right, int iterations)
        {
            iterations++;
            int x = (Left + Right) / 2;
            if (Array[x] == Value)
                return iterations;
            if ((x == Left) || (x == Right))
                return -1;
            if (Array[x] < Value)
                return IndexOfDyhotomy(ref Array, Value, x, Right, iterations);
            else
                return IndexOfDyhotomy(ref Array, Value, Left, x, iterations);
        }

        int IndexOf(ref int[] Array, int Value)
        {
            for (int i = 0; i < Array.Length; i++)
                if (Array[i] == Value)
                    return i;
            return -1;
        }

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


        private void button1_Click(object sender, EventArgs e)
        {
            Random rd = new Random();
            for (Int32 i = 0; i < arr.Length; ++i)
            {
                arr[i] = rd.Next(1, 101);
                dataGridView1.Rows[1].Cells[i].Value = Convert.ToString(arr[i]);
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
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Pyramid_Sort(arr, arr.Length);
            for (Int32 i = 0; i < arr.Length; ++i)
            {
                dataGridView1.Rows[2].Cells[i].Value = Convert.ToString(arr[i]);
            }

        }

        private void button3_Click(object sender, EventArgs e)
        {
            int SearchNumber = Convert.ToInt32(textBox1.Text);
            int[] ArrBefore = new int[100];
            for (int i = 0; i < 100; i++)
                ArrBefore[i] = Convert.ToInt32(dataGridView1.Rows[1].Cells[i].Value);
            textBox2.Text = Convert.ToString(IndexOf(ref ArrBefore, SearchNumber)+1);

            int[] ArrAfter = new int[100];
            for (int i = 0; i < 100; i++)
                ArrAfter[i] = Convert.ToInt32(dataGridView1.Rows[2].Cells[i].Value);
            textBox3.Text = Convert.ToString(IndexOfDyhotomy(ref ArrAfter, SearchNumber, 0, 100, 0));
        }
    }
}
