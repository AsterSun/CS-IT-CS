using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _6_1_1
{
    class Student
    {
        private string lastName;
        private string firstName;
        private string secondName;
        private string studentID;
        private DateTime birthday;
        public Student(string lastN, string firstN, string secondN, string studentI, DateTime birth)
        {
            this.lastName = lastN;
            this.firstName = firstN;
            this.secondName = secondN;
            this.studentID = studentI;
            this.birthday = birth;
        }

        public string LastName
        {
            get { return this.lastName; }
            set { this.lastName = value; }
        }
        public string FirstName
        {
           get { return this.firstName; }
           set { this.firstName = value; }
        }
         public string SecondName
        {
           get { return this.secondName; }
           set { this.secondName = value; }
        }
        public string StudentID
        {
            get { return this.studentID; }
            set { this.studentID = value; }
        }
        public DateTime Birthday
        {
            get { return this.birthday; }
            set { this.birthday = value; }
        }

        public void PrintStudent()
        {
            string dateFormat = "dd.MM.yyyy";
            Console.WriteLine("{0} {1} {2} {3} {4}", this.LastName, this.FirstName, this.SecondName, this.StudentID, Birthday.ToString(dateFormat));
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            Student st = new Student("Петров", "Артём", "Сергеевич", "20178323", DateTime.Parse("01.01.2000"));
            st.PrintStudent();
            Console.ReadKey();
        }
    }
}
