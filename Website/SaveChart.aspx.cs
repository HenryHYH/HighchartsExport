using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Drawing.Imaging;
using Svg;
using iTextSharp.text.pdf;
using iTextSharp.text;

namespace highchart_export_module_asp_net
{
    public partial class SaveChart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tSvg = Request["svg"];
                string fileName = Request["unitId"];
                MemoryStream tData = new MemoryStream(Encoding.UTF8.GetBytes(tSvg));
                Svg.SvgDocument tSvgObj = SvgDocument.Open(tData);
                tSvgObj.Draw().Save("e:\\" + fileName + ".png", ImageFormat.Png);
            }
        }
    }
}