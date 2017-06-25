using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mugurtham.Service.Controllers;
using Mugurtham.Common.Utilities;
using Mugurtham.Core.Profile.Photo;
using System.Web.Helpers;

namespace Mugurtham.Service.Areas.Profile.Controllers.MVC
{
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                 Mugurtham.Core.Constants.RoleIDForUserProfile,
                                 Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class ProfileController : MugurthamBaseController
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult BasicInfo()
        {
            return View();
        }
        public ActionResult Career()
        {
            return View();
        }
        public ActionResult Contact()
        {
            return View();
        }
        public ActionResult Family()
        {
            return View();
        }
        public ActionResult Location()
        {
            return View();
        }
        public ActionResult Reference()
        {
            return View();
        }
        public ActionResult Horoscope()
        {
            return View();
        }
        public ActionResult Photo()
        {
            return View();
        }
        public ActionResult Album()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SaveProfilePhoto(HttpPostedFileBase file, string ProfileID)
        {
            if (file != null && file.ContentLength > 0)
                try
                {
                    Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
                    Mugurtham.Core.BasicInfo.BasicInfoCore objBasicInfoCore = new Core.BasicInfo.BasicInfoCore(ref objLoggedIn);
                    using (objBasicInfoCore as IDisposable)
                    {
                        Mugurtham.Core.BasicInfo.BasicInfoCoreEntity objBasicInfoCoreEntity = new Core.BasicInfo.BasicInfoCoreEntity();
                        using (objBasicInfoCoreEntity as IDisposable)
                        {

                            objBasicInfoCoreEntity = objBasicInfoCore.GetByProfileID(ProfileID);
                            objBasicInfoCoreEntity.PhotoPath = "/Areas/Profile/Images/ProfilePhoto/" + objLoggedIn.CommunityName + "/" + ProfileID + Path.GetExtension(Path.GetFileName(file.FileName));
                            string strFilePath = Path.Combine(Server.MapPath("~/Areas/Profile/Images/ProfilePhoto"),
                                              ProfileID + Path.GetExtension(Path.GetFileName(file.FileName)));
                            file.SaveAs(strFilePath);
                            addTextWatermark(strFilePath);
                            objBasicInfoCore.Edit(ref objBasicInfoCoreEntity);
                        }
                        objBasicInfoCoreEntity = null;
                    }
                    objBasicInfoCore = null;
                }
                catch (Exception ex)
                {
                    ViewBag.Message = "ERROR:" + ex.Message.ToString();
                }
            else
            {
                ViewBag.Message = "You have not specified a file.";
            }
            return Redirect("/Matrimony#/Photo");
        }
        [HttpPost]
        public ActionResult Add([System.Web.Http.FromBody]Mugurtham.Core.BasicInfo.BasicInfoCoreEntity objBasicInfoCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            string strProfileID = string.Empty;
            Mugurtham.Core.Profile.API.ProfileCore objProfileCore = new Mugurtham.Core.Profile.API.ProfileCore(ref objLoggedIn);
            using (objProfileCore as IDisposable)
            {
                objProfileCore.Add(ref objBasicInfoCoreEntity, out strProfileID, objLoggedIn);
            }
            objProfileCore = null;
            return this.Json(strProfileID, JsonRequestBehavior.AllowGet);

        }
        [HttpPost]
        public ActionResult SaveProfilePhotoAlbum(List<HttpPostedFileBase> file, string ProfileID)
        {
            try
            {
                string strFileName = string.Empty;
                string strProfilePhotoPath = string.Empty;
                int intProfilePhotoIndex = 1;
                // Create if profile directory does not exsist
                Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
                string strProfileFolderPath = Path.Combine(Server.MapPath("~/Areas/Profile/Images/ProfilePhoto/" + objLoggedIn.CommunityName.Trim() + "/" + ProfileID));
                if (!Directory.Exists(strProfileFolderPath))
                    Directory.CreateDirectory(strProfileFolderPath);
                foreach (HttpPostedFileBase item in file)
                {
                    if (item != null)
                    {
                        strFileName = Helpers.primaryKey;
                        strProfilePhotoPath = "/Areas/Profile/Images/ProfilePhoto/" + objLoggedIn.CommunityName + "/" + ProfileID + "/" + strFileName + Path.GetExtension(Path.GetFileName(item.FileName));
                    }
                    //if (Array.Exists(model.FilesToBeUploaded.Split(','), s => s.Equals(item.FileName)))                
                    if (
                        Path.GetExtension(Path.GetFileName(item.FileName)).ToString().ToLower() == ".jpg".ToString().ToLower() ||
                        Path.GetExtension(Path.GetFileName(item.FileName)).ToString().ToLower() == ".jpeg".ToString().ToLower() ||
                        Path.GetExtension(Path.GetFileName(item.FileName)).ToString().ToLower() == ".gif".ToString().ToLower() ||
                        Path.GetExtension(Path.GetFileName(item.FileName)).ToString().ToLower() == ".png".ToString().ToLower()
                        )
                    {
                        try
                        {
                            Mugurtham.Core.BasicInfo.BasicInfoCore objBasicInfoCore = new Core.BasicInfo.BasicInfoCore(ref objLoggedIn);
                            using (objBasicInfoCore as IDisposable)
                            {
                                Mugurtham.Core.BasicInfo.BasicInfoCoreEntity objBasicInfoCoreEntity = new Core.BasicInfo.BasicInfoCoreEntity();
                                using (objBasicInfoCoreEntity as IDisposable)
                                {
                                    objBasicInfoCoreEntity = objBasicInfoCore.GetByProfileID(ProfileID);
                                    objBasicInfoCoreEntity.PhotoPath = strProfilePhotoPath;
                                    string strFilePath = Path.Combine(Server.MapPath("~/Areas/Profile/Images/ProfilePhoto/" + objLoggedIn.CommunityName.Trim() + "/" + ProfileID.Trim()),
                                                      strFileName + Path.GetExtension(Path.GetFileName(item.FileName)));
                                    item.SaveAs(strFilePath);
                                    addTextWatermark(strFilePath);
                                    savePhotoToFolder(strProfilePhotoPath, ProfileID);
                                    if (intProfilePhotoIndex == 1)
                                        objBasicInfoCore.Edit(ref objBasicInfoCoreEntity);
                                }
                                objBasicInfoCoreEntity = null;
                            }
                            objBasicInfoCore = null;
                        }
                        catch (Exception ex)
                        {
                            ViewBag.Message = "ERROR:" + ex.Message.ToString();
                        }
                    }
                    intProfilePhotoIndex += 1;
                }
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return Redirect("/Matrimony#/Photo");
        }
        private int savePhotoToFolder(string strPhotoPath, string strProfileID)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            Mugurtham.Core.Profile.Photo.PhotoCore objPhotoCore = new Core.Profile.Photo.PhotoCore(ref objLoggedIn);
            using (objPhotoCore as IDisposable)
            {
                Mugurtham.Core.Profile.Photo.PhotoCoreEntity objPhotoCoreEntity = new Core.Profile.Photo.PhotoCoreEntity();
                using (objPhotoCoreEntity as IDisposable)
                {
                    objPhotoCoreEntity.IsProfilePic = 0;
                    objPhotoCoreEntity.PhotoPath = strPhotoPath;
                    objPhotoCoreEntity.ProfileID = strProfileID;
                    objPhotoCore.Add(ref objPhotoCoreEntity);
                }
                objPhotoCoreEntity = null;
            }
            objPhotoCore = null;
            return 0;
        }
        public ActionResult RemoveProfilePic(string ID)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            string strUserID = string.Empty;
            PhotoCore objPhotoCore = new PhotoCore(ref objLoggedIn);
            using (objPhotoCore as IDisposable)
                objPhotoCore.Delete(ID);
            objPhotoCore = null;
            return this.Json("Success", JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult SaveHoroscopeImage(HttpPostedFileBase file, string ProfileID)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            if (file != null && file.ContentLength > 0)
                try
                {
                    string strProfileHoroFolderPath = Path.Combine(Server.MapPath("~/Areas/Profile/Images/ProfilePhoto/" + objLoggedIn.CommunityName + "/" + ProfileID + "/Horoscope"));

                    if (!Directory.Exists(strProfileHoroFolderPath))
                        Directory.CreateDirectory(strProfileHoroFolderPath);

                    System.IO.DirectoryInfo objDirectoryInfo = new DirectoryInfo(strProfileHoroFolderPath);

                    foreach (FileInfo objFile in objDirectoryInfo.GetFiles())
                    {
                        objFile.Delete();
                    }
                    foreach (DirectoryInfo objDir in objDirectoryInfo.GetDirectories())
                    {
                        objDir.Delete(true);
                    }
                    string path = Path.Combine(Server.MapPath("~/Areas/Profile/Images/ProfilePhoto/" + objLoggedIn.CommunityName + "/" + ProfileID + "/Horoscope/" + ProfileID + Path.GetExtension(Path.GetFileName(file.FileName))));
                    string strProfileHoroPath = "/Areas/Profile/Images/ProfilePhoto/" + objLoggedIn.CommunityName + "/" + ProfileID + "/Horoscope/" + ProfileID + Path.GetExtension(Path.GetFileName(file.FileName));
                    if (
                    Path.GetExtension(Path.GetFileName(file.FileName)).ToString().ToLower() == ".jpg".ToString().ToLower() ||
                    Path.GetExtension(Path.GetFileName(file.FileName)).ToString().ToLower() == ".jpeg".ToString().ToLower() ||
                    Path.GetExtension(Path.GetFileName(file.FileName)).ToString().ToLower() == ".gif".ToString().ToLower() ||
                    Path.GetExtension(Path.GetFileName(file.FileName)).ToString().ToLower() == ".png".ToString().ToLower()
                    )
                    {
                        file.SaveAs(path);
                        addTextWatermark(path);
                        Mugurtham.Core.Profile.Horoscope.HoroscopeCore objHoroscopeCore = new Core.Profile.Horoscope.HoroscopeCore(ref objLoggedIn);
                        using (objHoroscopeCore as IDisposable)
                        {
                            Mugurtham.Core.Profile.Horoscope.HoroscopeCoreEntity objHoroscopeCoreEntity = new Core.Profile.Horoscope.HoroscopeCoreEntity();
                            using (objHoroscopeCoreEntity as IDisposable)
                            {
                                objHoroscopeCoreEntity = objHoroscopeCore.GetByProfileID(ProfileID, objLoggedIn.LoginID);
                                objHoroscopeCoreEntity.Path = strProfileHoroPath;
                                if (!string.IsNullOrEmpty(strProfileHoroPath))
                                    objHoroscopeCore.updateHoroscope(ref objHoroscopeCoreEntity);
                            }
                            objHoroscopeCoreEntity = null;
                        }
                        objHoroscopeCore = null;
                    }
                }
                catch (Exception ex)
                {
                    ViewBag.Message = "ERROR:" + ex.Message.ToString();
                }
            else
            {
                ViewBag.Message = "You have not specified a file.";
            }
            return Redirect("/Matrimony#/Horoscope");
        }

        private int addTextWatermark(string ImagePath)
        {
            try
            {
                WebImage objWaqtermarkImage = new WebImage(ImagePath);
                objWaqtermarkImage.AddTextWatermark("© Mugurtham", "White", 60, "Regular", "Consolas", "Right", "Bottom", 70, 5);
                objWaqtermarkImage.Save(ImagePath);
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

    }
}