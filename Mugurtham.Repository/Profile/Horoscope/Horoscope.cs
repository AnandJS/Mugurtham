using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace Mugurtham.Repository.Profile.Horoscope
{
    /// <summary>
    /// This class is used for implementaion of the IRaasi interface only
    /// </summary> 
    public class Horoscope : GenericRepository<Mugurtham.DTO.Profile.Horoscope>, IHoroscope
    {
        public Horoscope(DbContext objDbContext)
            : base(objDbContext)
        {
        }
        public IQueryable<Mugurtham.DTO.Profile.Horoscope> GetByProfileID(string ID)
        {
            return GetAll().Where(p => p.ProfileID == ID);
        }
    }
}
