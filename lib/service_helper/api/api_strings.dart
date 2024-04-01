class ApiStrings {
  /// Base Url
  static const baseUrl = 'https://green.salarynow.in/salaryadmin/api/';

  /// Auth Api
  static const authLogin = 'Auth/login';
  static const verifyOtp = 'Auth/verifyotp';
  static const registration = 'Auth/register';

  /// Common Api
  static const pinCode = 'Common/allpincode';
  static const employmentType = 'Common/employmenttype';
  static const bankList = 'Common/banklist';
  static const cityList = 'Common/city';
  static const state = 'Common/state';
  static const salaryMode = 'Common/salarymode';
  static const userCommon = 'Common/usercommon/';
  static const ifsc = 'Common/ifsclist/';
  static const notInterested = 'Common/notInterestedReason/';
  static const caroselSlider = 'Common/bannerSlider/';
  static const userReligion = 'Common/usersreligion/';
  static const appStatus = 'Common/appStatus/';
  static const appVersion = 'Common/getVersion/';
  static const getFaq = 'Common/getfaq/';
  static const postFaq = 'Permission/savefaqdata/';
  static const getNotification = 'Permission/getnotification/';
  static const saveCommonId = 'Common/saveCommonId/';
  static const panCardValidate = 'Common/pancardValidate/';
  static const language = 'Common/language/';

  /// User Api
  static const profile = 'User/checkuserdetails/';
  static const bankDetails = 'User/bankdetails/';
  static const updateBankDetails = 'User/updatebank/';
  static const employmentDetails = 'User/employmentdetails/';
  static const updateEmploymentDetails = 'User/updateemployement/';
  static const residentialDetails = 'User/Residencedetails/';
  static const updateResidentialDetails = 'User/updateresidential/';
  static const personalDetails = 'User/personalinfodetails/';
  static const updatePersonalDetails = 'User/updatepersonalinfo/';
  static const reqCallback = 'User/requestCallback/';
  static const deleteReqCallback = 'User/accountDeleteRequest/';
  static const cancelMandate = 'Loan/mandatecancelrequest';

  /// Document Api
  static const document = 'UserDocs/UploadUserDocs/';
  static const getDocument = 'UserDocs/viewUserDocs/';
  static const getDocAddType = 'UserDocs/getAddressDocType/';
  static const getAccomodationType = 'UserDocs/getAccomandationDocType/';
  static const uploadStatementType = 'UserDocs/uploadStatment/';
  static const uploadSelfie = 'UserDocs/uploadSelfie/';
  static const aadhaarOtp = 'UserDocs/aadhaarOtp/';
  static const aadhaarValidate = 'UserDocs/aadhaarValidate/';
  static const bankStatementDate = 'UserDocs/banstatementdate/';

  /// DashBoard Api
  static const dashBoard = 'Loan/loandetails/';
  static const loanSanction = 'Agreement/loanSaction/';
  static const mandateShow = 'Mandate/show/';
  static const loanAgreement = 'Agreement/loanAgreement/';
  static const loanSanctionPdf = 'Loan/loanSactionPdf';
  static const loanAgreeOtp = 'Loan/agreementOTP';
  static const loanAgreeOtpVerify = 'Loan/agreementOTPVerify';
  static const postNotInterested = 'Loan/notIntrested';
  static const updateMicroStatus = 'User/updateMicroStatus';
  static const checkMicroUser = 'User/checkMicroRequired';
  static const microUserGetDisclaimer = 'User/microUserGetDisclaimer';
  static const microUserPostDisclaimer = 'User/microUserPostDisclaimer';
  static const microUserSave = 'User/microUserSave';

  /// Loan Api
  static const packages = 'Loan/productList/';
  static const loanCalculator = 'Loan/loanCalculator/';
  static const applyLoan = 'Loan/applyLoan/';

  /// Repayment Api

  static const repaymentLoan = 'Loan/repayment/';
  static const loanCharges = 'Loan/loanCharges/';
  static const getLedger = 'Loan/getmisstatus/';
  static const previousLoan = 'Loan/previousLoan/';
  static const repaymentUrl = 'Payment/show/';

  /// PermissionApi
  static const permissionData = 'Permission/uploadCs/';
  static const locationTracker = 'Permission/locationTracker/';
  static const contactRefStatus = 'Permission/contactReferenceStatus/';
  static const contactRef = 'Permission/contactReference/';
  static const fcmToken = 'Permission/notification/';

  /// Mandate Video
  static const mandateVideo = 'https://green.salarynow.in/app_api/AgreementEMandateVideo.mp4';

  /// BankStatement Web View
  static const bankStatementUrl = 'StatementNetBanking/NetBanking';
}
