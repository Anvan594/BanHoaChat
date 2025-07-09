using System.ComponentModel.DataAnnotations;

namespace BanHoaChat.Areas.admins.Models
{
    public class Login
    {

        [Required(ErrorMessage = "Vui lòng nhập tên đăng nhập")]
        public string TenDangNhap { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mật khẩu")]
        [DataType(DataType.Password)]
        public string MatKhau { get; set; }
        [Display(Name = "Ghi nhớ đăng nhập?")]
        public bool RememberMe { get; set; }
    }


}
