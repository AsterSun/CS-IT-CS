using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _5_2_11
{
    public partial class Form1 : Form
    {
        public class Vector
        {
            private double Xcoordinate;
            private double Ycoordinate;
            private string VName;
            public string Name
            {
                set { VName = value; }
                get { return VName; }
            }

            public double GetSize()
            {
                return Math.Sqrt((Xcoordinate * Xcoordinate) + (Ycoordinate * Ycoordinate));
            }
            public string GetCoordinate
            {
                get
                {
                    return ("(" + Convert.ToString(Xcoordinate) + " ; " + Convert.ToString(Ycoordinate) + ")");
                }
            }

            public double SendXCoordinate
            {
                set
                {
                    Xcoordinate = value;
                }
            }
            public double SendYCoordinate
            {
                set
                {
                    Ycoordinate = value;
                }
            }

            public Vector() // по умолчанию - нулевой вектор
            {
                Xcoordinate = 0;
                Ycoordinate = 0;
            }

            public Vector(double X, double Y)
            {
                Xcoordinate = X;
                Ycoordinate = Y;
            }
            ~Vector()
            {
                System.Diagnostics.Trace.WriteLine( "(" + Convert.ToDouble(this.Xcoordinate) + " ; " + Convert.ToDouble(this.Ycoordinate) + ")" );
            }

        }

        public Form1()
        {
            InitializeComponent();
        }

        Vector vect;
        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                vect = new Vector(Convert.ToDouble(textBox1.Text), Convert.ToDouble(textBox2.Text));
                textBox3.Text = Convert.ToString(vect.GetSize());
            }
            catch
            { 
                textBox3.Text = Convert.ToString(vect.GetSize());
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                vect = new Vector(Convert.ToDouble(textBox1.Text), Convert.ToDouble(textBox2.Text));
                textBox4.Text = vect.GetCoordinate;
            }
            catch { }
        }
    }
}
