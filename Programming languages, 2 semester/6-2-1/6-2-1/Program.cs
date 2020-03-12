using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Text.RegularExpressions;

namespace ConsoleApp2
{
    class Student
    {
        string lastName;
        string firstName;
        string secondName;
        int studentID;
        public DateTime birthday = new DateTime();
        string dateFormat = "dd.MM.yyyy";

        string Birthday
        {
            get { return birthday.ToString(dateFormat); }
            set { birthday = DateTime.Parse(value); }
        }


        public Student(string lastname, string firstname, string secondname, int studentid, string date)
        {
            lastName = lastname;
            firstName = firstname;
            secondName = secondname;
            studentID = studentid;
            Birthday = date;
        }

        public void printStudent()
        {
            Console.WriteLine("{0,10} {1,10} {2,15} {3,12} {4,12}",
            lastName, firstName, secondName, studentID.ToString(), birthday.ToString(dateFormat));
        }
    }

    class Group
    {
        static int studentCount;
        public Student[] studentGroup;

        public int StudentCount
        {
            get
            {
                return studentCount;
            }
            set
            {
                if (value > 0)
                    studentCount = value;
                else Console.WriteLine("Вы пытаетесь создать пустую группу");
            }
        }

        public void CreateGroup(ref Student[] studentGroup)
        {
            studentGroup = new Student[studentCount];
            FileStream file = new FileStream("F.txt", FileMode.Open, FileAccess.Read);
            StreamReader reader = new StreamReader(file);
            reader.ReadLine();
            for (int i = 0; i < studentCount; i++)
            {
                string s = reader.ReadLine();
                Regex r = new Regex(@"\b[A-Z][a-z]*\b");
                Match fnd = r.Match(s);
                string lastname, firstname, secondname, birth;
                int id;
                lastname = fnd.ToString();
                fnd = fnd.NextMatch();
                firstname = fnd.ToString();
                fnd = fnd.NextMatch();
                secondname = fnd.ToString();
                r = new Regex(@"\d{8}");
                id = int.Parse(r.Match(s).ToString());
                fnd = r.Match(s);
                s = s.Remove(0, fnd.Index + 8);
                r = new Regex(@"\d{2}.\d{2}.\d{4}");
                fnd = r.Match(s);
                birth = fnd.ToString();
                studentGroup[i] = new Student(lastname, firstname, secondname, id, birth);
            }
            reader.Close();
            file.Close();
        }

        public void PrintGroup()
        {
            Console.WriteLine("{0,10} {1,10} {2,15} {3,12} {4,12}", "Фамилия", "Имя", "Отчество", "Студ.билет", "Дата рождения");
            Console.WriteLine("---------------------------------------------------------------");
            for (int i = 0; i < studentCount; i++)
            {
                studentGroup[i].printStudent();
            }
            if (studentCount < 1)
            {
                Console.WriteLine("Эта группа пуста! Проверьте правильность введённых данных!");
            }
        }

        public void GetOldestStudent()
        {
            bool[] studentCopy = new bool[StudentCount];
            for (int i = 0; i < StudentCount; i++)
                studentCopy[i] = true;
            int imax = 0;
            for (int i = 0; i < studentCount; i++)
                if (studentGroup[i].birthday < studentGroup[imax].birthday)
                    imax = i;
            for (int i = 0; i < studentCount; i++)
                if (studentGroup[i].birthday > studentGroup[imax].birthday)
                    studentCopy[i] = false;
            Console.WriteLine("---------------------------------------------------------------");
            Console.WriteLine("                Самый старший студент:");
            for (int i = 0; i < studentCount; i++)
                if (studentCopy[i] == true)
                    studentGroup[i].printStudent();
        }
    }
    class Solution
    {
        static void Main(string[] args)
        {
            FileStream file = new FileStream("F.txt", FileMode.Open, FileAccess.Read);
            StreamReader reader = new StreamReader(file, Encoding.Default);
            int n = int.Parse(reader.ReadLine());
            Group group = new Group();
            group.StudentCount = n;
            group.CreateGroup(ref group.studentGroup);
            group.PrintGroup();
            group.GetOldestStudent();
            Console.ReadKey();
        }
    }
}
