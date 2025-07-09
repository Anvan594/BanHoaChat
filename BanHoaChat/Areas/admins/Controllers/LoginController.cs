using BanHoaChat.Models;
using Microsoft.AspNetCore.Mvc;
using BanHoaChat.Areas.admins.Models;


namespace BanHoaChat.Areas.admins.Controllers
{
    [Area("admins")]
    public class LoginController : Controller
    {
        private readonly BanHoaChatDbv3Context _context;

        public LoginController(BanHoaChatDbv3Context context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login(Login model)
        {
            if (ModelState.IsValid)
            {
                var user = _context.Users.FirstOrDefault(u => u.Email == model.TenDangNhap && u.Password == model.MatKhau);
                if (user != null && user.Role == "Admin")
                {
                    //HttpContext.Session.SetString("UserId", user.Id.ToString());
                    HttpContext.Session.SetString("Email", user.Email);
                    HttpContext.Session.SetString("UserName", user.Username);
                    return RedirectToAction("Index", "Dashboard");
                }
                else
                {
                    ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không đúng.");
                }
            }
            return View("Index", model);


        }
        public IActionResult DangKy()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DangKy(User model)
        {
            if (_context.Users.Any(u => u.Email == model.Email))
            {
                ModelState.AddModelError("Email", "Email đăng nhập đã tồn tại.");
            }
            if (_context.Users.Any(u =>u.Username == model.Username))
            {
                ModelState.AddModelError("UserName", "Tên đăng nhập đã tồn tại.");
            }
            if (ModelState.IsValid)
            {
                var nguoidung = new User()
                {
                    Username = model.Username,
                    Email = model.Email,
                    Password = model.Password,
                    FullName = model.FullName,
                    Phone = model.Phone,
                    Address = model.Address,
                    Role = "Admin",
                    CreatedAt = DateTime.Now
                };
                _context.Users.Add(nguoidung);
                await _context.SaveChangesAsync();
                return RedirectToAction("Index", "Dashboard");
            }

            return View(model);
        }
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Login");
        }

    }
}
