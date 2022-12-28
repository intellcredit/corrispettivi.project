using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.agenti
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RadGridWrapper.DataSource = new string[] { " " };
        }

        protected void RadGridWrapper_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridHeaderItem)
                e.Item.Visible = false;
        }

        protected void RadGrid_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataTable table = new DataTable();
            table.Columns.Add("ID", typeof(int));
            table.Columns.Add("Number", typeof(int));
            for (int i = 0; i < 5; i++)
                table.Rows.Add(i + 1, DateTime.Now.Millisecond);
            System.Threading.Thread.Sleep(15); //15ms
            (source as RadGrid).DataSource = table;
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            RadGrid radGrid = RadComboBox1.SelectedItem.Text == "All RadGrids" ? RadGridWrapper : (RadGrid)RadGridWrapper.Items[0].FindControl(RadComboBox1.SelectedItem.Text);
            radGrid.MasterTableView.ExportToPdf();
        }
    }
}