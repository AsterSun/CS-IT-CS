using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace _3_2_14
{
    public partial class Form1 : Form
    {
        public double XMin;
        public double XMax;
        public double Step;
        public double[] x;
        public double[] y;
        public double b;
        Chart chart;
        public Form1()
        {
            InitializeComponent();
        }

        private void CalcFunction()
        {
            int count = (int)Math.Ceiling((XMax - XMin) / Step) + 1;
            x = new double[count];
            y = new double[count];
            for (int i = 0; i < count; i++)
            {
                x[i] = XMin + Step * i;
                y[i] = (Math.Pow(x[i], 5.0 / 2.0) - b) * Math.Log(x[i] * x[i] + 12.7);
            }
        }

        private void CreateChart()
        {
            chart = new Chart();
            chart.Parent = this;
            chart.SetBounds(110, 10, ClientSize.Width - 100, ClientSize.Height - 20);

            ChartArea area = new ChartArea();
            area.Name = "myGraph";
            area.AxisX.Minimum = XMin;
            area.AxisX.Maximum = XMax;
            area.AxisX.MajorGrid.Interval = Step;
            chart.ChartAreas.Add(area);

            Series series1 = new Series();
            series1.ChartArea = "myGraph";
            series1.ChartType = SeriesChartType.Spline;
            series1.BorderWidth = 3;
            series1.LegendText = "f(x)";
            chart.Series.Add(series1);
            Legend legend = new Legend();
            chart.Legends.Add(legend);
        }



        private void Form1_Load(object sender, EventArgs e)
        {
            textBox1.Text = "0,25";
            textBox2.Text = "5,2";
            textBox3.Text = "0,3";
            textBox4.Text = "0,8";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                XMin = Convert.ToDouble(textBox1.Text);
                XMax = Convert.ToDouble(textBox2.Text);
                Step = Convert.ToDouble(textBox3.Text);
                b = Convert.ToDouble(textBox4.Text);
                CreateChart();
                CalcFunction();
                chart.Series[0].Points.DataBindXY(x, y);
                label5.Text = "Ошибок нет";
            }
            catch
            {
                label5.Text = "ОШИБКА!!!";
            }
        }
    }
}
