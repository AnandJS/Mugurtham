using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Repository.Profile.Horoscope
{
    public interface IHoroscope : IRepository<Mugurtham.DTO.Profile.Horoscope>
    {
        IQueryable<Mugurtham.DTO.Profile.Horoscope> GetByProfileID(string ProfileID);
    }
}
