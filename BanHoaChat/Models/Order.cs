using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BanHoaChat.Models;

public partial class Order
{
    [Display(Name = "Mã Đơn Hàng")]
    public int OrderId { get; set; }
    [Display(Name = "Mã Người Dùng")]
    public int? UserId { get; set; }
    [Display(Name = "Tổng Giá Trị")]
    public decimal TotalAmount { get; set; }
    [Display(Name = "Trạng Thái")]
    public string? Status { get; set; }
    [Display(Name = "Địa Chỉ Giao Hàng")]
    public string? ShippingAddress { get; set; }
    [Display(Name = "Ngày Tạo")]
    public DateTime? CreatedAt { get; set; }
    [Display(Name = "Ngày Cập Nhật")]
    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual User? User { get; set; }
}
