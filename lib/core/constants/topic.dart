// String serverUrl = ''; //8000 Deflaut 18543
String http = 'http://';

class TopicAPI {
  static String serverUrl = "";

  // static String serverUrl1 = 'http://$serverUrl';
  static String serverUrl1 = '';

  ///=================================New Topic===================================///

  static String baseUrl = "$serverUrl1/api/v1";
  static String baseUrlAuth = '$baseUrl/ncs/auth/';
  static String baseUrlUser = '$baseUrl/ncs/user/';
  static String baseUrlStaff = '$baseUrl/ncs/staff/';
  static String baseUrlRoom = '${baseUrlStaff}room/';
  static String baseUrlBed = '${baseUrlStaff}bed-switch/';

  static String login = '${baseUrlAuth}login-staff';
  static String logout = '${baseUrlAuth}logout';
  static String refreshToken = '${baseUrlAuth}refresh';
  static String getProfileData = '${baseUrlUser}get-profile-data';
  static String getPerformanceDetails = '${baseUrlUser}get-performance-details';
  static String getDashboardData = '${baseUrlStaff}get-dashboard-data';
  static String getReportData = '${baseUrlStaff}get-report-data';
  static String getRoomAll = '${baseUrlRoom}get-all';
  static String getBedAll = '${baseUrlBed}get-all';
}
