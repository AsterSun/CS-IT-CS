using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace _1_1_14
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            button1.Height += 10;
            button2.Height += 10;
            button3.Height += 10;
            button4.Height += 10;
            button1.Width += 10;
            button2.Width += 10;
            button3.Width += 10;
            button4.Width += 10;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            button1.Height -= 10;
            button2.Height -= 10;
            button3.Height -= 10;
            button4.Height -= 10;
            button1.Width -= 10;
            button2.Width -= 10;
            button3.Width -= 10;
            button4.Width -= 10;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            button1.Left -= 10;
            button2.Left -= 10;
            button3.Left -= 10;
            button4.Left -= 10;
            button1.Top -= 10;
            button2.Top -= 10;
            button3.Top -= 10;
            button4.Top -= 10;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            button1.Left += 10;
            button2.Left += 10;
            button3.Left += 10;
            button4.Left += 10;
            button1.Top += 10;
            button2.Top += 10;
            button3.Top += 10;
            button4.Top += 10;
        }
    }
}
