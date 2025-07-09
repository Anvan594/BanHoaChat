using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BanHoaChat.Models;

public partial class Review
{
    [Display(Name = "Mã")]
    public int ReviewId { get; set; }
    [Display(Name = "Mã Người dùng")]
    public int? UserId { get; set; }
    [Display(Name = "Mã Sản phẩm")]
    public int? ProductId { get; set; }
    [Display(Name = "Điểm đánh giá")]
    public int? Rating { get; set; }
    [Display(Name = "Bình luận")]
    public string? Comment { get; set; }
    [Display(Name = "Ngày tạo")]
    public DateTime? CreatedAt { get; set; }

    public virtual Product? Product { get; set; }

    public virtual User? User { get; set; }
}
