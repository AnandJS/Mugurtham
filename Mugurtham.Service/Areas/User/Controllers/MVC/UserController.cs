using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mugurtham.Core.ProfileViewed;
using Mugurtham.Core.ProfileInterested;
using Mugurtham.Core.Profile.API;



namespace Mugurtham.Service.Areas.User.Controllers.MVC
{
    public class UserController : Controller
    {
        //
        // GET: /User/User/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List()
        {
            return View();
        }
        public ActionResult Form()
        {
            return View();
        }
        public ActionResult UserSettingsForm()
        {
            return View();
        }
        public ActionResult RecentlyJoined()
        {
            return View();
        }
        public ActionResult HighlightedProfiles()
        {
            return View();
        }
        public ActionResult ViewedProfiles()
        {
            return View();
        }
        public ActionResult InterestedProfiles()
        {
            return View();
        }
        public ActionResult InterestedInMeProfiles()
        {
            return View();
        }
        public ActionResult Add(string ID)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            string strUserID = string.Empty;
            ProfileViewedCore objProfileViewedCore = new ProfileViewedCore();
            using (objProfileViewedCore as IDisposable)
            {
                ProfileViewedCoreEntity objProfileViewedCoreEntity = new ProfileViewedCoreEntity();
                using (objProfileViewedCoreEntity as IDisposable)
                {
                    objProfileViewedCoreEntity.ViewerID = objLoggedIn.LoginID;
                    objProfileViewedCoreEntity.ViewedID = ID;
                    objProfileViewedCore.Add(ref objProfileViewedCoreEntity);
                }
                objProfileViewedCoreEntity = null;
            }
            objProfileViewedCore = null;
            return this.Json("Success", JsonRequestBehavior.AllowGet);
        }
        public ActionResult ShowInterest(string ID)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            string strUserID = string.Empty;
            ProfileInterestedCore objProfileInterestedCore = new ProfileInterestedCore();
            using (objProfileInterestedCore as IDisposable)
            {
                ProfileInterestedCoreEntity objProfileInterestedCoreEntity = new ProfileInterestedCoreEntity();
                using (objProfileInterestedCoreEntity as IDisposable)
                {
                    objProfileInterestedCoreEntity.ViewerID = objLoggedIn.LoginID;
                    objProfileInterestedCoreEntity.InterestedInID = ID;
                    objProfileInterestedCore.Add(ref objProfileInterestedCoreEntity);
                }
                objProfileInterestedCoreEntity = null;
            }
            objProfileInterestedCore = null;
            return this.Json("Success", JsonRequestBehavior.AllowGet);
        }
        public ActionResult RemoveInterest(string ID)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            string strUserID = string.Empty;
            ProfileInterestedCore objProfileInterestedCore = new ProfileInterestedCore();
            using (objProfileInterestedCore as IDisposable)
            {
                ProfileInterestedCoreEntity objProfileInterestedCoreEntity = new ProfileInterestedCoreEntity();
                using (objProfileInterestedCoreEntity as IDisposable)
                    objProfileInterestedCore.Delete(objLoggedIn.LoginID, ID);
                objProfileInterestedCoreEntity = null;
            }
            objProfileInterestedCore = null;
            return this.Json("Success", JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult getInterestedProfiles()
        {
            string strGender = "admin"; // Mugurtham admin, Sangam admin, public user
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            if (objLoggedIn.roleID == "F62DDFBE55448E3A3") // User Profiles 
            {
                if (!string.IsNullOrWhiteSpace(objLoggedIn.BasicInfoCoreEntity.Gender))
                {
                    if (objLoggedIn.BasicInfoCoreEntity.Gender.ToLower().Trim() == "male".ToLower().Trim())
                        strGender = "female";
                    else
                        strGender = "male";
                }
            }
            List<ProfileCore> objProfileCoreList = new List<ProfileCore>();
            ProfileInterestedCore objProfileInterestedCore = new ProfileInterestedCore();
            using (objProfileInterestedCore as IDisposable)
                objProfileInterestedCore.GetInterestedProfiles(ref objProfileCoreList, strGender, objLoggedIn.LoginID, objLoggedIn.sangamID);
            objProfileInterestedCore = null;
            return this.Json(objProfileCoreList, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult getInterestedInMeProfiles()
        {
            string strGender = "admin"; // Mugurtham admin, Sangam admin, public user
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            if (objLoggedIn.roleID == "F62DDFBE55448E3A3") // User Profiles 
            {
                if (!string.IsNullOrWhiteSpace(objLoggedIn.BasicInfoCoreEntity.Gender))
                {
                    if (objLoggedIn.BasicInfoCoreEntity.Gender.ToLower().Trim() == "male".ToLower().Trim())
                        strGender = "female";
                    else
                        strGender = "male";
                }
            }
            List<ProfileCore> objProfileCoreList = new List<ProfileCore>();
            ProfileInterestedCore objProfileInterestedCore = new ProfileInterestedCore();
            using (objProfileInterestedCore as IDisposable)
                objProfileInterestedCore.GetInterestedInMeProfiles(ref objProfileCoreList, strGender, objLoggedIn.LoginID, objLoggedIn.sangamID);
            objProfileInterestedCore = null;
            return this.Json(objProfileCoreList, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult getUserBadgeCount()
        {
            string strGender = "admin"; // Mugurtham admin, Sangam admin, public user
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            if (objLoggedIn.roleID == "F62DDFBE55448E3A3") // User Profiles 
            {
                if (!string.IsNullOrWhiteSpace(objLoggedIn.BasicInfoCoreEntity.Gender))
                {
                    if (objLoggedIn.BasicInfoCoreEntity.Gender.ToLower().Trim() == "male".ToLower().Trim())
                        strGender = "female";
                    else
                        strGender = "male";
                }
            }
            UserBadgeCount objUserBadgeCount = new UserBadgeCount();
            objUserBadgeCount.InterestedInMeProfiles = 0;
            objUserBadgeCount.InterestedProfiles = 0;
            objUserBadgeCount.ViewedProfiles = 0;
            objUserBadgeCount.HighlightedProfiles = 0;
            objUserBadgeCount.RecentlyJoined = 0;
            List<ProfileCore> objProfileCoreList = new List<ProfileCore>();
            ProfileInterestedCore objProfileInterestedCore = new ProfileInterestedCore();
            using (objProfileInterestedCore as IDisposable)
                objProfileInterestedCore.GetInterestedInMeProfiles(ref objProfileCoreList, strGender, objLoggedIn.LoginID, objLoggedIn.sangamID);
            if (objProfileCoreList != null)
                objUserBadgeCount.InterestedInMeProfiles = objProfileCoreList.Count;
            objProfileCoreList = null;
            List<ProfileCore> objIntProfProfileCoreList = new List<ProfileCore>();
            objProfileInterestedCore.GetInterestedProfiles(ref objIntProfProfileCoreList, strGender, objLoggedIn.LoginID, objLoggedIn.sangamID);
            objProfileInterestedCore = null;
            if (objIntProfProfileCoreList != null)
                objUserBadgeCount.InterestedProfiles = objIntProfProfileCoreList.Count;
            objIntProfProfileCoreList = null;
            ProfileCore objProfileCore = new ProfileCore();
            using (objProfileCore as IDisposable)
            {
                List<ProfileCore> objViewedProfileCoreList = new List<ProfileCore>();
                objProfileCore.GetViewedProfiles(ref objViewedProfileCoreList, strGender, objLoggedIn.LoginID, objLoggedIn.sangamID);
                if (objViewedProfileCoreList != null)
                    objUserBadgeCount.ViewedProfiles = objViewedProfileCoreList.Count;
                objViewedProfileCoreList = null;
                List<ProfileCore> objHighlightedProfileCoreList = new List<ProfileCore>();
                objProfileCore.GetHighlightedProfiles(ref objHighlightedProfileCoreList, strGender, objLoggedIn.sangamID);
                if (objHighlightedProfileCoreList != null)
                    objUserBadgeCount.HighlightedProfiles = objHighlightedProfileCoreList.Count;
                objHighlightedProfileCoreList = null;
                List<ProfileCore> objRecentlyProfileCoreList = new List<ProfileCore>();
                objProfileCore.GetRecentlyJoined(ref objRecentlyProfileCoreList, strGender, objLoggedIn.sangamID);
                if (objRecentlyProfileCoreList != null)
                    objUserBadgeCount.RecentlyJoined = objRecentlyProfileCoreList.Count;
                objRecentlyProfileCoreList = null;
            }
            objProfileCore = null;
            return this.Json(objUserBadgeCount, JsonRequestBehavior.AllowGet);
        }
    }

    public class UserBadgeCount
    {
        public int InterestedInMeProfiles { get; set; }
        public int InterestedProfiles { get; set; }
        public int ViewedProfiles { get; set; }
        public int HighlightedProfiles { get; set; }
        public int RecentlyJoined { get; set; }
    }
}
