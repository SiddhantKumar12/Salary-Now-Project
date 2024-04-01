import 'package:get_storage/get_storage.dart';
import 'package:salarynow/form_helper/network/modal/doc_accomodation_modal.dart';
import 'package:salarynow/form_helper/network/modal/doc_address_type.dart';
import 'package:salarynow/form_helper/network/modal/salary_mode.dart';
import 'package:salarynow/form_helper/network/modal/state_modal.dart';
import 'package:salarynow/form_helper/network/modal/user_common_modal.dart';
import 'package:salarynow/registration/network/modal/employment_type.dart';
import 'package:salarynow/required_document/network/modal/selfie_modal.dart';
import 'package:salarynow/storage/local_storage_strings.dart';

import '../dashboard/network/modal/dashboard_modal.dart';
import '../form_helper/network/modal/bank_list_modal.dart';
import 'local_user_modal.dart';

class MyStorage {
  static GetStorage storage = GetStorage();
  static LocalUserModal? localUserModal;
  static DashBoardModal? dashBoardModal;
  static UserCommonModal? userCommonModal;
  static StateModal? stateModal;
  static DocAddressTypeModal? docAddressTypeModal;
  static DocAccomodationModal? docAccomodationModal;
  static SalaryModal? salaryModal;
  static BankListModal? bankListModal;
  static EmploymentTypeModal? employmentTypeModal;
  static SelfieModal? selfieModal;

  /// User Local Storage
  static setUserData(LocalUserModal localUserModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(localUserModal.toJson());
    await storage.write(MyStorageString.localUserData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.localUserData) ?? {};
    localUserModal = LocalUserModal.fromJson(value);
  }

  static LocalUserModal? getUserData() {
    Map<String, dynamic> data = storage.read(MyStorageString.localUserData) ?? {};
    localUserModal = LocalUserModal.fromJson(data);
    return localUserModal;
  }

  /// Dashboard User Data
  static setDashBoardData(DashBoardModal dashBoardModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(dashBoardModal.toJson());
    await storage.write(MyStorageString.dashBoardData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.dashBoardData) ?? {};
    dashBoardModal = DashBoardModal.fromJson(value);
  }

  static DashBoardModal? getDashBoardData() {
    Map<String, dynamic> data = storage.read(MyStorageString.dashBoardData) ?? {};
    dashBoardModal = DashBoardModal.fromJson(data);
    return dashBoardModal;
  }

  /// LocalUserCommonModal
  static setUserCommonData(UserCommonModal userCommonModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(userCommonModal.toJson());
    await storage.write(MyStorageString.localUserCommonData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.localUserCommonData) ?? {};
    userCommonModal = UserCommonModal.fromJson(value);
  }

  static UserCommonModal? getUserCommonData() {
    Map<String, dynamic> data = storage.read(MyStorageString.localUserCommonData) ?? {};
    userCommonModal = UserCommonModal.fromJson(data);
    return userCommonModal;
  }

  /// State Modal
  static setStateData(StateModal stateModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(stateModal.toJson());
    await storage.write(MyStorageString.stateData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.stateData) ?? {};
    stateModal = StateModal.fromJson(value);
  }

  static StateModal? getStateData() {
    Map<String, dynamic> data = storage.read(MyStorageString.stateData) ?? {};
    stateModal = StateModal.fromJson(data);
    return stateModal;
  }

  /// Doc Address Modal
  static setAddressModal(DocAddressTypeModal docAddressTypeModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(docAddressTypeModal.toJson());
    await storage.write(MyStorageString.docAddressTypeData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.docAddressTypeData) ?? {};
    docAddressTypeModal = DocAddressTypeModal.fromJson(value);
  }

  static DocAddressTypeModal? getAddressData() {
    Map<String, dynamic> data = storage.read(MyStorageString.docAddressTypeData) ?? {};
    docAddressTypeModal = DocAddressTypeModal.fromJson(data);
    return docAddressTypeModal;
  }

  /// Doc Accomadation Modal
  static setAccomadationModal(DocAccomodationModal docAccomodationModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(docAccomodationModal.toJson());
    await storage.write(MyStorageString.docAccomadationTypeData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.docAccomadationTypeData) ?? {};
    docAccomodationModal = DocAccomodationModal.fromJson(value);
  }

  static DocAccomodationModal? getAccomadationData() {
    Map<String, dynamic> data = storage.read(MyStorageString.docAccomadationTypeData) ?? {};
    docAccomodationModal = DocAccomodationModal.fromJson(data);
    return docAccomodationModal;
  }

  /// Doc Salary Mode Modal
  static setSalaryMode(SalaryModal salaryModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(salaryModal.toJson());
    await storage.write(MyStorageString.salaryModeData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.salaryModeData) ?? {};
    salaryModal = SalaryModal.fromJson(value);
  }

  static SalaryModal? getSalaryMode() {
    Map<String, dynamic> data = storage.read(MyStorageString.salaryModeData) ?? {};
    salaryModal = SalaryModal.fromJson(data);
    return salaryModal;
  }

  /// Bank List
  static setBankList(BankListModal bankListModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(bankListModal.toJson());
    await storage.write(MyStorageString.bankListData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.bankListData) ?? {};
    bankListModal = BankListModal.fromJson(value);
  }

  static BankListModal? getBankList() {
    Map<String, dynamic> data = storage.read(MyStorageString.bankListData) ?? {};
    bankListModal = BankListModal.fromJson(data);
    return bankListModal;
  }

  /// Employment Type List
  static setEmploymentType(EmploymentTypeModal employmentTypeModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(employmentTypeModal.toJson());
    await storage.write(MyStorageString.employmentTypeData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.employmentTypeData) ?? {};
    employmentTypeModal = EmploymentTypeModal.fromJson(value);
  }

  static EmploymentTypeModal? getEmploymentType() {
    Map<String, dynamic> data = storage.read(MyStorageString.employmentTypeData) ?? {};
    employmentTypeModal = EmploymentTypeModal.fromJson(data);
    return employmentTypeModal;
  }

  /// Selfie Type List
  static setSelfieData(SelfieModal selfieModal) async {
    Map<String, dynamic> data = Map<String, dynamic>.from(selfieModal.toJson());
    await storage.write(MyStorageString.selfieTypeData, data);
    Map<String, dynamic> value = storage.read(MyStorageString.selfieTypeData) ?? {};
    selfieModal = SelfieModal.fromJson(value);
  }

  static SelfieModal? getSelfieData() {
    Map<String, dynamic> data = storage.read(MyStorageString.selfieTypeData) ?? {};
    selfieModal = SelfieModal.fromJson(data);
    return selfieModal;
  }

  ///
  static void writeData(String key, dynamic value) async {
    storage.write(key, value);
  }

  static dynamic readData(String key) {
    return storage.read(key);
  }

  void removeFromStorage(String key) {
    storage.remove(key);
  }

  static cleanAllLocalStorage() {
    storage.erase();
  }
}
