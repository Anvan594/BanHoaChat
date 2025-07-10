using BanHoaChat.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace BanHoaChat.Controllers
{
    public class ShopController : Controller
    {
        private readonly BanHoaChatDbv3Context _context;

        public ShopController(BanHoaChatDbv3Context context)
        {
            _context = context;
        }

        // GET: Shop
        public async Task<IActionResult> Index(
       string searchString,
       int? categoryId,
       string priceRange,
       string sortOrder,
        int page = 1, // Thêm tham số trang
        int pageSize = 6)
        {
            // Lấy danh sách danh mục cho filter
            ViewBag.Categories = await _context.Categories.ToListAsync();

            // Query sản phẩm
            var query = _context.Products
                .Include(p => p.Category)
                .Where(p => p.Status == true);

            // Lọc theo tìm kiếm
            if (!string.IsNullOrEmpty(searchString))
            {
                query = query.Where(p => p.Name.Contains(searchString)
                                    || p.Description.Contains(searchString));
            }

            // Lọc theo danh mục
            if (categoryId.HasValue)
            {
                query = query.Where(p => p.CategoryId == categoryId);
            }

            // Lọc theo khoảng giá
            if (!string.IsNullOrEmpty(priceRange))
            {
                switch (priceRange)
                {
                    case "under100":
                        query = query.Where(p => p.Price < 100000);
                        break;
                    case "100to500":
                        query = query.Where(p => p.Price >= 100000 && p.Price <= 500000);
                        break;
                    case "500to1000":
                        query = query.Where(p => p.Price > 500000 && p.Price <= 1000000);
                        break;
                    case "over1000":
                        query = query.Where(p => p.Price > 1000000);
                        break;
                }
            }

            // Sắp xếp
            switch (sortOrder)
            {
                case "price_asc":
                    query = query.OrderBy(p => p.Price);
                    break;
                case "price_desc":
                    query = query.OrderByDescending(p => p.Price);
                    break;
                case "popular":
                    query = query.OrderByDescending(p => p.ViewCount);
                    break;
                default:
                    query = query.OrderBy(p => p.ProductId);
                    break;
            }

            var totalItems = await query.CountAsync();
            var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            // Lấy dữ liệu cho trang hiện tại
            var products = await query
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            // Truyền dữ liệu phân trang sang View
            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = totalPages;
            ViewBag.PageSize = pageSize;
            ViewBag.TotalItems = totalItems;
            return View(products);
        }

        // GET: Shop/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(p => p.Category)
                .FirstOrDefaultAsync(m => m.ProductId == id);

            if (product == null)
            {
                return NotFound();
            }

            // Tăng lượt xem
            product.ViewCount++;
            _context.Update(product);
            await _context.SaveChangesAsync();

            return View(product);
        }
    }
}