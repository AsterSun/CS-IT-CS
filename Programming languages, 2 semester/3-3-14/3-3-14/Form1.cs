using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _3_3_14
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Paint(object sender, PaintEventArgs e)
        {
            Graphics g = e.Graphics;
            g.Clear(Color.White);
            SolidBrush blueBrush = new SolidBrush(Color.SkyBlue);
            Point point11 = new Point(0, 0);
            Point point12 = new Point(0, 240);
            Point point13 = new Point(240, 240);
            Point point14 = new Point(240, 0);
            Point[] curvePoints1 = { point11, point12, point13, point14 };
            g.FillPolygon(blueBrush, curvePoints1);

            SolidBrush GreenBrush = new SolidBrush(Color.Green);
            Point point21 = new Point(0, 180);
            Point point22 = new Point(0, 240);
            Point point23 = new Point(240, 240);
            Point point24 = new Point(240, 180);
            Point[] curvePoints2 = { point21, point22, point23, point24 };
            g.FillPolygon(GreenBrush, curvePoints2);

            g.FillEllipse(new SolidBrush(Color.Yellow), 0, 0, 80, 80);

            SolidBrush WhiteBrush = new SolidBrush(Color.White);
            Point point31 = new Point(120, 140);
            Point point32 = new Point(140, 100);
            Point point33 = new Point(160, 140);
            Point point34 = new Point(140, 120);
            Point[] curvePoints3 = { point31, point32, point33, point34 };
            g.FillPolygon(WhiteBrush, curvePoints3);

            Point point41 = new Point(160, 140);
            Point point42 = new Point(180, 120);
            Point point43 = new Point(200, 140);
            Point point44 = new Point(220, 120);
            Point point45 = new Point(240, 140);
            Point point46 = new Point(200, 60);
            Point[] curvePoints4 = { point41, point42, point43, point44, point45, point46 };
            g.FillPolygon(WhiteBrush, curvePoints4);

            SolidBrush BrownBrush = new SolidBrush(Color.Brown);
            Point point51 = new Point(100, 180);
            Point point52 = new Point(120, 140);
            Point point53 = new Point(140, 120);
            Point point54 = new Point(160, 140);
            Point point55 = new Point(180, 120);
            Point point56 = new Point(200, 140);
            Point point57 = new Point(220, 120);
            Point point58 = new Point(240, 140);
            Point point59 = new Point(240, 180);
            Point[] curvePoints5 = { point51, point52, point53, point54, point55, point56, point57, point58, point59};
            g.FillPolygon(BrownBrush, curvePoints5);

            e.Graphics.FillRectangle(new SolidBrush(Color.Gray), new Rectangle(20, 180, 60, 60));

            Pen myPen = new Pen(Color.White, 4.0F);
            myPen.DashStyle = System.Drawing.Drawing2D.DashStyle.DashDotDot;

            g.DrawLine(myPen, 50, 180, 50, 240);
            g.DrawLine(new Pen(Brushes.Black, 2), 0, 180, 240, 180);
            g.DrawLine(new Pen(Brushes.Black, 2), 100, 180, 140, 100);
            g.DrawLine(new Pen(Brushes.Black, 2), 140, 100, 160, 140);
            g.DrawLine(new Pen(Brushes.Black, 2), 140, 180, 200, 60);
            g.DrawLine(new Pen(Brushes.Black, 2), 240, 140, 200, 60);
        }

    }
}
