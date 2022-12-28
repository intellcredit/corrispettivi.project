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
    public class Tabulati
    {
        public static DataTable Totale(string _periodorif)
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
                _cmm.CommandText = "xTabulatiView";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

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

        public static DataTable Dettaglio(string _periodorif, int _agenteGroupID, int _oreContratto, int _callCenterID)
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
                _cmm.CommandText = "xTabulatiDettaglioView";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodorif));
                _cmm.Parameters.Add(new SqlParameter("@AgenteGroupID", _agenteGroupID));
                _cmm.Parameters.Add(new SqlParameter("@OreContratto", _oreContratto));
                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callCenterID));

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

        public enum UrlType
        {
            Url = 1,
            UrlExport = 2
        }

        public static string Url(int _tipotabulatoid, UrlType _type)
        {
            string _result;
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
                _cmm.CommandText = "xTipoTabulatoUrlRead";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@TipoTabulatoID", _tipotabulatoid));
                _cmm.Parameters.Add(new SqlParameter("@UrlType", (int)_type));

                _result = (string)_cmm.ExecuteScalar();

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
            return _result;
        }

        public static string UrlAgenti(int _tipotabulatoid, UrlType _type)
        {
            string _result;
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
                _cmm.CommandText = "xTipoTabulatoUrlReadAgenti";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@TipoTabulatoID", _tipotabulatoid));
                _cmm.Parameters.Add(new SqlParameter("@UrlType", (int)_type));

                _result = (string)_cmm.ExecuteScalar();

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
            return _result;
        }

        public static string UrlCommerciali(int _tipotabulatoid, UrlType _type)
        {
            string _result;
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
                _cmm.CommandText = "xTipoTabulatoUrlReadCommerciali";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@TipoTabulatoID", _tipotabulatoid));
                _cmm.Parameters.Add(new SqlParameter("@UrlType", (int)_type));

                _result = (string)_cmm.ExecuteScalar();

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
            return _result;
        }

        public static Result.Default SetManualApproved(int _agentegroupid, string _periodorif)
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
                _cmm.CommandText = "xAgentiSetManualSingleApprovazione";
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
                _result.DESC = string.Format("ErrorSql: Tabulati.SetManualApproved: {0}", exSQL.Message);
            }
            catch (Exception ex)
            {
                _result.DESC = string.Format("ErrorGeneric: Tabulati.SetManualApproved: {0}", ex.Message);
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

        public static Result.Default SetManualPublished(int _agentegroupid, string _periodorif)
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
                _cmm.CommandText = "xAgentiSetManualSinglePubblicazione";
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
                _result.DESC = string.Format("ErrorSql: Tabulati.SetManualPublished: {0}", exSQL.Message);
            }
            catch (Exception ex)
            {
                _result.DESC = string.Format("ErrorGeneric: Tabulati.SetManualPublished: {0}", ex.Message);
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

        public static Result.Default SetManualClosed(int _agentegroupid, string _periodorif)
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
                _cmm.CommandText = "xAgentiSetManualSingleChiusura";
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
                _result.DESC = string.Format("ErrorSql: Tabulati.SetManualClosed: {0}", exSQL.Message);
            }
            catch (Exception ex)
            {
                _result.DESC = string.Format("ErrorGeneric: Tabulati.SetManualClosed: {0}", ex.Message);
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
    }
}