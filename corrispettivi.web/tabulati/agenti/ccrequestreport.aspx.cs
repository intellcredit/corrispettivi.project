using System;
using Telerik.Web.UI;

namespace corrispettivi.web.tabulati.agenti
{
    public partial class ccrequestreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAccoda_Click(object sender, EventArgs e)
        {
            try
            {
                sdsInfo.Insert();

                cmbCallCenter.ClearSelection();
                cmbPeriodoRif.ClearSelection();
                txtMailTo.Text = "";
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                GridDataItem item = (e.Item as GridDataItem);
                if (IsDate(item.Cells[7].Text))
                    e.Item.Cells[1].FindControl("btnDelete").Visible = false;
            }
        }

        protected void gvInfo_ItemCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Delete")
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    int id = Convert.ToInt32(item.GetDataKeyValue("CallCenterRequestReportID"));
                    sdsInfo.DeleteCommand = string.Format("delete from CallCenterRequestReport where CallCenterRequestReportID = {0} ", id);
                    sdsInfo.Delete();
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        public static bool IsDate(Object obj)
        {
            string strDate = obj.ToString();
            try
            {
                DateTime dt = DateTime.Parse(strDate);
                if ((dt.Month != System.DateTime.Now.Month) || (dt.Day < 1 && dt.Day > 31) || dt.Year != System.DateTime.Now.Year)
                    return false;
                else
                    return true;
            }
            catch
            {
                return false;
            }
        }
    }
}