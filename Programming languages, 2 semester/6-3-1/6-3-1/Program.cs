using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Text.RegularExpressions;

namespace _6_3_1
{
    class Person
    {
        private string lastName;
        private string firstName;
        private string secondName;
        private DateTime birthday;
        string dateFormat = "dd.MM.yyyy";

        public Person(string lastname, string firstname, string secondname, string date)
        {
            lastName = lastname;
            firstName = firstname;
            secondName = secondname;
            birthday = DateTime.Parse(date);
        }

        public string getDateFormat
        {
            get
            {
                return dateFormat;
            }
        }
        public string getlastName
        {
            get { return lastName; }
        }
        public string getfirstName
        {
            get { return firstName; }
        }
        public string getsecondName
        {
            get { return secondName; }
        }
        public DateTime getbirthday
        {
            get { return birthday; }
        }
    }

    class Student : Person
    {
        private int studentId;
        public Student(string lastname, string firstname, string secondname, string birth, int sid) : base(lastname, firstname, secondname, birth)
        {
            studentId = sid;
        }

        public int getstudentId
        {
            get { return studentId; }
        }

        public void printStudent()
        {
            Console.WriteLine("{0,15} {1,10} {2,15} {3,12} {4,12}",
            getlastName, getfirstName, getsecondName, getstudentId.ToString(), getbirthday.ToString(getDateFormat));
        }
    }

    class Teacher : Person
    {
        private string jobTitle;

        public Teacher(string lastname, string firstname, string secondname, string birth, string jobt) : base(lastname, firstname, secondname, birth)
        {
            jobTitle = jobt;
        }

        public void PrintTeacher()
        {
            Console.WriteLine("{0,15} {1,10} {2,15} {3,12} {4,12}",
            getlastName, getfirstName, getsecondName, jobTitle, getbirthday.ToString(getDateFormat));
        }
    }

    class GroupWithTeacher
    {
        int countStudent;
        int countTeacher;
        Student[] students;
        Teacher[] teachers;

        public int CountStudent
        {
            get
            {
                return countStudent;
            }
            set
            {
                if (value > 0)
                    countStudent = value;
                else Console.WriteLine("Отсутствуют студенты!");
            }
        }
        public int CountTeacher
        {
            get
            {
                return countTeacher;
            }
            set
            {
                if (value > 0)
                    countTeacher = value;
                else Console.WriteLine("Отсутствуют преподаватели!");
            }
        }

        public void CreateGroup()
        {
            FileStream file = new FileStream("F.txt", FileMode.OpenOrCreate);
            StreamReader read = new StreamReader(file);
            CountStudent = int.Parse(read.ReadLine());
            students = new Student[CountStudent];
            for (int i = 0; i < CountStudent; i++)
            {
                string s = read.ReadLine();
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
                students[i] = new Student(lastname, firstname, secondname, birth, id);
            }
            CountTeacher = int.Parse(read.ReadLine());
            teachers = new Teacher[CountTeacher];
            for (int i = 0; i < CountTeacher; i++)
            {
                string s = read.ReadLine();
                Regex r = new Regex(@"\b[A-Z][a-z]*\b");
                Match fnd = r.Match(s);
                string lastname, firstname, secondname, jobt, birth;
                lastname = fnd.ToString();
                fnd = fnd.NextMatch();
                firstname = fnd.ToString();
                fnd = fnd.NextMatch();
                secondname = fnd.ToString();
                fnd = fnd.NextMatch();
                jobt = fnd.ToString();
                s = s.Remove(0, fnd.Index + fnd.Length);
                r = new Regex(@"\d{2}.\d{2}.\d{4}");
                fnd = r.Match(s);
                birth = fnd.ToString();
                teachers[i] = new Teacher(lastname, firstname, secondname, birth, jobt);
            }
            read.Close();
            file.Close();
        }
        public void PrintGroup()
        {
            Console.WriteLine();
            Console.WriteLine("Студенты:");
            for (int i = 0; i < countStudent; i++)
                students[i].printStudent();
            Console.WriteLine("Преподаватели:");
            for (int i = 0; i < countTeacher; i++)
                teachers[i].PrintTeacher();
            Console.WriteLine();
        }
        public void Sort()
        {
            for (int i = 0; i < countStudent; i++)
            {
                for (int j = i + 1; j < countStudent; j++)
                {
                    if (students[i].getbirthday < students[j].getbirthday)
                    {
                        Student st = students[j];
                        Student st2 = students[i];
                        students[j] = st2;
                        students[i] = st;
                    }
                }
            }
            int state = 0;
            for (int i = 0; i < countTeacher; i++)
            {
                for (int j = i + 1; j < countTeacher; j++)
                {
                    state = string.Compare(teachers[i].getlastName, teachers[j].getlastName);
                    if (state == 1)
                    { 
                                Teacher th1 = teachers[i];
                                Teacher th2 = teachers[j];
                                teachers[i] = th2;
                                teachers[j] = th1;
                                break;
                            
                    }
                }
            }
            this.PrintGroup();
        }
    }


    class Solution
    {
        static void Main(string[] args)
        {
            GroupWithTeacher Group = new GroupWithTeacher();
            Console.WriteLine("Исходный список:");
            Group.CreateGroup();
            Group.PrintGroup();
            Console.WriteLine("--------------------------------------------------------------------");
            Console.WriteLine("Остортированный список:");
            Group.Sort();
            Console.ReadKey();
        }
    }
}