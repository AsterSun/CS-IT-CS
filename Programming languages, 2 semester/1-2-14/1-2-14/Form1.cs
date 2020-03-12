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
                string xs = textBox1.Text;
                double x = double.Parse(xs);
                string ys = textBox2.Text;
                double y = double.Parse(ys);
                string zs = textBox3.Text;
                double z = double.Parse(zs);
                textBox4.Text += Environment.NewLine +
                    "X = " + x.ToString();
                textBox4.Text += Environment.NewLine +
                    "Y = " + y.ToString();
                textBox4.Text += Environment.NewLine +
                    "Z = " + z.ToString();
                double g = (Math.Pow(y, x + 1) / ((Math.Pow(Math.Abs(y - 2), 1 / 3.0)) + 3)) + (((x + (y / 2)) / (2 * Math.Abs(x + y))) * Math.Pow(x + 1, -1 / Math.Sin(z)));
                textBox4.Text += Environment.NewLine + "Результат g = " + g.ToString();
            }
            catch (Exception)
            {
                textBox4.Text += Environment.NewLine + "Ошибка - вы ввели неверные данные." + Environment.NewLine + "Проверьте правильность введённых данных.";
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            textBox1.Text = "1,23";
            textBox2.Text = "15,4";
            textBox3.Text = "252";
            textBox4.Text = "Лаб. раб. 1-2-14 ст. 131 гр. Зюбин Д.А.";
        }
    }
}
