using Microsoft.AspNetCore.Mvc;
using BanHoaChat.Areas.admins.Controllers;

namespace BanHoaChat.Areas.admins.Controllers
{
    
    public class DashboardController : BaseController
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
