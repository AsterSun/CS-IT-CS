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

namespace PairedCipher
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
			String password = File.ReadAllText("password.txt", Encoding.GetEncoding(1251));
			password = password.Replace(" ", "");
			String key = "";
			for (int i = 0; i < password.Length; i++)
				for (int j = 0; j < alphabet.Length; j++)
					if (password[i] == alphabet[j])
					{
						key += password[i];
						alphabet = alphabet.Remove(j, 1);
						j = alphabet.Length;
					}
			key += alphabet;
			int half = key.Length / 2;
			String key1 = key.Substring(0, half);
			String key2 = key.Substring(half, half);
			key = key1 + "\r\n" + key2;
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
				for (int j = 0; (j < key.Length) && (flag == 0); j++)
					if (open[i] == key[j])
					{
						if (j < key.Length / 2)
							crypt += key[j + key.Length / 2];
						else
							crypt += key[j - key.Length / 2];
						flag = 1;
					}
				if (flag == 0)
					crypt += open[i];
			}
			File.WriteAllText("encrypted.txt", crypt, Encoding.GetEncoding(1251));
		}

		private void button3_Click(object sender, EventArgs e)
		{
			String key = File.ReadAllText("key.txt", Encoding.GetEncoding(1251));
			key = key.Replace(Environment.NewLine, "");
			String encrypted = File.ReadAllText("encrypted.txt", Encoding.GetEncoding(1251));
			String decrypt = "";
			int flag;
			for (int i = 0; i < encrypted.Length; i++)
			{
				flag = 0;
				for (int j = 0; (j < key.Length) && (flag == 0); j++)
					if (encrypted[i] == key[j])
					{
						if (j < key.Length / 2)
							decrypt += key[j + key.Length / 2];
						else
							decrypt += key[j - key.Length / 2];
						flag = 1;
					}
				if (flag == 0)
					decrypt += encrypted[i];
			}
			File.WriteAllText("decrypted.txt", decrypt, Encoding.GetEncoding(1251));
		}

		private void Form1_Load(object sender, EventArgs e)
		{
		}
	}
}
