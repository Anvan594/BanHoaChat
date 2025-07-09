using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BanHoaChat.Models;

public partial class Category
{
    public int CategoryId { get; set; }
    [Display(Name = "Tên Danh Mục")]
    public string Name { get; set; } = null!;
    [Display(Name = "Mô Tả Danh Mục")]
    public string? Description { get; set; }
    [Display(Name = "Hình Ảnh Danh Mục")]
    public int? ParentId { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
