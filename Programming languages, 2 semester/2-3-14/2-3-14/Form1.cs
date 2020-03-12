using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _2_3_14
{
    public partial class Form1 : Form
    {
        int[] Mas = new int[30];
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Random rand = new Random();
            textBox1.Text = "";
            for (int i = 0; i < 30; i++)
            {
                Mas[i] = rand.Next(-50, 50);
                textBox1.Text += "Mas[" + Convert.ToString(i) + "] = "
                    + Convert.ToString(Mas[i]);
                    if ((i + 1) % 5 == 0)
                {
                    textBox1.Text += Environment.NewLine;
                }
                    else {
                    textBox1.Text += "   ";
                }
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            int sum = 0;
            int state = 0;
            for (int i = 0; i < 30; i++)
            {
                if (i * i >= Mas[i])
                {
                    sum += Mas[i];
                    state = 1;
                }
            }
            if (state != 0)
            {
                label2.Text += sum + " ";
            }
            else
            {
                label2.Text += "Подходящих элементов нет. ";
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            label2.Text = "Получившаяся сумма: ";
        }
    }
}
