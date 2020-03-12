using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Cryptography;

namespace _4_1_11
{
    public partial class Form1 : Form
    {
        byte[] number1 = new byte[16];
        RandomNumberGenerator rng1;
        byte[] number2 = new byte[16];
        RandomNumberGenerator rng2;
        public int x = 140;
        public int y = 140;
        public int xr = 0;
        public int yr = 0;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
           
        }

        private void Form1_Paint(object sender, PaintEventArgs e)
        {
            Graphics g = e.Graphics;
            g.Clear(Color.Black);
            SolidBrush YellowBrush = new SolidBrush(Color.Yellow);
            Point point1 = new Point(x - 20, y);
            Point point2 = new Point(x - 5, y - 5);
            Point point3 = new Point(x, y - 20);
            Point point4 = new Point(x + 5, y - 5);
            Point point5 = new Point(x + 20, y);
            Point point6 = new Point(x + 5, y + 5);
            Point point7 = new Point(x, y + 20);
            Point point8 = new Point(x - 5, y + 5);
            Point[] curvePoints = { point1, point2, point3, point4, point5, point6, point7, point8 };
            g.FillPolygon(YellowBrush, curvePoints);

        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            rng1 = RandomNumberGenerator.Create();
            rng1.GetBytes(number1);
            xr = (BitConverter.ToInt16(number1, 0) % 5);
            rng2 = RandomNumberGenerator.Create();
            rng2.GetBytes(number2);
            yr = (BitConverter.ToInt16(number2, 0) % 5);
            x +=xr;
            y+= yr;
            Invalidate();
        }
    }
}
