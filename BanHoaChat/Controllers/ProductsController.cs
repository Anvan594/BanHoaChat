using BanHoaChat.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace BanHoaChat.Controllers
{
    [Route("api/Products")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly BanHoaChatDbv3Context _context;
        private readonly ILogger<ProductsController> _logger;

        public ProductsController(ILogger<ProductsController> logger, BanHoaChatDbv3Context context)
        {
            _context = context;
            _logger = logger;
        }

        [HttpGet("TopViewed")]
        public async Task<ActionResult<IEnumerable<object>>> GetTopViewedProducts()
        {
            try
            {
                var products = await _context.Products
                    .Where(p => p.Status == true)
                    .OrderByDescending(p => p.ViewCount)
                    .Take(8)
                    .Select(p => new
                    {
                        p.ProductId,
                        p.Name,
                        p.Price,
                        p.Description,
                        p.ImageUrl
                    })
                    .ToListAsync();
                if (!products.Any())
                {
                    _logger.LogWarning("Không tìm thấy sản phẩm nào thỏa mãn điều kiện");
                    return Ok(new List<object>()); // Trả về danh sách rỗng
                }
                return Ok(products);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi lấy 10 sản phẩm có lượt xem cao nhất");
                return StatusCode(500, new { message = "Lỗi server khi lấy sản phẩm", details = ex.Message });
            }
        }

        [HttpPost("{id}/View")]
        public async Task<IActionResult> IncrementViewCount(int id)
        {
            try
            {
                var product = await _context.Products.FindAsync(id);
                if (product == null || product.Status != true)
                {
                    return NotFound(new { message = "Sản phẩm không tồn tại hoặc không hoạt động" });
                }

                product.ViewCount++;
                await _context.SaveChangesAsync();
                return Ok(new { message = "Đã tăng lượt xem" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Lỗi khi tăng lượt xem sản phẩm {ProductId}", id);
                return StatusCode(500, new { message = "Lỗi server", details = ex.Message });
            }
        }
    }
}