using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace BanHoaChat.Areas.admins.Controllers
{
    [Area("admins")]
    public class BaseController : Controller, IActionFilter
    {
        public override void OnActionExecuted(ActionExecutedContext context)
        {
            if (context.HttpContext.Session.GetString("UserName") == null)
            {
                context.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { Controller = "Login", Action = "Index", Areas = "admins" }));
            }
            base.OnActionExecuted(context);
        }
    }
}