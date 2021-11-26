import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

@JsonSerializable()
class Test {
  final String? firstName;
  final String? lastName;
  final int? age;
  @JsonKey(name: 'date-of-birth')
  final DateTime? dob;
  @JsonKey(includeIfNull: false)
  final String? mob;

  Test(this.dob, this.mob, {this.firstName, this.lastName, this.age});

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}
