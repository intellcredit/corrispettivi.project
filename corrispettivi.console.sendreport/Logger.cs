using System;
using System.Configuration;
using System.IO;


namespace emul.Utility
{
    public static class Logger
    {
        public enum LogType
        {
            Operation, Error, Job, Scheduler
        }


        #region Fields

        //private static string _loggingDirectory = Environment.CurrentDirectory + "\\logger\\";

        public static string _loggingDirectory = (
                                                  ConfigurationManager.AppSettings["LoggingDirectory"] == "CurrentDirectory"
                                                ? Environment.CurrentDirectory
                                                : ConfigurationManager.AppSettings["LoggingDirectory"]
                                                 ) + "\\logger\\";

        #endregion

        #region Methods
        /// <summary>
        /// create a log file in the Log folder
        /// if the parameter isError is true then append the message to a error file eles to a operation file
        /// the created file contains today date
        /// </summary>
        /// <param name="message">the message that will appearin the log   </param>
        /// <param name="isError">the flag depending the log will be error or operation</param>
        public static void Log(string message, LogType logtype = LogType.Operation, string jobname = "")
        {
            try
            {
                string fileName = "";

                //string today = string.Format("{0}{1}{2}", DateTime.Now.Year, DateTime.Now.Month.ToString("00"), DateTime.Now.Day.ToString("00"));
                string today = DateTime.Now.ToString("yyyyMMdd");

                if (!Directory.Exists(_loggingDirectory + today))
                    Directory.CreateDirectory(_loggingDirectory + today);

                string hh = DateTime.Now.Hour.ToString("00");
                string mi = DateTime.Now.Minute.ToString("00");
                string ss = DateTime.Now.Second.ToString("00");
                string time = string.Format("[{0}:{1}:{2}] ", hh, mi, ss);

                switch (logtype)
                {
                    case LogType.Job:
                        if (!Directory.Exists(_loggingDirectory + today + "\\jobs"))
                            Directory.CreateDirectory(_loggingDirectory + today + "\\jobs");

                        fileName = string.Format("\\jobs\\{0}.txt", jobname);
                        break;
                    case LogType.Error:
                        fileName = "errors.txt";
                        break;
                    case LogType.Operation:
                        fileName = "operations.txt";
                        break;
                    case LogType.Scheduler:
                        fileName = "scheduler.txt";
                        break;
                }

                StreamWriter sw = new StreamWriter(_loggingDirectory + today + "\\" + fileName, true);
                sw.WriteLine(time + message);
                sw.Close();


                Console.WriteLine(time + message);

            }
            catch (Exception ex)
            {
                string err = ex.Message + "\n" + ex.StackTrace;
            }
        }

        ///// <summary>
        ///// write a log about current processed  excel  file
        ///// </summary>
        ///// <param name="path"></param>
        ///// <param name="message"></param>
        //public static void LogExcel(string path, string message)
        //{
        //    try
        //    {
        //        string today = DateTime.Now.Day + "_" + DateTime.Now.Month + "_" + DateTime.Now.Year;
        //        if (!Directory.Exists(_loggingDirectory + today))
        //            Directory.CreateDirectory(_loggingDirectory + today);
        //        string errorFile = path + "_stato.txt";
        //        errorFile = errorFile.Contains("\\") ? errorFile.Substring(errorFile.LastIndexOf("\\") + 1) : errorFile;
        //        StreamWriter sw = new StreamWriter(_loggingDirectory + today + "\\" + errorFile, true);
        //        string ora = DateTime.Now.Hour.ToString();
        //        if (ora.Length == 1)
        //            ora = "0" + ora;
        //        string minut = DateTime.Now.Minute.ToString();
        //        if (minut.Length == 1)
        //            minut = "0" + minut;
        //        string secunda = DateTime.Now.Second.ToString();
        //        if (secunda.Length == 1)
        //            secunda = "0" + secunda;
        //        string time = string.Format("[{0}:{1}:{2}] ", ora, minut, secunda);
        //        sw.WriteLine(time + message);
        //        sw.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        string err = ex.Message + "\n" + ex.StackTrace;
        //    }
        //}

        #endregion
    }
}
