import 'package:flutter/foundation.dart';
import 'package:ln_studio/src/feature/salon/models/salon.dart';

import '/src/common/utils/extensions/date_time_extension.dart';

/// Represents an employee in a salon with its properties.
@immutable
final class EmployeeModel {
  const EmployeeModel({
    required this.id,
    required this.workedDays,
    required this.clients,
    required this.address,
    required this.jobId,
    required this.salonId,
    required this.description,
    required this.dateOfEmployment,
    required this.contractNumber,
    required this.percentageOfSales,
    required this.stars,
    required this.isDismiss,
    required this.userModel,
    required this.jobModel,
    required this.salon,
    this.dismissDate,
  });

  /// UUID of employee.
  final int id;

  final int? workedDays;

  final int? clients;

  /// Residential address of employee.
  final String address;

  /// Id of employee's special skill.
  final int jobId;

  /// Id of employee's salon.
  final int salonId;

  /// Description of employee.
  final String description;

  /// Date of employment.
  final DateTime dateOfEmployment;

  /// Contract number of employee.
  final String contractNumber;

  /// Percentage of sales earned by the employee.
  final double percentageOfSales;

  /// Number of stars received by the employee.
  final int stars;

  /// Indicates whether the employee is dismissed or not.
  final bool isDismiss;

  /// Date of dismissal (if applicable).
  final DateTime? dismissDate;

  /// User associated with the employee.
  final UserModel userModel;

  /// Job place associated with the employee's special skill.
  final Specialization jobModel;

  /// Salon associated with the employee.
  final Salon salon;

  /// Returns [EmployeeModel] from [json].
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      workedDays: json['worked_days'] as int?,
      clients: json['clients'] as int?,
      address: json['address'] as String,
      jobId: json['job_id'] as int,
      salonId: json['salon_id'] as int,
      description: json['description'] as String,
      dateOfEmployment: DateTime.parse(json['date_of_employment'] as String),
      contractNumber: json['contract_number'] as String,
      percentageOfSales: json['percentage_of_sales'] as double,
      stars: json['stars'] as int,
      isDismiss: json['is_dismiss'] as bool,
      dismissDate: json['dismiss_date'] != null
          ? DateTime.parse(json['dismiss_date'] as String)
          : null,
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      jobModel: Specialization.fromJson(
        json['job'] as Map<String, dynamic>,
      ),
      salon: Salon.fromJson(json['salon'] as Map<String, dynamic>),
    );
  }

  /// Converts [EmployeeModel] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'worked_days': workedDays,
        'clients': clients,
        'address': address,
        'job_place_id': jobId,
        'salon_id': salonId,
        'description': description,
        'date_of_employment': dateOfEmployment.jsonFormat(),
        'contract_number': contractNumber,
        'percentage_of_sales': percentageOfSales,
        'stars': stars,
        'is_dismiss': isDismiss,
        'dismiss_date': dismissDate?.millisecondsSinceEpoch,
        'user': userModel.toJson(),
        'job_place': jobModel.toJson(),
        'salon': salon.toJson(),
      };

  String get fullName => '${userModel.firstName} ${userModel.lastName}';
}

/// Represents a user model.
@immutable
final class UserModel {
  const UserModel({
    required this.id,
    this.photo,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.birthDate,
    required this.isSuperuser,
    required this.isActive,
  });

  /// UUID of the user.
  final int id;

  /// User's photo as [String].
  final String? photo;

  /// Email address of the user.
  final String email;

  /// First name of the user.
  final String firstName;

  /// Last name of the user.
  final String lastName;

  /// Phone number of the user.
  final String phone;

  /// Birth date of the user.
  final DateTime birthDate;

  /// Indicator whether user is a superuser.
  final bool isSuperuser;

  /// Indicator whether user is active.
  final bool isActive;

  /// Returns [UserModel] from [json].
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      photo: json['photo'] as String?,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      isSuperuser: json['is_superuser'] as bool,
      isActive: json['is_active'] as bool,
    );
  }

  /// Converts [UserModel] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'photo': photo,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'birth_date': birthDate.jsonFormat(),
        'is_superuser': isSuperuser,
        'is_active': isActive,
      };
}

/// Representing a job place with its properties.
@immutable
final class Specialization {
  const Specialization({
    required this.id,
    required this.name,
    required this.oklad,
  });

  /// Id of the job place.
  final int id;

  /// Name of the job place.
  final String name;

  /// Salary of the job place.
  final int oklad;

  /// Returns [Specialization] from [json].
  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['id'] as int,
      name: json['name'] as String,
      oklad: json['oklad'] as int,
    );
  }

  /// Converts [Specialization] into json.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'oklad': oklad,
      };

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Specialization &&
          runtimeType == other.runtimeType &&
          id == other.id;
}
