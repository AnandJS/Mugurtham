﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace Mugurtham.Repository.Profile.Raasi
{
    /// <summary>
    /// This class is used for implementaion of the IRaasi interface only
    /// </summary> 
    public class Raasi : GenericRepository<Mugurtham.DTO.Profile.Raasi>, IRaasi
    {
        public Raasi(DbContext objDbContext)
            : base(objDbContext)
        {
        }
        public IQueryable<Mugurtham.DTO.Profile.Raasi> GetByProfileID(string ID)
        {
            return GetAll().Where(p => p.ProfileID == ID);
        }
    }
}
