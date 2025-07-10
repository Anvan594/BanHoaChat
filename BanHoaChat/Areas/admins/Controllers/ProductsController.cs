using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using BanHoaChat.Models;
using System.IO;

namespace BanHoaChat.Areas.admins.Controllers
{
    public class ProductsController : BaseController
    {
        private readonly BanHoaChatDbv3Context _context;
        private readonly IWebHostEnvironment _environment;

        public ProductsController(BanHoaChatDbv3Context context, IWebHostEnvironment environment)
        {
            _context = context;
            _environment = environment;
        }

        // GET: admins/Products
        public async Task<IActionResult> Index()
        {
            var banHoaChatDbv3Context = _context.Products.Include(p => p.Category);
            return View(await banHoaChatDbv3Context.ToListAsync());
        }

        // GET: admins/Products/Details/5
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

            return View(product);
        }

        // GET: admins/Products/Create
        public IActionResult Create()
        {
            ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "Name");
            return View();
        }

        // POST: admins/Products/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Name,Description,Price,StockQuantity,CategoryId")] Product product, IFormFile ImageFile)
        {
            // Bỏ qua validation cho ImageUrl nếu không có ảnh
            ModelState.Remove("ImageUrl");

            if (ModelState.IsValid)
            {
                if (ImageFile != null && ImageFile.Length > 0)
                {
                    // Kiểm tra định dạng tệp
                    var allowedExtensions = new[] { ".jpg", ".jpeg", ".png", ".gif" };
                    var extension = Path.GetExtension(ImageFile.FileName).ToLowerInvariant();
                    if (!allowedExtensions.Contains(extension))
                    {
                        ModelState.AddModelError("ImageFile", "Chỉ cho phép các tệp .jpg, .jpeg, .png và .gif.");
                        ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "Name", product.CategoryId);
                        return View(product);
                    }

                    // Đảm bảo thư mục Images/products tồn tại
                    string imagesFolder = Path.Combine(_environment.WebRootPath, "Images", "products");
                    if (!Directory.Exists(imagesFolder))
                    {
                        Directory.CreateDirectory(imagesFolder);
                    }

                    // Tạo tên tệp duy nhất
                    string uniqueFileName = Guid.NewGuid().ToString() + extension;
                    string filePath = Path.Combine(imagesFolder, uniqueFileName);

                    // Lưu tệp
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await ImageFile.CopyToAsync(stream);
                    }

                    // Gán ImageUrl
                    product.ImageUrl = "/Images/products/" + uniqueFileName;
                }

                // Gán thời gian
                product.CreatedAt = DateTime.Now;
                product.UpdatedAt = DateTime.Now;

                _context.Add(product);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            // Ghi log lỗi ModelState
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage);
            System.Diagnostics.Debug.WriteLine("Lỗi ModelState (Create): " + string.Join(", ", errors));
            ModelState.AddModelError("", "Vui lòng kiểm tra dữ liệu nhập vào: " + string.Join(", ", errors));

            ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "Name", product.CategoryId);
            return View(product);
        }

        // GET: admins/Products/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "Name", product.CategoryId);
            return View(product);
        }

        // POST: admins/Products/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, IFormFile ImageFile)
        {
            if (!ProductExists(id))
            {
                return NotFound();
            }

            // Lấy sản phẩm hiện tại từ database
            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }

            // Cập nhật các trường từ form
            try
            {
                // Chỉ cập nhật các trường cần thiết
                await TryUpdateModelAsync(product, "", p => p.Name, p => p.Description, p => p.Price, p => p.StockQuantity, p => p.CategoryId,p=>p.StatusPrice,p=>p.Status);

                if (ImageFile != null && ImageFile.Length > 0)
                {
                    // Kiểm tra định dạng tệp
                    var allowedExtensions = new[] { ".jpg", ".jpeg", ".png", ".gif" };
                    var extension = Path.GetExtension(ImageFile.FileName).ToLowerInvariant();
                    if (!allowedExtensions.Contains(extension))
                    {
                        ModelState.AddModelError("ImageFile", "Chỉ cho phép các tệp .jpg, .jpeg, .png và .gif.");
                        ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "Name", product.CategoryId);
                        return View(product);
                    }

                    // Đảm bảo thư mục Images/products tồn tại
                    string imagesFolder = Path.Combine(_environment.WebRootPath, "Images", "products");
                    if (!Directory.Exists(imagesFolder))
                    {
                        Directory.CreateDirectory(imagesFolder);
                    }

                    // Tạo tên tệp duy nhất
                    string uniqueFileName = Guid.NewGuid().ToString() + extension;
                    string filePath = Path.Combine(imagesFolder, uniqueFileName);

                    // Lưu tệp mới
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await ImageFile.CopyToAsync(stream);
                    }

                    // Xóa ảnh cũ nếu tồn tại
                    if (!string.IsNullOrEmpty(product.ImageUrl))
                    {
                        string oldImagePath = Path.Combine(_environment.WebRootPath, product.ImageUrl.TrimStart('/'));
                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }

                    // Cập nhật ImageUrl
                    product.ImageUrl = "/Images/products/" + uniqueFileName;
                }

                // Cập nhật thời gian
                product.UpdatedAt = DateTime.Now;

                _context.Update(product);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            catch (Exception ex)
            {
                // Ghi log lỗi và hiển thị trên view
                System.Diagnostics.Debug.WriteLine($"Lỗi khi lưu: {ex.Message}");
                ModelState.AddModelError("", $"Đã xảy ra lỗi khi lưu sản phẩm: {ex.Message}");
                ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "Name", product.CategoryId);
                return View(product);
            }

            // Ghi log lỗi ModelState nếu có
            if (!ModelState.IsValid)
            {
                var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage);
                System.Diagnostics.Debug.WriteLine("Lỗi ModelState (Edit): " + string.Join(", ", errors));
                ModelState.AddModelError("", "Vui lòng kiểm tra dữ liệu nhập vào: " + string.Join(", ", errors));
                ViewData["CategoryId"] = new SelectList(_context.Categories, "CategoryId", "Name", product.CategoryId);
                return View(product);
            }

            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> Delete(int? id)
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

            return View(product);
        }

        // POST: admins/Products/Delete/5
        [HttpPost, ActionName("DeleteConfirmed")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            try
            {
                var product = await _context.Products.FindAsync(id);
                if (product == null)
                {
                    return Json(new { success = false, message = "Không tìm thấy sản phẩm." });
                }

                // Xóa ảnh liên quan nếu tồn tại
                if (!string.IsNullOrEmpty(product.ImageUrl))
                {
                    string imagePath = Path.Combine(_environment.WebRootPath, product.ImageUrl.TrimStart('/'));
                    if (System.IO.File.Exists(imagePath))
                    {
                        System.IO.File.Delete(imagePath);
                    }
                }

                _context.Products.Remove(product);
                await _context.SaveChangesAsync();

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Lỗi khi xóa: {ex.Message}");
                return Json(new { success = false, message = $"Đã xảy ra lỗi khi xóa sản phẩm: {ex.Message}" });
            }
        }

        private bool ProductExists(int id)
        {
            return _context.Products.Any(e => e.ProductId == id);
        }
    }
}