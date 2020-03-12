using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                double x = Convert.ToDouble(textBox1.Text);
                double y = Convert.ToDouble(textBox2.Text);
                double z = Convert.ToDouble(textBox3.Text);
                textBox4.Text += Environment.NewLine + "Результаты работы программы: " + Environment.NewLine;
                textBox4.Text += "При X = " + textBox1.Text + Environment.NewLine;
                textBox4.Text += "При Y = " + textBox2.Text + Environment.NewLine;
                textBox4.Text += "При Z = " + textBox3.Text;
                double f = Math.Sinh(x);
                if (radioButton2.Checked) f = x * x;
                else if (radioButton3.Checked) f = Math.Exp(x);
                double q = (Math.Max(f + y + z, f * y * z)) / (Math.Min(f + y + z, f * y * z));
                textBox4.Text += Environment.NewLine + "Q = " + q.ToString();
            }
            catch (Exception)
            {
                textBox4.Text += Environment.NewLine + "Ошибка. Проверьте правильность введённых данных.";
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Text = " ";
            textBox2.Text = " ";
            textBox3.Text = " ";
            textBox4.Text = "Лаб. раб. 1-3-14 ст. 131 гр. Зюбин Д.А.";
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            textBox4.Text = "Лаб. раб. 1-3-14 ст. 131 гр. Зюбин Д.А.";
        }
    }
}
