using Azure.Identity;
using BanHoaChat.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;

namespace BanHoaChat.Controllers
{
    public class CartController : Controller
    {
        private readonly BanHoaChatDbv3Context _context;

        public CartController(BanHoaChatDbv3Context context)
        {
            _context = context;
        }
        private readonly Random _random = new Random();

        public IActionResult Index()
        {
            return View();
        }

        // AJAX gọi để load giỏ hàng từ email
        [HttpPost]
        public IActionResult LoadCartByEmail(string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                return Content("<div class='alert alert-danger'>Email không hợp lệ.</div>");
            }

            var user = _context.Users.FirstOrDefault(u => u.Email == email);
            if (user == null)
            {
                return Content("<div class='alert alert-warning'>Không tìm thấy người dùng.</div>");
            }

            var cart = _context.Carts
                .Include(c => c.CartItems)
                .ThenInclude(ci => ci.Product)
                .FirstOrDefault(c => c.UserId == user.UserId);

            var items = cart?.CartItems ?? new List<CartItem>();

            return PartialView("_CartPartial", items);
        }
        [HttpPost]
        public IActionResult AddToCart(int productId, int quantity, string email)
        {
            try
            {
                // Tìm UserId theo email
                int userId = _context.Users
                    .Where(u => u.Email == email)
                    .Select(u => u.UserId)
                    .FirstOrDefault();

                // Nếu chưa có user, thì tạo mới
                if (userId == 0)
                {
                    string datePart = DateTime.Now.ToString("ddMMyy");
                    int randomNumber = _random.Next(1000, 9999);
                    var username = "Khách_"+datePart + randomNumber;
                    var userNew = new User
                    {
                        Username = username,
                        Password = "1",
                        Role = "Customer",
                        Email = email
                    };
                    _context.Users.Add(userNew);
                    try
                    {
                        _context.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        var inner = ex.InnerException?.Message ?? ex.Message;
                        Console.WriteLine("Lỗi khi thêm user: " + inner);
                        return Json(new { success = false, message = inner });
                    }

                    // Cập nhật lại userId sau khi thêm mới
                    userId = userNew.UserId;
                }

                // Tìm hoặc tạo giỏ hàng
                var cart = _context.Carts
                    .Include(c => c.CartItems)
                    .FirstOrDefault(c => c.UserId == userId);

                if (cart == null)
                {
                    cart = new Cart
                    {
                        UserId = userId,
                        CreatedAt = DateTime.Now,
                        CartItems = new List<CartItem>()
                    };
                    _context.Carts.Add(cart);
                    _context.SaveChanges();
                }

                // Kiểm tra sản phẩm đã có trong giỏ chưa
                var existingItem = cart.CartItems.FirstOrDefault(ci => ci.ProductId == productId);

                if (existingItem != null)
                {
                    existingItem.Quantity += quantity;
                }
                else
                {
                    var newItem = new CartItem
                    {
                        CartId = cart.CartId,
                        ProductId = productId,
                        Quantity = quantity
                    };
                    _context.CartItems.Add(newItem);
                }

                _context.SaveChanges();

                // Tổng số lượng sản phẩm trong giỏ
                var cartCount = _context.CartItems
                    .Where(ci => ci.CartId == cart.CartId)
                    .Sum(ci => ci.Quantity);

                return Json(new { success = true, cartCount = cartCount });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
        [HttpPost]
        public IActionResult UpdateQuantity(int cartItemId, int change)
        {
            var item = _context.CartItems.FirstOrDefault(ci => ci.CartItemId == cartItemId);
            if (item != null)
            {
                item.Quantity += change;
                if (item.Quantity < 1)
                {
                    _context.CartItems.Remove(item);
                }
                _context.SaveChanges();
            }
            return Ok();
        }
        [HttpPost]
        public IActionResult RemoveItem(int cartItemId)
        {
            var item = _context.CartItems.FirstOrDefault(ci => ci.CartItemId == cartItemId);
            if (item != null)
            {
                _context.CartItems.Remove(item);
                _context.SaveChanges();
            }
            return Ok();
        }
        [HttpGet]
        public IActionResult GetCartCount(string email)
        {
            if (string.IsNullOrEmpty(email))
                return Json(new { count = 0 });

            var user = _context.Users.FirstOrDefault(u => u.Email == email);
            if (user == null)
                return Json(new { count = 0 });

            var cart = _context.Carts
                .Include(c => c.CartItems)
                .FirstOrDefault(c => c.UserId == user.UserId);

            int count = cart?.CartItems.Count() ?? 0;

            return Json(new { count = count });
        }

    }
}
