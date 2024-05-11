import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    @Default('') String name,
    @Default('') String code,
    @Default('') String businessNumber,
    @Default('') String nameInCharge,
    @Default('') String phoneNumber,
    @Default('') String email,
    @Default('') String address,
    @Default('') String sectors,
    @Default('') String representativeProduct,
    @Default('') String explanation,
    @Default(true) bool whetherOrNotTouse,
  }) = _Customer;

  // To JSON
  const Customer._();

  // From JSON
  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
}
