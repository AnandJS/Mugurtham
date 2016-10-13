using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mugurtham.DTO.Profile
{
    [Table("ProfileHoroscope")]
    public class Horoscope
    {
        public Decimal? Year { get; set; }
        public Decimal? Month { get; set; }
        public Decimal? Day { get; set; }
        [Key]
        public string ProfileID { get; set; }
        public string DasaBalance { get; set; }
        public string Path { get; set; }
        public string ModifiedBy { get; set; }
    }
}
