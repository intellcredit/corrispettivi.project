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
    public class paramCallCenter
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
                _cmm.CommandText = "xParamCallCenterRead";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@paramCallCenterID", _id));

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

        public static DataTable read(int _idcallcenter, string _periodoRif)
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
                _cmm.CommandText = "xParamCallCenterReadByPeriodo";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _idcallcenter));
                _cmm.Parameters.Add(new SqlParameter("@PeriodoRif", _periodoRif));

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
                _cmm.CommandText = "xParamCallCenterView";
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

        public static Result.Default write(int _id, int _callcenterid
                                        , bool _execCorrispettivi, bool _execBsl, bool _execBc, bool _execPremi, bool _execIntegrazioni, bool _execSpese, bool _execOreStraordinarie
                                        , bool _viewAmministratore, bool _viewDirezione, bool _viewContabilitaCallCenter, bool _viewContabilitaAgenti, bool _viewContabilitaProcuratori, bool _viewUffPersonale
                                        , int _tipoElaborazioneID, bool _viewOreLavorative, DateTime _dtinizio, DateTime? _dtfine, string _note, string _utente)
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
                _cmm.CommandText = "xParamCallCenterWrite";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenterid));
                _cmm.Parameters.Add(new SqlParameter("@execAgentiCorrispettivi", _execCorrispettivi));
                _cmm.Parameters.Add(new SqlParameter("@execAgentiBsl", _execBsl));
                _cmm.Parameters.Add(new SqlParameter("@execAgentiBc", _execBc));
                _cmm.Parameters.Add(new SqlParameter("@execAgentiPremi", _execPremi));
                _cmm.Parameters.Add(new SqlParameter("@execAgentiIntegrazioni", _execIntegrazioni));
                _cmm.Parameters.Add(new SqlParameter("@execAgentiSpese", _execSpese));
                _cmm.Parameters.Add(new SqlParameter("@execAgentiOreStraordinarie", _execOreStraordinarie));

                _cmm.Parameters.Add(new SqlParameter("@viewAmministratore", _viewAmministratore));
                _cmm.Parameters.Add(new SqlParameter("@viewDirezione", _viewDirezione));
                _cmm.Parameters.Add(new SqlParameter("@viewContabilitaCallCenter", _viewContabilitaCallCenter));
                _cmm.Parameters.Add(new SqlParameter("@viewContabilitaAgenti", _viewContabilitaAgenti));
                _cmm.Parameters.Add(new SqlParameter("@viewContabilitaProcuratori", _viewContabilitaProcuratori));
                _cmm.Parameters.Add(new SqlParameter("@viewUffPersonale", _viewUffPersonale));

                _cmm.Parameters.Add(new SqlParameter("@TipoElaborazioneID", _tipoElaborazioneID));
                _cmm.Parameters.Add(new SqlParameter("@viewOreLavorative", _viewOreLavorative));

                _cmm.Parameters.Add(new SqlParameter("@DataInizio", _dtinizio));
                _cmm.Parameters.Add(new SqlParameter("@DataFine", _dtfine));
                _cmm.Parameters.Add(new SqlParameter("@Note", _note));
                _cmm.Parameters.Add(new SqlParameter("@Utente", _utente));

                SqlParameter parID = new SqlParameter();
                parID = new SqlParameter("@paramCallCenterID", SqlDbType.Int);
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
                _cmm.CommandText = "xParamCallCenterDelete";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@paramCallCenterID", _id));
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

        public static Result.Default checkrange(int _id, int _callcenterid, DateTime _dtinizio, DateTime? _dtfine)
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
                _cmm.CommandText = "xParamCallCenterCheckRange";
                _cmm.Connection = _cnn;
                _cmm.CommandType = CommandType.StoredProcedure;

                _cmm.Parameters.Add(new SqlParameter("@paramCallCenterID", _id));
                _cmm.Parameters.Add(new SqlParameter("@CallCenterID", _callcenterid));
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