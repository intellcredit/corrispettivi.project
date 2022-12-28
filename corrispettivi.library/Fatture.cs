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
    public class Fatture
    {
        public static Result.Default write(int _id, int _callcenterid, int _agentegroupid, int _commercialeid, int _annorif, int _meserif, string _numero, DateTime? _data, double? _importo, string _note, string _utente)
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
                _cmm.CommandText = "xFattureWrite";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenterid));
                _cmm.Parameters.Add(new SqlParameter("@AgenteGroupID", _agentegroupid));
                _cmm.Parameters.Add(new SqlParameter("@CommercialeID", _commercialeid));
                _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));
                _cmm.Parameters.Add(new SqlParameter("@Numero", _numero));
                _cmm.Parameters.Add(new SqlParameter("@Data", _data));
                _cmm.Parameters.Add(new SqlParameter("@Importo", _importo));
                _cmm.Parameters.Add(new SqlParameter("@Note", _note));
                _cmm.Parameters.Add(new SqlParameter("@Utente", _utente));

                SqlParameter parID = new SqlParameter();
                parID = new SqlParameter("@FatturaID", SqlDbType.Int);
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
                _cmm.CommandText = "xFattureDelete";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@FatturaID", _id));
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

        public static Result.Default deleteAll(int _callcenterid, int _agentegroupid, int _commercialeid, int _annorif, int _meserif, string _utente)
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
                _cmm.CommandText = "xFattureDeleleAll";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenterid));
                _cmm.Parameters.Add(new SqlParameter("@AgenteGroupID", _agentegroupid));
                _cmm.Parameters.Add(new SqlParameter("@CommercialeID", _commercialeid));
                _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));
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

        public static double saldo(int _callcenterid, int _agentegroupid, int _commercialeid, int _annorif, int _meserif)
        {
            double functionReturnValue;
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
                _cmm.CommandText = "xFattureSaldo";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenterid));
                _cmm.Parameters.Add(new SqlParameter("@AgenteGroupID", _agentegroupid));
                _cmm.Parameters.Add(new SqlParameter("@CommercialeID", _commercialeid));
                _cmm.Parameters.Add(new SqlParameter("@AnnoRif", _annorif));
                _cmm.Parameters.Add(new SqlParameter("@MeseRif", _meserif));

                functionReturnValue = Convert.ToDouble(_cmm.ExecuteScalar());

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