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
    public class AgentiBc
    {
        public static DataTable Presenze(int _id)
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
                _cmm.CommandText = "xAgentiBcPresenzeView";
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

        public static DataTable PresenzeDettaglio(int _id)
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
                _cmm.CommandText = "xAgentiBcPresenzeDettaglioView";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@AgenteBcPresenzaID", _id));

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

        public static DataTable PresenzeDettaglioWeek(int _id)
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
                _cmm.CommandText = "xAgentiBcPresenzeDettaglioViewWeek";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@AgenteBcPresenzeWeekID", _id));

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
                _cmm.CommandText = "xAgentiBcSingleExec";
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
    }
}