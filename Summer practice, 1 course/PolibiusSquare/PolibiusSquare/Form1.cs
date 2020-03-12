using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace PolibiusSquare
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}

		private void button1_Click(object sender, EventArgs e)
		{
			String alphabet = File.ReadAllText("alphabet.txt", Encoding.GetEncoding(1251));
			alphabet = alphabet.Replace(Environment.NewLine, " ");
			alphabet = alphabet.Replace(" ", "");
			char[,] Alphabet = new char[6, 5];
			for (int i = 0; i < 5; i++)
				for (int j = 0; j < 6; j++)
					Alphabet[j, i] = alphabet[(i * 6) + j];
			Random rnd = new Random();
			char[] tempstr = new char[6];
			char[] tempclm = new char[5];
			int tmp;
			for (int i = 0; i < 5; i++)
			{
				tmp = rnd.Next(0, 5);
				for(int j = 0; j < 6; j++)
				{
					tempstr[j] = Alphabet[j, i];
					Alphabet[j, i] = Alphabet[j, tmp];
					Alphabet[j, tmp] = tempstr[j];
				}
			}
			for (int i = 0; i < 6; i++)
			{
				tmp = rnd.Next(0, 6);
				for (int j = 0; j < 5; j++)
				{
					tempclm[j] = Alphabet[i, j];
					Alphabet[i, j] = Alphabet[tmp, j];
					Alphabet[tmp, j] = tempclm[j];
				}
			}
			String key = "";
			for (int i = 0; i < 5; i++)
			{
				for (int j = 0; j < 6; j++)
					key += Alphabet[j, i];
				key += "\r\n";
			}
			File.WriteAllText("key.txt", key, Encoding.GetEncoding(1251));
		}

		private void button2_Click(object sender, EventArgs e)
		{
			String open = File.ReadAllText("open.txt", Encoding.GetEncoding(1251));
			open = open.ToLower();
			String key = File.ReadAllText("key.txt", Encoding.GetEncoding(1251));
			key = key.Replace(Environment.NewLine, " ");
			key = key.Replace(" ", "");
			char[,] Key = new char[6, 5];
			for (int i = 0; i < 5; i++)
				for (int j = 0; j < 6; j++)
					Key[j, i] = key[(i * 6) + j];
			int flag;
			String crypt = "";
			for (int k = 0; k < open.Length; k++)
			{
				flag = 0;
				for (int i = 0; i < 5; i++) 
					for (int j = 0; (j < 6)&&(flag == 0); j++)
						if (open[k] == Key[j, i])
						{
							crypt += j+1;
							crypt += i+1;
							flag = 1;
						}
				if (flag == 0)
					crypt += open[k];
			}
			File.WriteAllText("encrypted.txt", crypt, Encoding.GetEncoding(1251));
		}

		private void button3_Click(object sender, EventArgs e)
		{
			String key = File.ReadAllText("key.txt", Encoding.GetEncoding(1251));
			key = key.Replace(Environment.NewLine, " ");
			key = key.Replace(" ", "");
			char[,] Key = new char[6, 5];
			for (int i = 0; i < 5; i++)
				for (int j = 0; j < 6; j++)
					Key[j, i] = key[(i * 6) + j];
			String encrypted = File.ReadAllText("encrypted.txt", Encoding.GetEncoding(1251));
			String decrypt = "";
			int test;
			for (int k = 0; k < encrypted.Length - 1; k++)
			{
				if (Char.IsDigit(encrypted[k]))
				{
					test = (int)Char.GetNumericValue(encrypted[k]) - 1;
					decrypt += Key[(int)Char.GetNumericValue(encrypted[k]) - 1, (int)Char.GetNumericValue(encrypted[k + 1]) - 1];
					k++;
				}
				else decrypt += encrypted[k];
			}
			if (!Char.IsDigit(encrypted[encrypted.Length - 1]))
				decrypt += encrypted[encrypted.Length - 1];
			File.WriteAllText("decrypted.txt", decrypt, Encoding.GetEncoding(1251));
		}
	}
}
