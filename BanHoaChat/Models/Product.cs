using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BanHoaChat.Models;

public partial class Product
{
    public int ProductId { get; set; }
    [Display(Name = "Tên Sản Phẩm")]
    public string Name { get; set; } = null!;
    [Display(Name = "Mô Tả")]
    public string? Description { get; set; }
    [Display(Name = "Giá")]
    public decimal Price { get; set; }
    [Display(Name = "Số Lượng")]
    public int? StockQuantity { get; set; }
    [Display(Name = "Danh Mục")]
    public int? CategoryId { get; set; }
    [Display(Name = "Ảnh")]
    public string? ImageUrl { get; set; }
    [Display(Name = "Ngày Tạo")]
    public DateTime? CreatedAt { get; set; }
    [Display(Name = "Ngày Cập Nhật")]
    public DateTime? UpdatedAt { get; set; }
    public bool? Status { get; set; } = true;
    public bool? StatusPrice { get; set; } = true;
    [Display(Name = "Lượt Xem")]
    public int ViewCount { get; set; } = 0;
    public virtual ICollection<CartItem> CartItems { get; set; } = new List<CartItem>();
    [Display(Name = "Danh Mục")]
    public virtual Category? Category { get; set; }

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();
}
