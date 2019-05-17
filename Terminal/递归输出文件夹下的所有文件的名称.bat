using System;
using System.IO;
 
namespace MyTest
{
    public class Program
    {
        public static void Main(string[] args)
        {
            // 假设是输出 f:\temp 文件下的所有文件的名称
            args = new string[] { "f:\\temp" };
            foreach (string path in args)
            {
                if (File.Exists(path))
                {
                    // path 是某个文件的路径
                    ProcessFile(path);
                }
                else if (Directory.Exists(path))
                {
                    // path 是某个文件夹的路径
                    ProcessDirectory(path);
                }
                else
                {
                    Console.WriteLine("{0} 不是一个有效的文件或文件夹路径。", path);
                }
            }
            System.Console.ReadLine();
        }
 
        // 根据传入的文件夹路径，递归查出它包含的所有文件和文件夹，并处理各个文件夹下包含的文件
        public static void ProcessDirectory(string targetDirectory)
        {
            // 处理 targetDirectory 路径下的文件列表
            string[] fileEntries = Directory.GetFiles(targetDirectory);
            foreach (string fileName in fileEntries)
            {
                ProcessFile(fileName);
            }
 
            // 递归到 targetDirectory 路径下的子路径中
            string[] subdirectoryEntries = Directory.GetDirectories(targetDirectory);
            foreach (string subdirectory in subdirectoryEntries)
            {
                ProcessDirectory(subdirectory);
            }
        }
 
        // 这里添加如何处理找到的文件的逻辑
        public static void ProcessFile(string path)
        {
            Console.WriteLine("已处理文件：'{0}'", path);
        }
    }
}