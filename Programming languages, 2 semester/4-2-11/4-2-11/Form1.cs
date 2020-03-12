using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace _4_2_11
{
    public partial class Form1 : Form
    {
        private Point PreviousPoint, point;
        private Bitmap bmp;
        private Graphics g;
        public int PrgValue;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            PrgValue = Convert.ToInt32(textBox1.Text);
                for (int i = 0; i < bmp.Width; i++)
                    for (int j = 0; j < bmp.Height; j++)
                    {
                        int R = bmp.GetPixel(i, j).R;
                        int G = bmp.GetPixel(i, j).G;
                        int B = bmp.GetPixel(i, j).B;
                        int Value = (R + G + B) / 3;
                    Color p;
                    if (Value < PrgValue)
                    {
                      p = Color.FromArgb(255, 0, 0, 0);
                    }
                    else
                    {
                      p = Color.FromArgb(255, 255, 255, 255);
                    }
                    bmp.SetPixel(i, j, p);
                    }
                Refresh();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Filter = "Image files (*.BMP, *.JPG, *.GIF, *.TIF, *.PNG, *.ICO, *.EMF, *.WMF)|*.bmp;*.jpg;*.gif; *.tif; *.png; *.ico; *.emf; *.wmf";
            if (dialog.ShowDialog() == DialogResult.OK)
            {
                Image image = Image.FromFile(dialog.FileName);
                int width = image.Width;
                int height = image.Height;
                pictureBox1.Width = width;
                pictureBox1.Height = height;

                bmp = new Bitmap(image, width, height);

                pictureBox1.Image = bmp;
                g = Graphics.FromImage(pictureBox1.Image);
            }
        }
    }
}
