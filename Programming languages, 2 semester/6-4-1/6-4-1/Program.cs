using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace _6_4_1
{
    [Serializable]
    class Student
    {
        string lastName;
        string firstName;
        string secondName;
        int studentId;
        DateTime birthday = new DateTime();
        string dateFormat = "dd.MM.yyyy";


        public Student(string lastname, string firstname, string secondname, int studentid, string date)
        {
            lastName = lastname;
            firstName = firstname;
            secondName = secondname;
            studentId = studentid;
            birthday = DateTime.Parse(date);
        }

        public void printStudent()
        {
            Console.WriteLine("{0,5} {1,4} {2, 9} {3,8} {4,10}",
            lastName, firstName, secondName, studentId.ToString(), birthday.ToString(dateFormat));
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            Student student = new Student("Perov", "Gleb", "Igorevich", 20170001, "01.03.2000");
            student.printStudent();
            Console.WriteLine("Экземпляр создан");
            Console.ReadKey();
            BinaryFormatter formatter = new BinaryFormatter();
            using (FileStream file = new FileStream("F.bin", FileMode.OpenOrCreate))
            {
                formatter.Serialize(file, student);
                Console.WriteLine("Экземпляр сериализован");
            };
            Console.ReadKey();
            using (FileStream file = new FileStream("F.bin", FileMode.OpenOrCreate))
            {
                Student desearstudent = (Student)formatter.Deserialize(file);
                Console.WriteLine("Экземпляр десериализован");
                desearstudent.printStudent();
                file.Close();
                File.Delete("F.bin");
                Console.ReadKey();
            };
        }
    }
}
