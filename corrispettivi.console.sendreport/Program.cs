using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using interop = Microsoft.Office.Interop.Excel;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;

namespace corrispettivi.console.sendreport
{
    class Program
    {
        static void Main(string[] args)
        {
            interop.Application excel;
            interop.Workbook worKbooK;

            try
            {
                string filename;

                string dirExport = (
                                ConfigurationManager.AppSettings["ExportDirectory"] == "CurrentDirectory"
                              ? Environment.CurrentDirectory
                              : ConfigurationManager.AppSettings["ExportDirectory"]
                              ) + @"\attach\";

                if (!Directory.Exists(dirExport))
                {
                    Directory.CreateDirectory(dirExport);
                }


                DataTable dt = getRequest();

                foreach (DataRow row in dt.Rows)
                {
                    /*
                    Console.WriteLine("==========================================================================");
                    Console.WriteLine("CallCenter: {0} ({1}); PeriodoRif: {2}", row["CallCenterNome"], row["CallCenterID"], row["PeriodoRif"]);
                    */

                    emul.Utility.Logger.Log("==========================================================================");
                    emul.Utility.Logger.Log(string.Format("CallCenter: {0} ({1}); PeriodoRif: {2}", row["CallCenterNome"], row["CallCenterID"], row["PeriodoRif"]));

                    filename = dirExport + row["CallCenterID"].ToString() + "_" + row["PeriodoRif"].ToString().Replace("/", "") + ".xlsx";


                    if (System.IO.File.Exists(filename)) System.IO.File.Delete(filename);

                    object misValue = System.Reflection.Missing.Value;

                    excel = new interop.Application();
                    excel.Visible = false;
                    excel.DisplayAlerts = false;
                    try
                    {
                        worKbooK = excel.Workbooks.Add(misValue);
                        writeSheet2(ref worKbooK, ExportCorrispettivi((int)row["CallCenterID"], row["PeriodoRif"].ToString()), "corrispettivi", "A", "V");
                        writeSheet2(ref worKbooK, ExportPremi((int)row["CallCenterID"], row["PeriodoRif"].ToString()), "premi", "A", "U");
                        writeSheet2(ref worKbooK, ExportIntegrazioni((int)row["CallCenterID"], row["PeriodoRif"].ToString()), "bonus provvigionali", "A", "U");
                        writeSheet2(ref worKbooK, ExportBc((int)row["CallCenterID"], row["PeriodoRif"].ToString()), "bonus contatti", "A", "I");
                        worKbooK.SaveAs(filename);
                        worKbooK.Close(true, misValue, misValue);
                    }
                    catch (Exception ex)
                    {
                        Console.Write(ex.Message);
                    }
                    excel.Quit();

                    //invia file excel per email
                    sendMail(filename, row);
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);

            }
            finally
            {
                worKbooK = null;
            }
        }

        static DataTable ExportCorrispettivi(int _callcenter, string _periodorif)
        {
            DataTable functionReturnValue = null;
            SqlConnection _cnn = default(SqlConnection);
            SqlCommand _cmm = default(SqlCommand);
            DataSet _ds = null;
            SqlDataAdapter _da = default(SqlDataAdapter);
            try
            {
                //CONNECTION
                _cnn = new SqlConnection();
                _cnn.ConnectionString = ConfigurationSettings.AppSettings["dbConn"].ToString();
                _cnn.Open();
                //COMMAND
                _cmm = new SqlCommand();
                _cmm.CommandText = "ccExportCorrispettivi";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                //@AnnoRif		 int
                //,@MeseRif		 int
                //,@CallCenterID  int

                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenter));
                _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));


                _ds = new DataSet();
                _da = new SqlDataAdapter(_cmm);
                _da.Fill(_ds, "info");

                functionReturnValue = _ds.Tables[0];

                //chiude il command
                _cmm.Dispose();
            }
            catch (SqlException exSQL)
            {
                throw new Exception(exSQL.Message);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                if (_cnn.State == ConnectionState.Open)
                {
                    _cnn.Close();
                    _cnn.Dispose();
                }
            }
            return functionReturnValue;
        }

        static DataTable ExportPremi(int _callcenter, string _periodorif)
        {
            DataTable functionReturnValue = null;
            SqlConnection _cnn = default(SqlConnection);
            SqlCommand _cmm = default(SqlCommand);
            DataSet _ds = null;
            SqlDataAdapter _da = default(SqlDataAdapter);
            try
            {
                //CONNECTION
                _cnn = new SqlConnection();
                _cnn.ConnectionString = ConfigurationSettings.AppSettings["dbConn"].ToString();
                _cnn.Open();
                //COMMAND
                _cmm = new SqlCommand();
                _cmm.CommandText = "ccExportPremi";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;
                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenter));
                _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));
                _ds = new DataSet();
                _da = new SqlDataAdapter(_cmm);
                _da.Fill(_ds, "info");

                functionReturnValue = _ds.Tables[0];

                //chiude il command
                _cmm.Dispose();
            }
            catch (SqlException exSQL)
            {
                throw new Exception(exSQL.Message);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                if (_cnn.State == ConnectionState.Open)
                {
                    _cnn.Close();
                    _cnn.Dispose();
                }
            }
            return functionReturnValue;
        }

        static DataTable ExportIntegrazioni(int _callcenter, string _periodorif)
        {
            DataTable functionReturnValue = null;
            SqlConnection _cnn = default(SqlConnection);
            SqlCommand _cmm = default(SqlCommand);
            DataSet _ds = null;
            SqlDataAdapter _da = default(SqlDataAdapter);
            try
            {
                //CONNECTION
                _cnn = new SqlConnection();
                _cnn.ConnectionString = ConfigurationSettings.AppSettings["dbConn"].ToString();
                _cnn.Open();
                //COMMAND
                _cmm = new SqlCommand();
                _cmm.CommandText = "ccExportIntegrazioni";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;
                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenter));
                _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));

                _ds = new DataSet();
                _da = new SqlDataAdapter(_cmm);
                _da.Fill(_ds, "info");

                functionReturnValue = _ds.Tables[0];

                //chiude il command
                _cmm.Dispose();
            }
            catch (SqlException exSQL)
            {
                throw new Exception(exSQL.Message);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                if (_cnn.State == ConnectionState.Open)
                {
                    _cnn.Close();
                    _cnn.Dispose();
                }
            }
            return functionReturnValue;
        }

        static DataTable ExportBc(int _callcenter, string _periodorif)
        {
            DataTable functionReturnValue = null;
            SqlConnection _cnn = default(SqlConnection);
            SqlCommand _cmm = default(SqlCommand);
            DataSet _ds = null;
            SqlDataAdapter _da = default(SqlDataAdapter);
            try
            {
                //CONNECTION
                _cnn = new SqlConnection();
                _cnn.ConnectionString = ConfigurationSettings.AppSettings["dbConn"].ToString();
                _cnn.Open();
                //COMMAND
                _cmm = new SqlCommand();
                _cmm.CommandText = "ccExportBc";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;
                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenter));
                _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));

                _ds = new DataSet();
                _da = new SqlDataAdapter(_cmm);
                _da.Fill(_ds, "info");

                functionReturnValue = _ds.Tables[0];

                //chiude il command
                _cmm.Dispose();
            }
            catch (SqlException exSQL)
            {
                throw new Exception(exSQL.Message);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                if (_cnn.State == ConnectionState.Open)
                {
                    _cnn.Close();
                    _cnn.Dispose();
                }
            }
            return functionReturnValue;
        }

        static void writeSheet(ref interop.Workbook worKbooK, DataTable exp, string sheetName)
        {
            double d = 0;

            //Console.WriteLine("*** {0} *** start", sheetName);

            emul.Utility.Logger.Log(string.Format("*** {0} *** start", sheetName));

            try
            {
                if (exp.Rows.Count > 0)
                {
                    int row = 1;
                    interop.Worksheet worKsheeT = (interop.Worksheet)worKbooK.Worksheets.Add();
                    worKsheeT.Name = sheetName;

                    foreach (DataRow datarow in exp.Rows)
                    {
                        row += 1;
                        for (int col = 1; col <= exp.Columns.Count; col++)
                        {
                            if (row == 2)
                            {
                                worKsheeT.Cells[1, col] = exp.Columns[col - 1].ColumnName;
                                worKsheeT.Cells[1, col].Font.Color = System.Drawing.Color.Black;
                                worKsheeT.Cells[1, col].Font.Bold = true;
                                worKsheeT.Cells[1, col].Interior.Color = System.Drawing.Color.LightGray;
                            }

                            switch (exp.Columns[col - 1].DataType.ToString())
                            {
                                //case "System.Int32":
                                //    formatRange = formatRange.Cells[row, col];; 
                                //    //formatRange.NumberFormat = "#,###,###.00";
                                //    worKsheeT.Cells[row, col] = datarow[col - 1].ToString();
                                //    break;
                                case "System.Decimal":
                                case "System.Double":
                                    //formatRange = formatRange.Cells[row, col]; ;
                                    //formatRange.NumberFormat = "#,###,###.00";
                                    //worKsheeT.Cells[row, col].NumberFormat = 10;

                                    d = Convert.ToDouble(datarow[col - 1].ToString());
                                    worKsheeT.Cells[row, col] = d;
                                    break;

                                //case "System.String":
                                //    worKsheeT.Columns[col].NumberFormat = "@";
                                //    worKsheeT.Cells[row, col] = datarow[col - 1].ToString();
                                //    break;
                                //case "System.DateTime":
                                //    //formatRange = formatRange.Cells[row, col];; 
                                //    //formatRange.NumberFormat = "MM/DD/YYYY";
                                //    worKsheeT.Cells[row, col].Style.NumberFormat.NumberFormatId = 14;
                                //    worKsheeT.Cells[row, col] = datarow[col - 1].ToString();
                                //    break;
                                //case "System.Date":
                                //    formatRange = formatRange.Cells[row, col];; 
                                //    formatRange.NumberFormat = "dd/MM/yyyy";
                                //    worKsheeT.Cells[row, col] = datarow[col - 1].ToString();
                                //    break;
                                default:
                                    worKsheeT.Columns[col].NumberFormat = "@";
                                    worKsheeT.Cells[row, col] = datarow[col - 1].ToString();
                                    break;
                            }
                            //worKsheeT.Columns[col].NumberFormat = "@";
                            //worKsheeT.Cells[row, col] = datarow[col - 1].ToString();

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
            }

            Console.WriteLine("*** {0} *** end", sheetName);
        }

        static void writeSheet2(ref interop.Workbook worKbooK, DataTable exp, string sheetName, string colStart, string colEnd)
        {
            double d = 0;

            //Console.WriteLine("*** {0} *** start", sheetName);

            emul.Utility.Logger.Log(string.Format("*** {0} *** start", sheetName));

            try
            {
                if (exp.Rows.Count > 0)
                {
                    interop.Worksheet worKsheeT = (interop.Worksheet)worKbooK.Worksheets.Add();
                    worKsheeT.Name = sheetName;

                    int numRows = exp.Rows.Count;
                    int numCols = exp.Columns.Count;

                    object[,] rows = new object[numRows, numCols];



                    for (int j = 0; j < numCols; j++)
                    {
                        rows[0, j] = exp.Columns[j].ColumnName;
                    }
                    for (int i = 1; i < numRows; i++)
                    {
                        for (int j = 0; j < numCols; j++)
                        {
                            rows[i, j] = exp.Rows[i][j];
                        }
                    }
                    interop.Range rangeRow = worKsheeT.Range[string.Format("{0}1:{1}{2}", colStart, colEnd, exp.Rows.Count)];
                    rangeRow.Value = rows;

                    interop.ListObject table = worKsheeT.ListObjects.Add(interop.XlListObjectSourceType.xlSrcRange, rangeRow, Type.Missing, interop.XlYesNoGuess.xlYes);

                    table.Name = sheetName;
                    table.TableStyle = "TableStyleMedium2";
                }
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
            }

            Console.WriteLine("*** {0} *** end", sheetName);
        }

        static void sendMail(string fileName, DataRow row)
        {
            try
            {
                emul.Utility.Logger.Log(string.Format("Invia mail. MailFrom: {0}; MailTo: ({1});", ConfigurationSettings.AppSettings["mailFrom"].ToString(), row["MailTo"].ToString()));


                SmtpClient client = new SmtpClient();
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Host = ConfigurationSettings.AppSettings["smtpclient_host"].ToString();
                client.Port = Convert.ToInt32(ConfigurationSettings.AppSettings["smtpclient_port"]);


                MailMessage mail = new MailMessage(ConfigurationSettings.AppSettings["mailFrom"].ToString(), row["MailTo"].ToString());
                mail.Subject = "Report riepilogativo tabulati mese di " + row["PeriodoRif"].ToString();
                mail.Body = "Email generata automaticamente dal sistema.";
                mail.Attachments.Add(new Attachment(@fileName));
                //mail.Attachments.Add(new Attachment(@"c:\vincenzo.xlsx"));
                client.Send(mail);


                emul.Utility.Logger.Log("Salva data invio email");
                setResponse((int)row["CallCenterRequestReportID"]);
            }
            catch (Exception ex)
            {
                Console.Write(ex.Message);
            }
        }

        static DataTable getRequest()
        {
            DataTable functionReturnValue = null;
            SqlConnection _cnn = default(SqlConnection);
            SqlCommand _cmm = default(SqlCommand);
            DataSet _ds = null;
            SqlDataAdapter _da = default(SqlDataAdapter);
            try
            {
                //CONNECTION
                _cnn = new SqlConnection();
                _cnn.ConnectionString = ConfigurationSettings.AppSettings["dbConn"].ToString();
                _cnn.Open();
                //COMMAND
                _cmm = new SqlCommand();
                _cmm.CommandText = " select CallCenterRequestReportID, CC.CallCenterID, CC.Nominativo as CallCenterNome, PeriodoRif, MailTo " +
                                   " from CallCenterRequestReport R " +
                                   " inner join CallCenter CC on R.CallCenterID = CC.CallCenterID " +
                                   " where DataInvio is null";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.Text;


                _ds = new DataSet();
                _da = new SqlDataAdapter(_cmm);
                _da.Fill(_ds, "param");

                functionReturnValue = _ds.Tables[0];

                //chiude il command
                _cmm.Dispose();
            }
            catch (SqlException exSQL)
            {
                throw new Exception(exSQL.Message);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                if (_cnn.State == ConnectionState.Open)
                {
                    _cnn.Close();
                    _cnn.Dispose();
                }
            }
            return functionReturnValue;

        }

        static void setResponse(int id)
        {
            SqlConnection _cnn = default(SqlConnection);
            SqlCommand _cmm = default(SqlCommand);
            try
            {
                //CONNECTION
                _cnn = new SqlConnection();
                _cnn.ConnectionString = ConfigurationSettings.AppSettings["dbConn"].ToString();
                _cnn.Open();
                _cmm = new SqlCommand();
                _cmm.CommandText = string.Format("update CallCenterRequestReport set DataInvio = getdate() where CallCenterRequestReportID = {0}", id);
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.Text;
                _cmm.ExecuteNonQuery();
                _cmm.Dispose();
            }
            catch (SqlException exSQL)
            {
                throw new Exception(exSQL.Message);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                if (_cnn.State == ConnectionState.Open)
                {
                    _cnn.Close();
                    _cnn.Dispose();
                }
            }
        }
    }
}
