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
    public class paramBcCompensiSettimanaliMaxMese
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
                _cmm.CommandText = "xParamBcCompensiSettimanaliMaxMeseRead";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@paramBcCompensoSettimanaleMaxMeseID", _id));

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

        public static DataTable view(int _idsocieta, int _idbase)
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
                _cmm.CommandText = "xParamBcCompensiSettimanaliMaxMeseView";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;


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

        public static Result.Default write(int _id, double _comp, DateTime _dtinizio, DateTime? _dtfine, string _note, string _utente)
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
                _cmm.CommandText = "xParamBcCompensiSettimanaliMaxMeseWrite";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;
                _cmm.Parameters.Add(new SqlParameter("@Compenso", _comp));
                _cmm.Parameters.Add(new SqlParameter("@DataInizio", _dtinizio));
                _cmm.Parameters.Add(new SqlParameter("@DataFine", _dtfine));
                _cmm.Parameters.Add(new SqlParameter("@Note", _note));
                _cmm.Parameters.Add(new SqlParameter("@Utente", _utente));

                SqlParameter parID = new SqlParameter();
                parID = new SqlParameter("@paramBcCompensoSettimanaleMaxMeseID", SqlDbType.Int);
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
                _cmm.CommandText = "xParamBcCompensiSettimanaliMaxMeseDelete";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@paramBcCompensoSettimanaleMaxMeseID", _id));
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

        public static Result.Default checkrange(int _id, DateTime _dtinizio, DateTime? _dtfine)
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
                _cmm.CommandText = "xParamBcCompensiSettimanaliMaxMeseCheckRange";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@paramBcCompensoSettimanaleMaxMeseID", _id));
                _cmm.Parameters.Add(new SqlParameter("@DataInizio", _dtinizio));
                _cmm.Parameters.Add(new SqlParameter("@DataFine", _dtfine));

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
}