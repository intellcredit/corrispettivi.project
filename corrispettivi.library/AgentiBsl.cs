using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using it.tools.library;

namespace Corrispettivi.Library
{
    public class AgentiBsl
    {
        public class Integrazioni
        {
            public static DataTable read(int _id)
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
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgenteBslIntegrazioneRead";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AgenteBslIntegrazioneID", _id));

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

            public static DataTable view(string _periodorif)
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
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslIntegrazioniView";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));

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

            public static Result.Default write(int _id, int _agentegroupid, double _imp, int _anno, int _mese, string _note, string _utente)
            {
                Result.Default _result = new Result.Default();

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgenteBslIntegrazioneWrite";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AgenteGroupID", _agentegroupid));
                    _cmm.Parameters.Add(new SqlParameter("@Importo", _imp));
                    _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _anno));
                    _cmm.Parameters.Add(new SqlParameter("@MeseRif", _mese));
                    _cmm.Parameters.Add(new SqlParameter("@Note", _note));
                    _cmm.Parameters.Add(new SqlParameter("@Utente", _utente));

                    SqlParameter parID = new SqlParameter();
                    parID = new SqlParameter("@AgenteBslIntegrazioneID", SqlDbType.Int);
                    parID.Direction = ParameterDirection.InputOutput;
                    parID.Value = _id;
                    _cmm.Parameters.Add(parID);

                    SqlParameter parRES = new SqlParameter();
                    parRES = new SqlParameter("@Result", SqlDbType.VarChar, 4000);
                    parRES.Direction = ParameterDirection.Output;
                    parRES.Value = "";
                    _cmm.Parameters.Add(parRES);

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(50);
                    }
                    _cmm.EndExecuteNonQuery(result);
                    _cmm.Dispose();

                    _result.ID = (int)parID.Value;
                    _result.DESC = (string)parRES.Value;
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

                return _result;
            }

            public static Result.Default delete(int _id, string _utente)
            {
                Result.Default _result = new Result.Default();

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgenteBslIntegrazioneDelete";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AgenteBslIntegrazioneID", _id));
                    _cmm.Parameters.Add(new SqlParameter("@Utente", _utente));

                    SqlParameter parRES = new SqlParameter();
                    parRES = new SqlParameter("@Result", SqlDbType.VarChar, 4000);
                    parRES.Direction = ParameterDirection.Output;
                    parRES.Value = "";
                    _cmm.Parameters.Add(parRES);

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(50);
                    }
                    _cmm.EndExecuteNonQuery(result);
                    _cmm.Dispose();

                    _result.ID = _id;
                    _result.DESC = (string)parRES.Value;
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

                return _result;
            }

            public static Result.Default check(int _id, int _agentegroupid, int _anno, int _mese)
            {
                Result.Default _result = new Result.Default();

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgenteBslIntegrazioneCheckRange";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AgenteBslIntegrazioneID", _id));
                    _cmm.Parameters.Add(new SqlParameter("@AgenteGroupID", _agentegroupid));
                    _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _anno));
                    _cmm.Parameters.Add(new SqlParameter("@MeseRif", _mese));


                    SqlParameter parRES = new SqlParameter();
                    parRES = new SqlParameter("@Result", SqlDbType.VarChar, 4000);
                    parRES.Direction = ParameterDirection.Output;
                    parRES.Value = "";
                    _cmm.Parameters.Add(parRES);

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(50);
                    }
                    _cmm.EndExecuteNonQuery(result);
                    _cmm.Dispose();

                    _result.ID = _id;
                    _result.DESC = (string)parRES.Value;
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

                return _result;
            }
        }

        public class Elaborazione
        {
            public static DataTable read(int _id)
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
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgenteBslRead";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AgenteBslID", _id));

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

            public static DataTable view(string _periodorif, bool _export = false)
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
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslView";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));
                    _cmm.Parameters.Add(new SqlParameter("@Export", _export));

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

            public static DataTable report(string _periodorif)
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
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslReport";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));


                    _ds = new DataSet();
                    _da = new SqlDataAdapter(_cmm);
                    _da.Fill(_ds, "Report");

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

            public static DataTable finemese(string _periodoclose)
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
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiFineMese";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@PeriodoClose", _periodoclose));


                    _ds = new DataSet();
                    _da = new SqlDataAdapter(_cmm);
                    _da.Fill(_ds, "Report");

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

            public static Result.Default setStatusClosed(string _periodorif)
            {
                int _meserif = Convert.ToInt32(_periodorif.Split('/')[0]);
                int _annorif = Convert.ToInt32(_periodorif.Split('/')[1]);

                Result.Default _result = new Result.Default();

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslSetManualChiusura";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                    _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));

                    SqlParameter parRES = new SqlParameter();
                    parRES = new SqlParameter("@Result", SqlDbType.VarChar, 4000);
                    parRES.Direction = ParameterDirection.Output;
                    parRES.Value = "";
                    _cmm.Parameters.Add(parRES);

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(100);
                    }
                    _cmm.EndExecuteNonQuery(result);
                    _cmm.Dispose();

                    _result.ID = 0;
                    _result.DESC = (string)parRES.Value;
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

                return _result;
            }

            public static Result.Default tabReworks(string _periodorif, string _utente)
            {
                int _meserif = Convert.ToInt32(_periodorif.Split('/')[0]);
                int _annorif = Convert.ToInt32(_periodorif.Split('/')[1]);

                Result.Default _result = new Result.Default();
                _result.DESC = "OK";

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslExec";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                    _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));
                    _cmm.Parameters.Add(new SqlParameter("@Utente", _utente));

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(50);
                    }
                    _cmm.EndExecuteNonQuery(result);
                    _cmm.Dispose();
                }
                catch (SqlException exSQL)
                {
                    _result.DESC = string.Format("KO. {0}", exSQL.Message);
                    throw new Exception(exSQL.Message);
                }
                catch (Exception ex)
                {
                    _result.DESC = string.Format("KO. {0}", ex.Message);
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

                return _result;
            }

            public static Result.Default ManualSingleElab(int _agentegroupid, string _periodorif)
            {
                int _meserif = Convert.ToInt32(_periodorif.Split('/')[0]);
                int _annorif = Convert.ToInt32(_periodorif.Split('/')[1]);

                Result.Default _result = new Result.Default();
                _result.ID = 0;

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslSingleExec";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                    _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));
                    _cmm.Parameters.Add(new SqlParameter("@AgenteGroupID", _agentegroupid));

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(100);
                    }
                    _cmm.EndExecuteNonQuery(result);
                    _cmm.Dispose();

                    _result.DESC = "OK";
                }
                catch (SqlException exSQL)
                {
                    _result.DESC = string.Format("ErrorSql: {0}", exSQL.Message);
                }
                catch (Exception ex)
                {
                    _result.DESC = string.Format("ErrorGeneric: {0}", ex.Message);
                }
                finally
                {
                    if (_cnn.State == ConnectionState.Open)
                    {
                        _cnn.Close();
                        _cnn.Dispose();
                    }
                }

                if (_result.DESC.StartsWith("Error"))
                    new Exception(_result.DESC);

                return _result;
            }

            public static bool CheckIfClosed(string _periodorif)
            {
                bool result = false;
                int _meserif = Convert.ToInt32(_periodorif.Split('/')[0]);
                int _annorif = Convert.ToInt32(_periodorif.Split('/')[1]);

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslCheckIfClosed";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                    _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));

                    result = Convert.ToBoolean(_cmm.ExecuteScalar());

                    _cmm.Dispose();

                }
                catch (SqlException exSQL)
                {
                    string err = exSQL.Message;
                }
                catch (Exception ex)
                {
                    string err = ex.Message;
                }
                finally
                {
                    if (_cnn.State == ConnectionState.Open)
                    {
                        _cnn.Close();
                        _cnn.Dispose();
                    }
                }

                return result;
            }
        }

        public class OreStraordinarie
        {
            public static Result.Default write(int _id, int _annorif, int _meserif, int _callcenterid, int _agentegroupid, int _orelav, int _oremensctr, double _imporario, int _orelogeff, int _orelogminmax, int _orefranc, int _orelog, int _oremensmax, int _oreautor, string _utente)
            {
                Result.Default _result = new Result.Default();

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgenteBslOreStraordinarieWrite";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                    _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));
                    _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenterid));
                    _cmm.Parameters.Add(new SqlParameter("@AgenteGroupID", _agentegroupid));
                    _cmm.Parameters.Add(new SqlParameter("@OreLavorative", _orelav));
                    _cmm.Parameters.Add(new SqlParameter("@OreMensiliCtr", _oremensctr));
                    _cmm.Parameters.Add(new SqlParameter("@ImpOrario", _imporario));
                    _cmm.Parameters.Add(new SqlParameter("@OreLogEffettive", _orelogeff));
                    _cmm.Parameters.Add(new SqlParameter("@OreLogMinMax", _orelogminmax));
                    _cmm.Parameters.Add(new SqlParameter("@OreFranchigia", _orefranc));
                    _cmm.Parameters.Add(new SqlParameter("@OreLog", _orelog));
                    _cmm.Parameters.Add(new SqlParameter("@OreMensiliMax", _oremensmax));
                    _cmm.Parameters.Add(new SqlParameter("@OreAutorizzate", _oreautor));
                    _cmm.Parameters.Add(new SqlParameter("@Utente", _utente));

                    SqlParameter parID = new SqlParameter();
                    parID = new SqlParameter("@AgenteBslOraStraordinariaID", SqlDbType.Int);
                    parID.Direction = ParameterDirection.InputOutput;
                    parID.Value = _id;
                    _cmm.Parameters.Add(parID);

                    SqlParameter parRES = new SqlParameter();
                    parRES = new SqlParameter("@Result", SqlDbType.VarChar, 4000);
                    parRES.Direction = ParameterDirection.Output;
                    parRES.Value = "";
                    _cmm.Parameters.Add(parRES);

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(50);
                    }
                    _cmm.EndExecuteNonQuery(result);
                    _cmm.Dispose();

                    _result.ID = (int)parID.Value;
                    _result.DESC = (string)parRES.Value;
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

                return _result;
            }

            public static Result.Default delete(int _id, string _utente)
            {
                Result.Default _result = new Result.Default();

                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgenteBslOreStraordinarieDelete";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AgenteBslOraStraordinariaID", _id));

                    SqlParameter parRES = new SqlParameter();
                    parRES = new SqlParameter("@Result", SqlDbType.VarChar, 4000);
                    parRES.Direction = ParameterDirection.Output;
                    parRES.Value = "";
                    _cmm.Parameters.Add(parRES);

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(50);
                    }
                    _cmm.EndExecuteNonQuery(result);
                    _cmm.Dispose();

                    _result.ID = 0;
                    _result.DESC = (string)parRES.Value;
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

                return _result;
            }

            public static void exec(int _annorif, int _meserif, string _utente)
            {
                SqlConnection _cnn = default(SqlConnection);
                SqlCommand _cmm = default(SqlCommand);
                try
                {
                    //CONNECTION
                    _cnn = new SqlConnection();
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslOreStraordinarieExec";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                    _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));
                    _cmm.Parameters.Add(new SqlParameter("@Utente", _utente));

                    //esegue la stored procedure
                    IAsyncResult result = _cmm.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        System.Threading.Thread.Sleep(50);
                    }
                    _cmm.EndExecuteNonQuery(result);
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

            public static DataTable export(string _periodorif)
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
                    _cnn.ConnectionString = ConfigurationManager.ConnectionStrings["dbConn"].ToString();
                    _cnn.Open();
                    //COMMAND
                    _cmm = new SqlCommand();
                    _cmm.CommandText = "xAgentiBslOreStraordinarieExport";
                    _cmm.Connection = _cnn;
                    _cmm.CommandType = CommandType.StoredProcedure;

                    _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));

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
        }
    }
}