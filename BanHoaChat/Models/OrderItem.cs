using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BanHoaChat.Models;

public partial class OrderItem
{
    [Display(Name = "Mã CT Đơn")]
    public int OrderItemId { get; set; }
    [Display(Name = "Mã Đơn")]
    public int? OrderId { get; set; }
    [Display(Name = "Mã SP")]
    public int? ProductId { get; set; }
    [Display(Name = "Số lượng")]
    public int Quantity { get; set; }
    [Display(Name = "Đơn giá")]
    public decimal UnitPrice { get; set; }

    public virtual Order? Order { get; set; }

    public virtual Product? Product { get; set; }
}
