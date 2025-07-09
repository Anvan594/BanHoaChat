using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BanHoaChat.Models;

public partial class User
{
    [Display(Name = "Mã Người Dùng")]
    public int UserId { get; set; }
    [Display(Name = "Tên Người Dùng")]
    public string Username { get; set; } = null!;
    [Display(Name = "Mật Khẩu")]
    public string Password { get; set; } = null!;
    [Display(Name = "Email ")]
    public string Email { get; set; } = null!;
    [Display(Name = "Tên Người Dùng")]
    public string? FullName { get; set; }
    [Display(Name = "Số Điện Thoại")]
    public string? Phone { get; set; }
    [Display(Name = "Địa Chỉ")]
    public string? Address { get; set; }
    [Display(Name = "Vai Trò ")]
    public string? Role { get; set; }
    [Display(Name = "Ngày Tạo")]
    public DateTime? CreatedAt { get; set; }
    [Display(Name = "Ngày Cập Nhật")]
    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Cart> Carts { get; set; } = new List<Cart>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();
}
