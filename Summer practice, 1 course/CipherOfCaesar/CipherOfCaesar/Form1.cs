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

namespace CipherOfCaesar
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
			Random rnd = new Random();
			int tmp;
			char temp;
			String key = alphabet + "\r\n";
			for (int i = 0; i < alphabet.Length; i++)
			{
				tmp = rnd.Next(0, alphabet.Length);
				temp = alphabet[i];
				alphabet = alphabet.Remove(i, 1).Insert(i, alphabet[tmp].ToString());
				alphabet = alphabet.Remove(tmp, 1).Insert(tmp, temp.ToString());
			}
			key += alphabet;
			File.WriteAllText("key.txt", key, Encoding.GetEncoding(1251));
		}

		private void button2_Click(object sender, EventArgs e)
		{
			String open = File.ReadAllText("open.txt", Encoding.GetEncoding(1251));
			String key = File.ReadAllText("key.txt", Encoding.GetEncoding(1251));
			open = open.ToLower();
			key = key.Replace(Environment.NewLine, "");
			String crypt = "";
			int flag;
			for (int i = 0; i < open.Length; i++)
			{
				flag = 0;
				for (int j = 0; (j < key.Length / 2) && (flag == 0); j++)
					if (open[i] == key[j])
					{
						crypt += key[j + key.Length / 2];
						flag = 1;
					}
				if (flag == 0)
					crypt += open[i];
			}
			File.WriteAllText("encrypted.txt", crypt, Encoding.GetEncoding(1251));
		}

		private void button3_Click(object sender, EventArgs e)
		{
			String encrypted = File.ReadAllText("encrypted.txt", Encoding.GetEncoding(1251));
			String key = File.ReadAllText("key.txt", Encoding.GetEncoding(1251));
			key = key.Replace(Environment.NewLine, "");
			String uncrypt = "";
			int flag;
			for (int i = 0; i < encrypted.Length; i++)
			{
				flag = 0;
				for (int j = key.Length / 2; (j < key.Length) && (flag == 0); j++)
					if (encrypted[i] == key[j])
					{
						uncrypt += key[j - key.Length / 2];
						flag = 1;
					}
				if (flag == 0)
					uncrypt += encrypted[i];
			}
			File.WriteAllText("decrypted.txt", uncrypt, Encoding.GetEncoding(1251));
		}
	}
}
